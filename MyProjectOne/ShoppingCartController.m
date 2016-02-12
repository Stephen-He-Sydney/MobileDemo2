//
//  ShoppingCartController.m
//  MyProjectOne
//
//  Created by StephenHe on 9/18/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "ShoppingCartController.h"

@interface ShoppingCartController ()

@end

@implementation ShoppingCartController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self reLoadShoppingView];
}

-(NSArray*)getTotalKindsShoppingCart
{
    NSUserDefaults* totalKinds = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary* currTotal = [totalKinds objectForKey:@"shoppingCarts"];
    
    return [currTotal allValues];//convert dic to array
}

-(void)reLoadShoppingView
{
    updateTotalPrice = 0;
    changeOfTotalPrice = 0;
    
    commShoppingCart = [[CommonShoppingCartView alloc]init];
    normalShoppingCart = [[NormalShoppingCart alloc]init];
    emptyShoppingCart = [[EmptyShoppingCart alloc]init];
    
    [self initializeAttributes];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithCustomView:[self bindNavLeftBarButton]];
    
    [self setShoppingCartViews];
    
    [self reflectNavigationBarRightBtn];

}

-(void)viewWillAppear:(BOOL)animated
{
    for (UIView* subView in self.view.subviews) {
        [subView removeFromSuperview];
    }
    
    [self reLoadShoppingView];
    
    [self.tabBarController.tabBar.items[3] setBadgeValue:nil];
    
    [self resetCountOfShoppingCart];
}

-(void)resetCountOfShoppingCart
{
    NSUserDefaults* updateQty = [NSUserDefaults standardUserDefaults];
    [updateQty setInteger:0 forKey:@"totalShoppingCart"];
}

-(void)setShoppingCartViews
{
    [self setAllStaticViews:001];
    
    [self loadSubViews];

    fullSizeView.hidden = YES;
    
    if ([self verifyLoginStatus] == YES){
        [self goToShoppingView];
    }
}

-(void)goToShoppingView
{
    loginView.hidden = YES;
    fullSizeView.hidden = NO;
    self.navigationItem.title = @"购物车";
    self.navigationItem.rightBarButtonItem = nil;
}

-(void)loadSubViews
{
    normalShoppingCartView = [normalShoppingCart getCurrentContentView:self.navigationController];
    emptyShoppingCartView = [emptyShoppingCart getCurrentContentView:self.navigationController];
    fullSizeView = [commShoppingCart getCurrentContentView:self.navigationController];
    
    [fullSizeView addSubview:normalShoppingCartView];
    [fullSizeView addSubview:emptyShoppingCartView];
    [self.view addSubview:fullSizeView];
    
    [self loadEmptyShoppingCartComponents];
    
    normalShoppingCartView.hidden = YES;
    if ([self getTotalKindsShoppingCart].count > 0)
    {
        normalShoppingCartView.hidden = NO;
        emptyShoppingCartView.hidden = YES;
        isSelectAll = NO;
        
        [self loadTableView];
        [self loadNormalShoppingCartComponents];
        
        //初始化都未选中,所以全选为未选
        normalShoppingCart.totalPriceVal.text =  @"￥0.00";
    }
}

-(void)loadEmptyShoppingCartComponents
{
    [emptyShoppingCartView addSubview:[emptyShoppingCart getProdImage:self.navigationController]];
    [emptyShoppingCartView addSubview:[emptyShoppingCart getHintLabel]];
    
    UIButton* goShoppingBtn = [emptyShoppingCart getGoShoppingButton];
    [goShoppingBtn addTarget:self action:@selector(goShopping:) forControlEvents:UIControlEventTouchUpInside];
    
    [emptyShoppingCartView addSubview:goShoppingBtn];
}

-(void)loadTableView
{
    //immutable array changed into mutable array
    shoppingCartArray = [NSMutableArray arrayWithArray:[self getTotalKindsShoppingCart]];

    /*******************************************************/
    //[shoppingCartArray addObjectsFromArray:[self getTotalKindsShoppingCart]];
    
    
    for (int i = 0; i < shoppingCartArray.count; i++) {
        [shoppingCartArray[i] setObject:@(NO) forKey:@"isTicked"];
    }
    
    //加载表视图
    commController = [[CommonControllersView alloc]init];
    shoppingCartTView = [commController getCurrentTableView:normalShoppingCartView];
    shoppingCartTView.delegate = self;
    shoppingCartTView.dataSource = self;
    [normalShoppingCartView addSubview:shoppingCartTView];
}

