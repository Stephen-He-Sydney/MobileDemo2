//
//  HomePageController.m
//  MyProjectOne
//
//  Created by StephenHe on 9/10/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "HomePageController.h"


@interface HomePageController ()

@end

@implementation HomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationItem.title = @"恒融汇通";
    
    [self bindMenuButtons];
    
    [self bindScrollView];
    
    [self bindPageControl];
   
    [self loadAllStaticView];
    
    [self sendCorrespondingUrl];
    
    [self setTotalCountShoppingCart];
    
    [self setTotalDetailShoppingCart];
    
    prodToCheckOut = [[NSMutableDictionary alloc]init];

}

-(void)viewWillAppear:(BOOL)animated
{
    totalShoppingCart = 0;
}

-(void)setTotalCountShoppingCart
{
    totalShoppingCart = [self getExistingCountShoppingCart];
    
    if (totalShoppingCart > 0)
    {
        [self.tabBarController.tabBar.items[3] setBadgeValue:[NSString stringWithFormat:@"%d", totalShoppingCart]];
    }
}

-(void)setTotalDetailShoppingCart
{
    prodToShoppingCart =[[NSMutableDictionary alloc]init];
    if ([self getTotalKindsShoppingCart].count > 0)
    {
        prodToShoppingCart = [self getTotalKindsShoppingCart];
    }
}

#pragma mark - 添加菜单按钮绑定事件
-(void) bindMenuButtons
{
    comm = [[CommonHomePageView alloc]init];
    menuBtns = [comm setMenuBar:self.navigationController];
    
    for (int i = 0; i < menuBtns.count; i++) {
        [menuBtns[i] setTag:i];
        
        [menuBtns[i] addTarget:self action:@selector(mainPageMenuAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:menuBtns[i]];
    }
    btnIndex = 0;
    [comm highlightCurrMenuBtn:btnIndex];
}

#pragma mark - 菜单点击监听事件
-(void)mainPageMenuAction:(id)sender
{
    btnIndex = (int)[sender tag];
    
    [self toggleViewContainer];
    
    [comm highlightCurrMenuBtn:btnIndex];
}

#pragma mark - 不同视图间切换
-(void)controlDifferentViewStatus
{
    pageIdx = 1;// ensure the index = 1 when loading new page
    
    switch (btnIndex) {
        case 0:
            homePageView.hidden = NO;
            quickBuyView.hidden = YES;
            bestSaleView.hidden = YES;
            break;
        case 1:
            homePageView.hidden = YES;
            quickBuyView.hidden = NO;
            bestSaleView.hidden = YES;
            break;
        case 2:
            homePageView.hidden = YES;
            quickBuyView.hidden = YES;
            bestSaleView.hidden = NO;
            break;
        default:
            break;
    }
}

#pragma mark - 切换不同视图前执行网络检测
-(void)toggleViewContainer
{
    CustomHttpRequest* customHttp = [[CustomHttpRequest alloc]init];
    
    [self controlDifferentViewStatus];
    
    if ([customHttp IsCurrentInternentReached] == NO)
    {
        if (countReload == 0)//only alert once and reload once
        {
            [self promptSingleButtonWarningDialog:@"网络不给力，请稍候!"];
        }
    }
    else
    {
        [self prepareLoadingData:customHttp];
    }
}

#pragma mark - 判断当前视图是否需要加载数据
-(void)prepareLoadingData:(CustomHttpRequest*)customHttp
{
    switch (btnIndex) {
        case 0:
            if (homePageArray.count == 0)
            {
                [self sendCorrespondingUrl];
            }
            else if (homePageArray.count > 0
                     && [customHttp IsCurrentWIFIReached] == YES
                     && [homePageArray count] != homePageImage.count)
            {
                [self removeAllSubViews:homeContent];
                
                [self sendCorrespondingUrl];
            }
        break;
            
        case 1:
            if (quickBuyArray.count == 0)
            {
                [self sendCorrespondingUrl];
            }
            else if (quickBuyArray.count > 0
                     && [customHttp IsCurrentWIFIReached] == YES
                     && [quickBuyArray count] != quickBuyImage.count)
            {
                [self removeAllSubViews:quickBuyContent];
                
                [self sendCorrespondingUrl];
            }

        break;
            
        case 2:
            if (bestSaleArray.count == 0)
            {
                [self sendCorrespondingUrl];
            }
            else if (bestSaleArray.count > 0
                     && [customHttp IsCurrentWIFIReached] == YES
                     && [bestSaleArray count] != bestSaleImage.count)
            {
                [self removeAllSubViews:bestSaleContent];
                
                [self sendCorrespondingUrl];
            }
        break;
            
        default:
        break;
    }
}

#pragma mark - 滚动视图绑定根视图
-(void)bindScrollView
{
    advScrollView = [comm setAdvScrollViewContainer:self.navigationController];
    
    advScrollView.self.delegate = self;
    
    [self.view addSubview:advScrollView];
    
    totalScrollViewPage = comm.totalPage;
    
    pageControl = [comm setTimerAndPageControl];
}

-(void)bindPageControl
{
    advAutoTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changeTime) userInfo:nil repeats:YES];
    
    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:pageControl];
}