-(void)loadNormalShoppingCartComponents
{
    [normalShoppingCart getSelectAllButton:normalShoppingCartView];
    [normalShoppingCart getSelectAllTxt:normalShoppingCartView];
    
    [normalShoppingCart getTotalPriceNumber];
    [normalShoppingCart getTotalPriceTitle];
    [normalShoppingCart getGoCheckOutBtn];
    
    [normalShoppingCart.selectAllBtn addTarget:self action:@selector(selectAllEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    [normalShoppingCart.checkOutBtn addTarget:self action:@selector(goToCheckOutView:) forControlEvents:UIControlEventTouchUpInside];
    
    [fullSizeView addSubview:normalShoppingCart.selectAllBtn];
    [fullSizeView addSubview:normalShoppingCart.selectAllTxt];
    [fullSizeView addSubview:normalShoppingCart.totalPriceVal];
    [fullSizeView addSubview:normalShoppingCart.totalPriceTxt];
    [fullSizeView addSubview:normalShoppingCart.checkOutBtn];
}

-(void)goToCheckOutView:(id)sender
{
    checkOutArry = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < shoppingCartArray.count; i++) {
        if ((BOOL)[shoppingCartArray[i][@"isTicked"] boolValue]==YES)
        {
            [checkOutArry addObject:shoppingCartArray[i]];
        }
    }

    if ([checkOutArry count] > 0)
    {
        
        if ([CommonFunction readUserDefaultsForUserInfo].count > 0)
        {
            NSUserDefaults* checkOutDefaults = [NSUserDefaults standardUserDefaults];
            [checkOutDefaults setObject:checkOutArry forKey:@"checkOut"];
            
            CheckOutController* checkOutCtrl = [[CheckOutController alloc]init];
            [self.navigationController pushViewController:checkOutCtrl animated:NO];
        }
        else
        {
            [self promptEditingAddressDialog:@"未填写个人信息!"];
        }
    }
    else
    {
        [CommonControllersView promptSingleButtonWarningDialog:@"请选中至少一件商品!"];
    }
}

-(void)promptEditingAddressDialog:(NSString*)msg
{
    UIAlertView* warnAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"填写信息" otherButtonTitles:@"放弃结算",nil];
    
    [warnAlert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //只有alertView声明在当前类以内,该方法才能被调用
    if (buttonIndex == 0)
    {
        MemberCenterController* memberCenterCtrl = [[MemberCenterController alloc]init];
        memberCenterCtrl.currState = shoppingcartPage;
        memberCenterCtrl.checkOutArry = checkOutArry;
        [self.navigationController pushViewController:memberCenterCtrl animated:NO];
    }
}

-(void)selectAllEvent:(id)sender
{
    updateTotalPrice = 0;//防止重复加之前的数
    UIButton* btn = (UIButton*)sender;
    if ([UIImagePNGRepresentation([btn backgroundImageForState:UIControlStateNormal]) isEqualToData:UIImagePNGRepresentation([UIImage imageNamed:@"购物车_13"])])
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"购物车_03"] forState:UIControlStateNormal];
        isSelectAll = YES;
    }
    else
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"购物车_13"] forState:UIControlStateNormal];
        isSelectAll = NO;
    }
    normalShoppingCart.totalPriceVal.text = [self getCurrTotalAmount];
    
    [shoppingCartTView reloadData];
}

-(NSString*)getCurrTotalAmount
{
    double totalPrice = 0;
    
    if (isSelectAll == YES)
    {
        for (int i = 0; i < shoppingCartArray.count; i++) {
            
            [shoppingCartArray[i] setObject:@(YES) forKey:@"isTicked"];
            
            NSString* priceStr = [CommonFunction trimString:shoppingCartArray[i][@"cur_price_format"]];
            double price = (double)[[priceStr substringFromIndex:1]doubleValue];
            double qty = (double)[shoppingCartArray[i][@"quantity"] integerValue];
            totalPrice += price * qty;
        }
        totalPrice += changeOfTotalPrice;
    }
    else
    {
        for (int i = 0; i < shoppingCartArray.count; i++) {
            [shoppingCartArray[i] setObject:@(NO) forKey:@"isTicked"];
        }
        totalPrice = 0;
    }
    updateTotalPrice = totalPrice;
    
    return [NSString stringWithFormat:@"￥%.2lf",totalPrice];
}

#pragma mark - 表视图
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [shoppingCartArray count] > 0? [shoppingCartArray count]:0;
}