#pragma mark - 手动点击滚动广告, 和自动滚动无关
-(void)changePage:(id)sender
{
    UIPageControl* curr = sender;
    
    [advScrollView setContentOffset:CGPointMake((advScrollView.frame.size.width)*curr.currentPage,0) animated:YES];
}

-(void)changeTime//:(id)sender
{
    //index start from 0

    if (scrollViewPageIndex < totalScrollViewPage-1) scrollViewPageIndex++;
    else scrollViewPageIndex = 0;
    
    [advScrollView setContentOffset:CGPointMake((advScrollView.frame.size.width)*scrollViewPageIndex, 0) animated:YES];
}

#pragma mark - 自动监听滚动视图事件
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint currStartPoint = scrollView.contentOffset;
    
    //注意这里要被x整除
    if((int)currStartPoint.x % (int)(self.view.frame.size.width) == 0)
    {
        pageControl.currentPage =(int)currStartPoint.x / (int)self.view.frame.size.width;
        
        scrollViewPageIndex = (int) pageControl.currentPage;
    }
}
/* End of Scroll view */

#pragma mark - 加载当前子视图容器
-(void)loadAllStaticView
{
    pageIdx = 1;
    countReload = 0;
    
    homePage = [[HomeView alloc]init];
    quickBuy = [[QuickBuyView alloc]init];
    bestSale = [[BestSaleView alloc]init];

    homePageArray = [[NSMutableArray alloc]init];
    quickBuyArray = [[NSMutableArray alloc]init];
    bestSaleArray = [[NSMutableArray alloc]init];
    
    homePageView = [homePage getCurrentContentView:pageControl];
    quickBuyView = [quickBuy getCurrentContentView:pageControl];
    bestSaleView = [bestSale getCurrentContentView:pageControl];
    
    quickBuyView.hidden = YES;
    bestSaleView.hidden = YES;
    
    hprodBtn = [homePage getProductMainButton];
    qprodBtn = [quickBuy getProductMainButton];
    bprodBtn = [bestSale getProductMainButton];
    
    [homePageView addSubview:hprodBtn];
    [quickBuyView addSubview:qprodBtn];
    [bestSaleView addSubview:bprodBtn];
    
    homeContent = [homePage getViewDisplayContainer:hprodBtn];
    quickBuyContent =[quickBuy getViewDisplayContainer:qprodBtn];
    bestSaleContent = [bestSale getViewDisplayContainer:bprodBtn];
    
    [homePageView addSubview:homeContent];
    [quickBuyView addSubview:quickBuyContent];
    [bestSaleView addSubview:bestSaleContent];
    
    [self.view addSubview:homePageView];
    [self.view addSubview:quickBuyView];
    [self.view addSubview:bestSaleView];
}

#pragma mark - 加载大的活动指示器
-(void)sendCorrespondingUrl
{
    //加载大活动指示器，1秒后自动关闭
    MBProgressHUD* progressMark = [[MBProgressHUD alloc]initWithView:self.view];
    
    //[progressMark setDimBackground:YES];
    
    [progressMark show:YES];
    [self.view addSubview:progressMark];
    
    [progressMark hide:YES afterDelay:1.5];
    
    CustomHttpRequest* customHttp = [[CustomHttpRequest alloc]init];
    if ([customHttp IsCurrentInternentReached] == YES)
    {
        [self prepareSendingRequest];
    }
    else
    {
        if (countReload == 0)//only alert once and reload once
        {
            [self promptSingleButtonWarningDialog:@"网络不给力，请稍候!"];
        }
    }
}

#pragma mark - 准备对应的URL参数,获取对应视图数据
-(void)prepareSendingRequest
{
    switch (btnIndex) {
        case 0:
            homePage.serverUrl = @"http://112.74.105.205/upload/mapi/index.php?act=goods_list";
            homePage.paramUrl = [NSString stringWithFormat:@"r_type=1&is_new=1&page=%d",pageIdx];
            [self getDynamicData:homePage];
            break;
        case 1:
            quickBuy.serverUrl = @"http://112.74.105.205/upload/mapi/index.php?act=goods_list";
            quickBuy.paramUrl = [NSString stringWithFormat:@"r_type=1&is_promote=1&page=%d",pageIdx];
            [self getDynamicData:quickBuy];
            break;
        case 2:
            bestSale.serverUrl = @"http://112.74.105.205/upload/mapi/index.php?act=goods_list";
            bestSale.paramUrl = [NSString stringWithFormat:@"r_type=1&is_hot=1&page=%d",pageIdx];
            [self getDynamicData:bestSale];
            break;
        default:
            break;
    }
}

-(void)promptSingleButtonWarningDialog:(NSString*)msg
{
    UIAlertView* warnAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    warnAlert.tag = 1;
    [warnAlert show];
}

#pragma mark - 弹出框点击按钮事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1 && buttonIndex == 0 && countReload == 0)
    {
        countReload++;

        [self sendCorrespondingUrl];// try to load data again
    }
    else if (alertView.tag == 2 && buttonIndex == 0)
    {
        MemberCenterController* memberCenterCtrl = [[MemberCenterController alloc]init];
        memberCenterCtrl.currState = quickBuyPage;
        memberCenterCtrl.checkOutArry = checkOutArry;
        [self.navigationController pushViewController:memberCenterCtrl animated:NO];
    }
}

#pragma mark - 获取子视图的服务器端数据
-(void)getDynamicData:(CommonHomePageView*)commView
{
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:YES];
    
    CustomHttpRequest* customHttp = [[CustomHttpRequest alloc]init];
    if ([customHttp IsCurrentInternentReached] == YES)
    {
        [customHttp fetchResponseByPost:commView.serverUrl WithParameter:commView.paramUrl WithPassSuccessResponse:^(NSDictionary *info) {
        
            responseJson = [NSMutableDictionary dictionaryWithDictionary:info];
            if (![responseJson objectForKey:@"fail"])
            {
                if (btnIndex == 0)
                {                    
                    [self LoadHomePageData:customHttp];
                }
                
                else if (btnIndex == 1)
                {
                    [self LoadQuickBuyData:customHttp];
                }
                else if (btnIndex == 2)
                {
                    [self LoadBestSaleData:customHttp];
                }
            }
            else {
                [self promptSingleButtonWarningDialog:@"服务器连接超时,请检查网络!"];
            }
        }];
    }
}