-(ShoppingCartTableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifer = @"currCell";
    ShoppingCartTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell){
        cell = [[ShoppingCartTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer
                ];
        cell.prodQuantity.text =[NSString stringWithFormat:@"%ld",[shoppingCartArray[indexPath.row][@"quantity"] integerValue]];
        
        cell.prodDescription.text = shoppingCartArray[indexPath.row][@"title"];
        
        cell.prodPriceVal.text = shoppingCartArray[indexPath.row][@"cur_price_format"];

    }
    
    cell.mainImage.image = [UIImage imageWithData:shoppingCartArray[indexPath.row][@"imgData"]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [self reflectButtonChange:cell WithIndexRow:indexPath.row];
    
    cell = [self keepTickButtonStatus:cell WithIndexRow:indexPath.row];
    
    return cell;
}

-(void)reflectButtonChange:(ShoppingCartTableViewCell*) cell WithIndexRow:(long)indexRow
{
    if (isSelectAll == YES)
    {
        [self buttonChangeBySelectAll:cell];
    }
    else if (isSelectAll == NO)
    {
        [self buttonChangeByDeSelectAll:cell];
    }

    [self buttonChangeByCellButton:cell WithIndexRow:indexRow];// reserve space for block call back
}

-(ShoppingCartTableViewCell*)keepTickButtonStatus:(ShoppingCartTableViewCell*) cell WithIndexRow:(long)indexRow
{
    for (int i = 0; i < shoppingCartArray.count; i++)
    {
        if ([shoppingCartArray[i][@"productID"]isEqualToString:shoppingCartArray[indexRow][@"productID"]])
        {
            if ((BOOL)[shoppingCartArray[i][@"isTicked"]boolValue]==YES)
            {
                [cell.tickedBtn setBackgroundImage:[UIImage imageNamed:@"购物车_03"] forState:UIControlStateNormal];
                return cell;
            }
            break;
        }
    }
    return cell;
}

-(void)buttonChangeBySelectAll:(ShoppingCartTableViewCell*) cell
{
    [cell.tickedBtn setBackgroundImage:[UIImage imageNamed:@"购物车_03"] forState:UIControlStateNormal];
}

-(void)buttonChangeByDeSelectAll:(ShoppingCartTableViewCell*) cell
{
    [cell.tickedBtn setBackgroundImage:[UIImage imageNamed:@"购物车_13"] forState:UIControlStateNormal];
}

-(void)buttonChangeByCellButton:(ShoppingCartTableViewCell*) cell WithIndexRow:(long)indexRow
{
    //单个打钩按钮
    cell.addTotalPrice = ^(double addTotalPrice){
        
        updateTotalPrice += addTotalPrice;
        normalShoppingCart.totalPriceVal.text = [NSString stringWithFormat:@"￥%.2lf",updateTotalPrice];
        
        if (addTotalPrice > 0)
        {
            [self changeTagByTickButton:shoppingCartArray[indexRow][@"productID"] WithIsTicked:YES];
        }
        else
        {
            [self changeTagByTickButton:shoppingCartArray[indexRow][@"productID"] WithIsTicked:NO];
        }
    };
    //加减按钮
    cell.changeTotalPrice = ^(double changeTotalPrice){

        updateTotalPrice += changeTotalPrice;
        changeOfTotalPrice+= changeTotalPrice;//用来给全选更新
        normalShoppingCart.totalPriceVal.text = [NSString stringWithFormat:@"￥%.2lf",updateTotalPrice];
        
        if (changeTotalPrice > 0)
        {
            [self changeQuantityByPlusMinusBtn:shoppingCartArray[indexRow][@"productID"] WithIsTicked:YES];
        }
        else
        {
            [self changeQuantityByPlusMinusBtn:shoppingCartArray[indexRow][@"productID"] WithIsTicked:NO];
        }
    };
}

-(void)changeTagByTickButton:(NSString*)productID WithIsTicked:(BOOL)isTicked
{
    for (int i = 0; i < shoppingCartArray.count; i++)
    {
        if ([shoppingCartArray[i][@"productID"]isEqualToString:productID])
        {
            if (isTicked == YES)
            {
                [shoppingCartArray[i] setObject:@(YES) forKey:@"isTicked"];
            }
            else
            {
                [shoppingCartArray[i] setObject:@(NO) forKey:@"isTicked"];
            }
            break;
        }
    }
}

-(void)changeQuantityByPlusMinusBtn:(NSString*)productID WithIsTicked:(BOOL)isTicked
{
    for (int i = 0; i < shoppingCartArray.count; i++)
    {
        if ([shoppingCartArray[i][@"productID"]isEqualToString:productID])
        {
            int currCount =(int)[shoppingCartArray[i][@"quantity"] integerValue];
            if (isTicked == YES)
            {
                currCount++;
            }
            else
            {
                currCount--;
            }
            [shoppingCartArray[i] setObject:@(currCount) forKey:@"quantity"];
            break;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return normalShoppingCartView.frame.size.height/3+20;
}

-(void)goShopping:(id)sender
{
    [self goToHomePage];
}

-(void)goToHomePage
{
    [self.parentViewController.tabBarController setSelectedIndex:0];
    [self.tabBarController.viewControllers objectAtIndex:0];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomHttpRequest* customHttp = [[CustomHttpRequest alloc]init];
    if ([customHttp IsCurrentInternentReached] == YES)
    {
        CommonFunction* commFunc = [[CommonFunction alloc]init];
        
        [commFunc sendPostByCurrentProductID:shoppingCartArray[indexPath.row][@"productID"] WithImgData:shoppingCartArray[indexPath.row][@"imgData"] WithClassName:@"ProductDetailController" WithCustomHttp:customHttp WithNavigation:self.navigationController];
    }
    else
    {
        [CommonControllersView promptSingleButtonWarningDialog:@"网络不给力，请稍候!"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