#pragma mark - 更新对应数组的后台数据
-(void)collectAllItems:(NSDictionary*)currResponse WithSourceArray:(NSMutableArray*)currArray
{
    if (currResponse.count > 0)
    {
        if (pageIdx > 1) {
            //执行上拉操作,在之前的内容后面追加;
            for (NSDictionary* aproduct in currResponse[@"item"]) {
                [currArray addObject:aproduct];
            }
        }
        else
        {
            //下拉刷新操作(永远只加载第一页)
            [currArray removeAllObjects];
            for (NSDictionary* aproduct in currResponse[@"item"]) {
                [currArray addObject:aproduct];
            }
        }
    }
}

#pragma mark - 删除当前容器中所有子视图
-(void)removeAllSubViews:(UIView*)CurrentContainer
{
    for (UIView* subView in CurrentContainer.subviews) {
        [subView removeFromSuperview];
    }
}

#pragma mark - 加载首页数据
-(void)LoadHomePageData:(CustomHttpRequest*) customHttp
{
    [self collectAllItems:responseJson WithSourceArray:homePageArray];
    homeViewCView = [homePage getCollectionView:homeContent];
    homeViewCView.delegate = self;
    homeViewCView.dataSource = self;
    
    homeViewCView.tag = 001;//用来和热卖做点击事件区分
    
    [self removeAllSubViews:homeContent];
    
    [homeContent addSubview:homeViewCView];
    
    [homeViewCView addHeaderWithTarget:self action:@selector(dragDownRefreshing:)];
    [homeViewCView addFooterWithTarget:self action:@selector(pullUpRefreshing:)];
    
    if([customHttp IsCurrentWIFIReached] == YES && homePageArray.count > 0)
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            homePageImage = [self getAllImages:homePageArray];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [homeViewCView reloadData];
            });
        });
    }
}

#pragma mark - 加载秒杀专区数据
-(void)LoadQuickBuyData:(CustomHttpRequest*) customHttp
{
    [self collectAllItems:responseJson WithSourceArray:quickBuyArray];
    commController = [[CommonControllersView alloc]init];
    quickBuyTView = [commController getCurrentTableView:quickBuyContent];
    quickBuyTView.delegate = self;
    quickBuyTView.dataSource = self;
    
    [self setAllProdsRemainningSeconds:[quickBuyArray count]];
    
    [self removeAllSubViews:quickBuyContent];
    
    [countDownTimer invalidate];
    countDownTimer = nil;
    
    [self startCountDown];
    
    [quickBuyContent addSubview:quickBuyTView];
    
    [quickBuyTView addHeaderWithTarget:self action:@selector(dragDownRefreshing:)];
    [quickBuyTView addFooterWithTarget:self action:@selector(pullUpRefreshing:)];
    
    if([customHttp IsCurrentWIFIReached] == YES && quickBuyArray.count > 0)
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            quickBuyImage = [self getAllImages:quickBuyArray];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [quickBuyTView reloadData];
            });
        });
    }
}

#pragma mark - 加载热卖专区数据
-(void)LoadBestSaleData:(CustomHttpRequest*) customHttp
{
    [self collectAllItems:responseJson WithSourceArray:bestSaleArray];
    bestSaleCView = [bestSale getCollectionView:bestSaleContent];
    bestSaleCView.delegate = self;
    bestSaleCView.dataSource = self;
    
    bestSaleCView.tag = 002;//用来和首页做点击事件区分
    
    [self removeAllSubViews:bestSaleContent];
    
    [bestSaleContent addSubview:bestSaleCView];
    
    [bestSaleCView addHeaderWithTarget:self action:@selector(dragDownRefreshing:)];
    [bestSaleCView addFooterWithTarget:self action:@selector(pullUpRefreshing:)];
    
    if([customHttp IsCurrentWIFIReached] == YES && bestSaleArray.count > 0)
    {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            bestSaleImage = [self getAllImages:bestSaleArray];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [bestSaleCView reloadData];
            });
        });
    }
}

#pragma mark - 下拉(表，集合)视图事件
-(void)dragDownRefreshing:(id)sender
{
    //下拉是获取第一页
    pageIdx = 1;
    [self prepareSendingRequest];
}

#pragma mark - 上拉(表，集合)视图事件
-(void)pullUpRefreshing:(id)sender
{
    //上提是获取第一页开始的后几页数据,这里page++
    pageIdx++;
    [self prepareSendingRequest];
}

#pragma mark - 设置商品倒计时随机数做截止时间
-(NSMutableArray*)setAllProdsRemainningSeconds:(long)totalNumOfItems
{
    prodsRemainningSeconds = [[NSMutableArray alloc]init];
    for (int i = 0; i < totalNumOfItems; i++) {
        int lowerBound = 555;
        int upperBound = 888;
        int rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
        [prodsRemainningSeconds addObject:@(rndValue)];
    }
    
    return prodsRemainningSeconds;
}

#pragma mark - 获得当前视图的所有图片
-(NSMutableArray*)getAllImages:(NSMutableArray*)currJson
{
    NSMutableArray* imageData = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < [currJson count]; i++) {
        NSString* imgUrl = currJson[i][@"img"];
        
        CustomHttpRequest* customHttp = [[CustomHttpRequest alloc]init];
        
        NSDictionary* imgDic = @{[NSString stringWithFormat:@"%ld",[currJson[i][@"goods_id"]integerValue]] :[customHttp fetchImageData:imgUrl]};
        
        [imageData addObject:imgDic];
    }
    
    return imageData;
}

#pragma mark - 集合视图
/* CollectionView */
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return btnIndex==0?[homePageArray count]:[bestSaleArray count];
}

-(CustomCollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    switch (collectionView.tag) {
    
    CustomCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionView" forIndexPath:indexPath];
    
    cell.prodDesp.text = btnIndex==0?homePageArray[indexPath.row][@"title"]:bestSaleArray[indexPath.row][@"title"];
    
    cell.prodPrice.text = btnIndex==0?homePageArray[indexPath.row][@"cur_price"]:bestSaleArray[indexPath.row][@"cur_price"];

    if (btnIndex == 0)
    {
        cell.mainImage.image = [homePageImage count]==[homePageArray count]?
        [UIImage imageWithData:homePageImage[indexPath.row][homePageArray[indexPath.row][@"goods_id"]]]:[UIImage imageNamed:@"noimage"];
    }
    else
    {
        cell.mainImage.image = [bestSaleImage count]==[bestSaleArray count]?
        [UIImage imageWithData:bestSaleImage[indexPath.row][bestSaleArray[indexPath.row][@"goods_id"]]]:[UIImage imageNamed:@"noimage"];
    }
    return cell;
}

#pragma mark - 表视图
/* TableView */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [quickBuyArray count];
}

-(QuickBuyTableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    long remainMins = 0;
    long remainSeconds = 0;
    
    remainMins = [prodsRemainningSeconds[indexPath.row] integerValue]/60;
    remainSeconds = [prodsRemainningSeconds[indexPath.row] integerValue]%60;
    
    remainMins = remainMins > 0? remainMins:0;
    remainSeconds = remainSeconds > 0? remainSeconds:0;
    
    static NSString* cellIdentifer = @"currCell";
    QuickBuyTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell){
        cell = [[QuickBuyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer
                ];
        
        [cell setProdView:quickBuyContent];
        [cell setHalfTableView];
        [cell setRestOfTableView];
        [cell setMainImage];
        [cell setQtyAlreadyBought:@"9999"];
        [cell setProductRightInfo:quickBuyArray[indexPath.row][@"title"] AndProdPrice:quickBuyArray[indexPath.row][@"ori_price_format"] AndQuickBuyPrice:quickBuyArray[indexPath.row][@"cur_price_format"] AndRemainQty:@"444"];
        
        [cell addBottomHalfComponents];
        
        NSMutableArray* purchaseButtons = [cell setTwoBtns];
       
        [purchaseButtons[0] setTag:[quickBuyArray[indexPath.row][@"goods_id"] integerValue]];
        [purchaseButtons[0] addTarget:self action:@selector(instantPurchaseClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [purchaseButtons[1] setTag:[quickBuyArray[indexPath.row][@"goods_id"] integerValue]];
        [purchaseButtons[1] addTarget:self action:@selector(addToShoppingCart:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    cell.prodImage.image =[quickBuyImage count] == [quickBuyArray count]?[UIImage imageWithData:quickBuyImage[indexPath.row][quickBuyArray[indexPath.row][@"goods_id"]]]:[UIImage imageNamed:@"noimage"];
    
    cell.remainMins.text = [NSString stringWithFormat:@"%ld",remainMins];
    cell.remainSecond.text = [NSString stringWithFormat:@"%ld",remainSeconds];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)instantPurchaseClick:(id)sender
{
    tmpDic = [[NSMutableDictionary alloc]init];
    int productID = (int)[sender tag];
    
    //删除userDefaults用
    
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"checkOut"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    
    NSString* currKey = [NSString stringWithFormat:@"%d",productID];
    
    CommonFunction* commFunc = [[CommonFunction alloc]init];
    
    [commFunc saveSelectedProducts:productID Withkey:currKey WithItemDict:prodToCheckOut WithSourceArry:quickBuyArray WithImageArry:quickBuyImage];
    
    [self saveProductsToCheckOut];
    
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

-(void)promptEditingAddressDialog:(NSString*)msg
{
    UIAlertView* warnAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"填写信息" otherButtonTitles:@"放弃结算",nil];
    
    warnAlert.tag = 2;
    
    [warnAlert show];
}

-(void)saveProductsToCheckOut
{
    /* Convert improper dic to array */
    NSArray* keys = [prodToCheckOut allKeys];
    [prodToCheckOut[keys[0]] setObject:keys[0] forKey:@"productID"];
    
    NSUserDefaults* checkOutProds = [NSUserDefaults standardUserDefaults];
    checkOutArry = [[NSMutableArray alloc]init];
    [checkOutArry addObject:prodToCheckOut[keys[0]]];
    
    [checkOutProds setObject:checkOutArry forKey:@"checkOut"];
}

-(void)addToShoppingCart:(id)sender
{
    tmpDic = [[NSMutableDictionary alloc]init];
    int productID = (int)[sender tag];

    //NSLog(@"当前产品ID:%d",productID);
    
    //删除userDefaults用
//    
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shoppingCarts"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSString* currKey = [NSString stringWithFormat:@"%d",productID];
    
    if ([prodToShoppingCart objectForKey:currKey])
    {
         //只更新数量
        [self incrementSelectedProdsQty:currKey WithItemArray:prodToShoppingCart];
    }
    else
    {
        CommonFunction* commFunc = [[CommonFunction alloc]init];
        
        [commFunc saveSelectedProducts:productID Withkey:currKey WithItemDict:prodToShoppingCart WithSourceArry:quickBuyArray WithImageArry:quickBuyImage];
    }
    [self saveProductsToShoppingCart];
    
    [self setShoppingCartQuantity];
}

-(void)incrementSelectedProdsQty:(NSString*)currKey WithItemArray:(NSMutableDictionary*)itemArry
{
    int currCount = (int)[itemArry[currKey][@"quantity"] integerValue];
    currCount++;
    [itemArry[currKey] setObject:@(currCount) forKey:@"quantity"];
}

-(void)saveProductsToShoppingCart
{
    NSUserDefaults* shoppingCarts = [NSUserDefaults standardUserDefaults];
    [shoppingCarts setObject:prodToShoppingCart forKey:@"shoppingCarts"];
}

-(NSMutableDictionary*)getTotalKindsShoppingCart
{
    NSUserDefaults* totalKinds = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary* currTotal = [totalKinds objectForKey:@"shoppingCarts"];
    
    return currTotal;
}

-(void)setShoppingCartQuantity
{
    totalShoppingCart++;
    [self.tabBarController.tabBar.items[3] setBadgeValue:[NSString stringWithFormat:@"%d", totalShoppingCart]];
    
    [self updateCountOfShoppingCart];
}

-(void)updateCountOfShoppingCart
{
    NSUserDefaults* updateQty = [NSUserDefaults standardUserDefaults];
    [updateQty setInteger:totalShoppingCart forKey:@"totalShoppingCart"];
}

-(int)getExistingCountShoppingCart
{
    NSUserDefaults* shoppingCartQty = [NSUserDefaults standardUserDefaults];
    return (int)[shoppingCartQty integerForKey:@"totalShoppingCart"];
}

#pragma mark - 表视图行高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return quickBuyContent.frame.size.height/7*6;
}

#pragma mark - 表视图即将展示单元格事件
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
}

#pragma mark - 集合视图即将展示单元格事件
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
}

#pragma mark - 打开系统计数器调用倒计时
-(void)startCountDown
{
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
}

#pragma mark - 系统倒计时定时刷新视图
-(void)timerFired
{
    for (int i = 0; i < [prodsRemainningSeconds count]; i++) {
        
        //注意用integerVal拆箱
        // NSLog(@"before: %ld",[prodsRemainningSeconds[i] integerValue]);
        
        [prodsRemainningSeconds replaceObjectAtIndex:i withObject:@([prodsRemainningSeconds[i] integerValue]-1)];
    }
    
    [quickBuyTView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomHttpRequest* customHttp = [[CustomHttpRequest alloc]init];
    if ([customHttp IsCurrentInternentReached] == YES)
    {
        CommonFunction* commFunc = [[CommonFunction alloc]init];
        [commFunc sendPostByCurrentProductID:quickBuyArray[indexPath.row][@"goods_id"]  WithImgData:[self getCurrImageData:quickBuyArray[indexPath.row][@"goods_id"] WithImgArry:quickBuyImage] WithClassName:@"ProductDetailController" WithCustomHttp:customHttp WithNavigation:self.navigationController];
    }
    else
    {
        [self promptSingleButtonWarningDialog:@"网络不给力，请稍候!"];
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomHttpRequest* customHttp = [[CustomHttpRequest alloc]init];
    if ([customHttp IsCurrentInternentReached] == YES)
    {
        CommonFunction* commFunc = [[CommonFunction alloc]init];
        if ((int)collectionView.tag == 001)
        {
            [commFunc sendPostByCurrentProductID:homePageArray[indexPath.row][@"goods_id"]  WithImgData:[self getCurrImageData:homePageArray[indexPath.row][@"goods_id"] WithImgArry:homePageImage] WithClassName:@"ProductDetailController" WithCustomHttp:customHttp WithNavigation:self.navigationController];
        }
        else
        {
            [commFunc sendPostByCurrentProductID:bestSaleArray[indexPath.row][@"goods_id"]  WithImgData:[self getCurrImageData:bestSaleArray[indexPath.row][@"goods_id"] WithImgArry:bestSaleImage] WithClassName:@"ProductDetailController" WithCustomHttp:customHttp WithNavigation:self.navigationController];
        }
    }
    else
    {
        [self promptSingleButtonWarningDialog:@"网络不给力，请稍候!"];
    }
}

-(NSData*)getCurrImageData:(NSString*)productID WithImgArry:(NSMutableArray*)imgArray
{
    for (NSDictionary* currImg in imgArray) {
        if ([currImg objectForKey:productID])
        {
            return currImg[productID];
        }
    }
    return nil;
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
