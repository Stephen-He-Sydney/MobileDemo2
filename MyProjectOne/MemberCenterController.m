//
//  MemberCenterController.m
//  MyProjectOne
//
//  Created by StephenHe on 9/18/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "MemberCenterController.h"

@interface MemberCenterController ()

@end

@implementation MemberCenterController

-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self reloadMemberCenterView];
}

-(void)openEditUserInfo
{
    [self changeSubViewsByButtonClick:2];
    
    [self highlightCurrMenuBtn:2];
    
    memberInfoEditContent.hidden = NO;
    memberInfoLabelContent.hidden = YES;
}

-(void)reloadMemberCenterView
{
    commMemberCenter = [[CommonMemberCenterView alloc]init];
    
    [self initializeAttributes];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithCustomView:[self bindNavLeftBarButton]];
    
    [self setMemberCenterViews];
    
    [self reflectNavigationBarRightBtn];
}

//重写父类的按钮绑定事件
-(void)goBackAction:(id)sender
{
    if (memberInfoLabelContent.hidden == NO)
    {
        [self.parentViewController.tabBarController setSelectedIndex:0];
        [self.tabBarController.viewControllers objectAtIndex:0];
    }
    else if (self.currState != none)
    {
        [self.navigationController popViewControllerAnimated:NO];
    }
    else
    {
        memberInfoLabelContent.hidden = NO;
        memberInfoEditContent.hidden = YES;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    //判断如果已填用户信息，且由去结算而来，则继续返回上一页到购物车或秒杀
    if ([CommonFunction readUserDefaultsForUserInfo].count > 0 && self.currState != none)
    {
        [self.navigationController popViewControllerAnimated:NO];
    }
    
    for (UIView* subView in self.view.subviews) {
        [subView removeFromSuperview];
    }
    
    [self reloadMemberCenterView];
    
    if (self.currState != none)
    {
        [self openEditUserInfo];
    }
}

-(void)setMemberCenterViews
{
    [self setAllStaticViews:002];
    
    [self loadMemberCenterComponents];
    
    fullSizeView.hidden = YES;
    
    if ([self verifyLoginStatus] == YES){
        [self goToMemberCenterView];
    }
}

-(void)goToMemberCenterView
{
    loginView.hidden = YES;
    fullSizeView.hidden = NO;
    self.navigationItem.title = @"会员中心";
    self.navigationItem.rightBarButtonItem = nil;
}

-(void)loadMemberCenterComponents
{
    [self loadMenuButtons];
    [self loadMainImage];
    [self highlightCurrMenuBtn:0];
    [self loadOrderDetail];
    [self loadMemberInfo];
    [self loadClaimProduct];
    
    //orderDetailContent.hidden = YES;
    memberInfoContent.hidden = YES;
    claimProductContent.hidden = YES;
    
    [fullSizeView addSubview:orderDetailContent];
    [fullSizeView addSubview:memberInfoContent];
    [fullSizeView addSubview:claimProductContent];
    [self.view addSubview:fullSizeView];
}

-(void)loadMainImage
{
    mainImage = [commMemberCenter setMainImage:self.navigationController.navigationBar];
    [fullSizeView addSubview:mainImage];
    
    exitButton = [commMemberCenter setExitBtn:mainImage];
    
    [exitButton addTarget:self action:@selector(logOffAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [mainImage addSubview:exitButton];
}

-(void)loadMenuButtons
{
    fullSizeView = [commMemberCenter getFullSizeContentView:self.navigationController];
    
    menuBtns = [commMemberCenter setNavBar:self.navigationController.navigationBar];
    
    for (int i = 0; i < menuBtns.count; i++) {
        [menuBtns[i] setTag:i];
        
        [menuBtns[i] addTarget:self action:@selector(controlSubViewsAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [fullSizeView addSubview:menuBtns[i]];
    }
}

-(void)loadClaimProduct
{
    claimProduct = [[ClaimProductView alloc]init];
    claimProductContent = [claimProduct getMainContentView:mainImage];
}

-(void)loadOrderDetail
{
    orderDetail = [[OrderDetailView alloc]init];
    orderDetailContent = [orderDetail getMainContentView:mainImage];
}

-(void)loadMemberInfo
{
    //delete userinfo for testing
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userInfo"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    
    memberInfo = [[MemberInfoView alloc]init];
    memberInfoContent = [memberInfo getMainContentView:mainImage];
    
    memberInfoLabelContent = [memberInfo getMemberInfoDisplayPanel:memberInfoContent];
    memberInfoEditContent = [memberInfo getMemberInfoDisplayPanel:memberInfoContent];

    memberInfoEditContent.hidden = YES;
    //memberInfoLabelContent.hidden = YES;
    
    [memberInfoContent addSubview:memberInfoLabelContent];
    [memberInfoContent addSubview:memberInfoEditContent];
    
    [self loadMemberInfoDisplayFields];
    
    [self loadMemberInfoChangeBtns];
    
    [self loadMemberInfoEditableFields];
    
    [self loadMemberInfoEditableBtns];
    
    [self loadDropDownLists];
    
    [self loadTableViewsToDropDownList];
}


-(void)loadYearData
{
    NSDate *currentDate = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear fromDate:currentDate];
    
    int currYear =(int)[components year];
    yearArray = [[NSMutableArray alloc] init];
    [yearArray addObject:@"--选择--"];
    
    for (int i = currYear; i >= 1940; i--) {
        [yearArray addObject:@(i)];
    }
}

-(void)loadMonthData
{
    monthArray = [[NSMutableArray alloc]init];
    [monthArray addObject:@"--选择--"];

    for (int i = 1; i <= 12; i++) {
        [monthArray addObject:@(i)];
    }
}

-(void)loadDateData:(int)maxDays
{
    dateArray = [[NSMutableArray alloc]init];
    if (dateArray.count > 0)
    {
        [dateArray removeAllObjects];
    }
    [dateArray addObject:@"--选择--"];
    
    for (int i = 1; i <= maxDays; i++) {
        [dateArray addObject:@(i)];
    }
}

-(void)loadDropDownLists
{
    dropDownListArry = [[NSMutableArray alloc]init];
    for (int i = 0; i < 3; i++) {
        UIView* birthdayDropDownList = [memberInfo setDropDownListContainer:109 WithHeight:30*7 WithStartLeft:65+100*i WithStartTop:139];
        birthdayDropDownList.hidden = YES;
        [memberInfoEditContent addSubview:birthdayDropDownList];
        [dropDownListArry addObject:birthdayDropDownList];
    }
    for (int i = 0; i < 3; i++) {
        UIView* addressDropDownList = [memberInfo setDropDownListContainer:109 WithHeight:30*7 WithStartLeft:65+100*i WithStartTop:184];
         addressDropDownList.hidden = YES;
        [memberInfoEditContent addSubview:addressDropDownList];
        [dropDownListArry addObject:addressDropDownList];
    }
    [self loadYearData];
    
    [self loadMonthData];
    
    [self loadDateData:31];
    
    provinceArray = @[@"江苏省",@"福建省"];// hardcode for time-being
}

-(int)getTotalDaysByCurMonth:(NSString*)curMonth
{
    NSArray* longDayMonths = @[@"1",@"3",@"5",@"7",@"8",@"10",@"12"];
    NSArray* shortDayMonths = @[@"4",@"6",@"9",@"11"];
    
    if ([longDayMonths containsObject:curMonth])
    {
        return 31;
    }
    else if ([shortDayMonths containsObject:curMonth])
    {
        return 30;
    }
    return 28;
}

-(void)loadTableViewsToDropDownList
{
    tableViews = [[NSMutableArray alloc]init];
    for (int i = 0; i < dropDownListArry.count; i++) {
        CommonControllersView* commControl = [[CommonControllersView alloc]init];
        UITableView* currTableView = [commControl getCurrentTableView:(UIView*)dropDownListArry[i]];
        currTableView.delegate = self;
        currTableView.dataSource = self;
        currTableView.tag = i;
        [((UIView*)dropDownListArry[i]) addSubview:currTableView];
        [tableViews addObject:currTableView];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (tableView.tag) {
        case 0:
            return yearArray.count;
            break;
        case 1:
            return monthArray.count;
            break;
        case 2:
            return dateArray.count;
            break;
        case 3:
            return provinceArray.count;
            break;
        case 4:
            if (cityArray.count > 0)
            {
                return cityArray.count;
                break;
            }
        case 5:
            if (streetArray.count > 0)
            {
                return streetArray.count;
                break;
            }
        default:
            break;
    }
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifer = @"currCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer
                ];
    }
    
    switch (tableView.tag) {
        case 0:
            cell.textLabel.text = indexPath.row > 0 ?[NSString stringWithFormat:@"%ld",[yearArray[indexPath.row]integerValue]]
                :yearArray[indexPath.row];
            break;
        case 1:
            cell.textLabel.text = indexPath.row > 0 ?[NSString stringWithFormat:@"%ld",[monthArray[indexPath.row]integerValue]]
            :monthArray[indexPath.row];
            break;
        case 2:
            cell.textLabel.text = indexPath.row > 0 ?[NSString stringWithFormat:@"%ld",[dateArray[indexPath.row]integerValue]]
            :dateArray[indexPath.row];
            break;
        case 3:
            cell.textLabel.text = provinceArray[indexPath.row];
            break;
        case 4:
            if (cityArray.count > 0)
            {
                cell.textLabel.text = cityArray[indexPath.row];
                break;
            }
        case 5:
            if (streetArray.count > 0)
            {
                cell.textLabel.text = streetArray[indexPath.row];
                cell.textLabel.font = [UIFont systemFontOfSize:10];
                cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
                break;
            }
        default:
            break;
    }
    if (tableView.tag != 5)
    {
        cell.textLabel.textAlignment = UITextAlignmentCenter;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ((UIView*)dropDownListArry[0]).frame.size.height/7;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    [self toggleLogic:tableView.tag];
    NSString* selectedVal = cell.textLabel.text;
    
    if (tableView.tag < 3)
    {
        if (cell.textLabel.text != (id)[NSNull null]
            && cell.textLabel.text.length > 0
            && ![cell.textLabel.text isEqualToString:@"--选择--"])
        {
            //点击月份，修改天数
            if (tableView.tag == 1)
            {
                NSString* yearText = ((UILabel*)birthdaySelectedTxt[0]).text;
                
                if (yearText.length > 0 && yearText != (id)[NSNull null])
                {
                    [self logicForMonthAndYearChange:selectedVal WithYear:yearText];
                }
                else
                {
                    [self loadDateData:[self getTotalDaysByCurMonth:selectedVal]];
                }
                
                [self refreshTableViewResetOption:2 WithDisplayArray:birthdaySelectedTxt[2]];
            }
            
            //点击年份,修改天数
            if (tableView.tag == 0)
            {
                NSString* monthText = ((UILabel*)birthdaySelectedTxt[1]).text;
                
                if (monthText.length > 0 && monthText != (id)[NSNull null])
                {
                    [self logicForMonthAndYearChange:monthText WithYear:selectedVal];
                    
                    [self refreshTableViewResetOption:2 WithDisplayArray:birthdaySelectedTxt[2]];
                }
            }
            
            [((UILabel*)birthdaySelectedTxt[tableView.tag]) setFont:[UIFont systemFontOfSize:18]];
        }
        else if ([cell.textLabel.text isEqualToString:@"--选择--"])
        {
            [((UILabel*)birthdaySelectedTxt[tableView.tag]) setFont:[UIFont systemFontOfSize:14]];
        }
        ((UILabel*)birthdaySelectedTxt[tableView.tag]).text = selectedVal;
    }
    else
    {
        if (tableView.tag == 3)
        {
            if ([selectedVal containsString:@"江苏"])
            {
                cityArray = @[@"扬州市",@"苏州市"];
            }
            else if ([selectedVal containsString:@"福建"])
            {
                cityArray = @[@"厦门市",@"福州市"];
            }
            streetArray = nil;
            
            [self refreshTableViewResetOption:4 WithDisplayArray:addressSelectedTxt[1]];
            
            [self refreshTableViewResetOption:5 WithDisplayArray:addressSelectedTxt[2]];
        }
        else if (tableView.tag == 4)
        {
            if ([selectedVal containsString:@"扬州"])
            {
                streetArray = @[@"宝应县安宜北路",@"维扬区文昌阁路"];
            }
            else if ([selectedVal containsString:@"苏州"])
            {
                streetArray = @[@"姑苏区虎丘路",@"吴中区苏州乐园路"];
            }
            else if ([selectedVal containsString:@"厦门"])
            {
                streetArray = @[@"思明区第一码头Bus站",@"湖里区SM二期"];
            }
            else if ([selectedVal containsString:@"福州"])
            {
                streetArray = @[@"三坊七巷林觉民故居",@"三坊七巷林则徐纪念馆"];
            }

            [self refreshTableViewResetOption:5 WithDisplayArray:addressSelectedTxt[2]];
        }
        else
        {
            [((UILabel*)addressSelectedTxt[2]) setFont:[UIFont systemFontOfSize:8]];
        }
        ((UILabel*)addressSelectedTxt[tableView.tag-3]).text = selectedVal;
        
        UITextField* curTextField = (UITextField*)textFields[1];
        
        switch (tableView.tag) {
            case 3:
                curTextField.text = selectedVal;
                break;
            case 4:
                curTextField.text = [NSString stringWithFormat:@"%@%@",((UILabel*)addressSelectedTxt[0]).text,selectedVal];
                break;
            case 5:
                curTextField.text = [NSString stringWithFormat:@"%@%@%@",((UILabel*)addressSelectedTxt[0]).text,((UILabel*)addressSelectedTxt[1]).text,selectedVal];
                break;
            default:
                break;
        }
    }
}

-(void)logicForMonthAndYearChange:(NSString*)monthVal WithYear:(NSString*)yearVal
{
    if ([monthVal isEqualToString:@"2"]
        &&[self isLeapYear:yearVal]==YES)
    {
        [self loadDateData:29];
    }
    else
    {
        [self loadDateData:[self getTotalDaysByCurMonth:monthVal]];
    }
}

-(void)refreshTableViewResetOption:(int)tableViewIndex WithDisplayArray:(NSMutableArray*)displayArry
{
    [tableViews[tableViewIndex] reloadData];

    [((UILabel*)displayArry) setFont:[UIFont systemFontOfSize:14]];

    ((UILabel*)displayArry).text = @"--选择--";
}

-(BOOL)isLeapYear:(NSString*)theYear
{
    int year = (int)[theYear integerValue];
    if ((year % 4 == 0 && year % 400 == 0)
        ||(year % 4 == 0 && year % 100 != 0))
    {
        return YES;
    }
    
    return NO;
}

-(void)loadMemberInfoEditableBtns
{
    NSMutableArray* buttons = [memberInfo setTwoChangeButtons:memberInfoEditContent];
    for (int i = 0; i < buttons.count; i++) {
        UIButton* changeBtn = (UIButton*) buttons[i];
        [changeBtn setTag:i];
        if (i == 0)
        {
            [changeBtn setTitle:@"保存信息" forState:UIControlStateNormal];
        }
        else
        {
            [changeBtn setTitle:@"修改密码" forState:UIControlStateNormal];
        }
        [changeBtn addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [memberInfoEditContent addSubview:changeBtn];
    }
}

-(void)saveButtonAction:(UIButton*)sender
{
    int currTag = (int)[sender tag];
    
    if (currTag == 0)
    {
        if ([self verifyRequiredTextFields] == YES)
        {
            [self saveAllFields];
            
            [self promptDoubleButtonsWarningDialog:@"保存成功"];
        }
    }
}

-(void)reloadUserInfoLabelPage
{
    for (UIView* subView in memberInfoLabelContent.subviews) {
        [subView removeFromSuperview];
    }
    
    [self loadMemberInfoDisplayFields];
    [self loadMemberInfoChangeBtns];
}

-(void)trySaveBirthdayField
{
    birthdayVal = [[NSString alloc]init];
    for (int i = 0; i < birthdaySelectedTxt.count; i++) {
        UILabel* alabel = birthdaySelectedTxt[i];
        if (![alabel.text containsString:@"选择"])
        {
            if (i == 0)
            {
                birthdayVal = alabel.text;
            }
            else
            {
                birthdayVal = [NSString stringWithFormat:@"%@-%@",birthdayVal,alabel.text];
            }
        }
        else
        {
            birthdayVal = nil;
            break;
        }
    }
}

-(void)saveAllFields
{
    saveFields = [[NSMutableDictionary alloc]init];
    
    NSArray* keys = @[@"nickName",@"address",@"email",@"phone"];
    
    for (int i = 0; i < textFields.count; i++) {
        if ([CommonFunction readUserDefaultsForUserInfo].count > 0 && i == 0)
        {
            [saveFields setObject:[CommonFunction readUserDefaultsForUserInfo][keys[i]] forKey:keys[i]];
        }
        else
        {
            UITextField* curTextField = textFields[i];
            [saveFields setObject:curTextField.text forKey:keys[i]];
        }
    }
    [saveFields setObject:@(isMale) forKey:@"isMale"];
    
    [self trySaveBirthdayField];
    if (birthdayVal != nil)
    {
        [saveFields setObject:birthdayVal forKey:@"birthday"];
    }
    // data persistance locally
    NSUserDefaults* userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo setObject:saveFields forKey:@"userInfo"];
}

-(void)promptDoubleButtonsWarningDialog:(NSString*)msg
{
    UIAlertView* warnAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"重新修改",nil];
    
    [warnAlert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //只有alertView声明在当前类以内,该方法才能被调用
    if (buttonIndex == 0)
    {
        if (self.currState != none)
        {
            NSUserDefaults* checkOutDefaults = [NSUserDefaults standardUserDefaults];
            [checkOutDefaults setObject:self.checkOutArry forKey:@"checkOut"];
            
            CheckOutController* checkOutCtrl = [[CheckOutController alloc]init];
            checkOutCtrl.currState = self.currState;
            [self.navigationController pushViewController:checkOutCtrl animated:NO];
        }
        else
        {
            memberInfoEditContent.hidden = YES;
            memberInfoLabelContent.hidden = NO;
            
            [self reloadUserInfoLabelPage];
        }
    }
}

-(void)loadMemberInfoChangeBtns
{
    NSMutableArray* buttons = [memberInfo setTwoChangeButtons:memberInfoLabelContent];
    for (int i = 0; i < buttons.count; i++) {
        UIButton* changeBtn = (UIButton*) buttons[i];
        [changeBtn setTag:i];
        if (i == 0)
        {
            [changeBtn setTitle:@"修改信息" forState:UIControlStateNormal];
        }
        else
        {
            [changeBtn setTitle:@"修改密码" forState:UIControlStateNormal];
        }
        [changeBtn addTarget:self action:@selector(changeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [memberInfoLabelContent addSubview:changeBtn];
    }
}

-(void)changeButtonAction:(UIButton*)sender
{
    int currTag = (int)[sender tag];
    
    if (currTag == 0)
    {
        memberInfoEditContent.hidden = NO;
        memberInfoLabelContent.hidden = YES;
        
        [self reloadEditablePage];
    }
}

-(void)reloadEditablePage
{
    for (UIView* superView in memberInfoEditContent.subviews) {
        [superView removeFromSuperview];
    }
    
    [self loadMemberInfoEditableFields];
    
    [self loadMemberInfoEditableBtns];
    
    [self loadDropDownLists];
    
    [self loadTableViewsToDropDownList];
}

-(void)loadMemberInfoDisplayFields
{
    infoData = [[NSMutableArray alloc]init];
    NSMutableDictionary* readUserInfo = [CommonFunction readUserDefaultsForUserInfo];
    
    if (readUserInfo.count > 0)
    {
        [infoData addObject:readUserInfo[@"nickName"]];
        if ((BOOL)[readUserInfo[@"isMale"]boolValue]==YES)
        {
            [infoData addObject:@"男"];
        }
        else
        {
            [infoData addObject:@"女"];
        }
        if ([readUserInfo objectForKey:@"birthday"])
        {
            [infoData addObject:readUserInfo[@"birthday"]];
        }
        else
        {
            [infoData addObject:@""];
        }
        
        [infoData addObject:readUserInfo[@"address"]];
        [infoData addObject:readUserInfo[@"email"]];
        [infoData addObject:readUserInfo[@"phone"]];
    }
    else
    {
        [infoData addObject:@"未填"];
        [infoData addObject:@"未填"];
        [infoData addObject:@"未填"];
        [infoData addObject:@"未填"];
        [infoData addObject:@"未填"];
        [infoData addObject:@"未填"];
    }

    NSMutableArray* labels = [memberInfo setCurrMemberInfo:infoData WithParentContainer:memberInfoLabelContent];
    
    for (UILabel* alabel in labels) {
        [memberInfoLabelContent addSubview:alabel];
    }
}

-(void)loadMemberInfoEditableFields
{
    NSMutableArray* imageViews = [memberInfo setMemberInfoEditableArea:memberInfoEditContent];
    
    NSMutableArray* labels = [memberInfo setMemberInfoEditableTxts];
    textFields = [memberInfo setMemberInfoTextFields];
    
    NSMutableArray* options = [memberInfo setGenderOption];
    imageButtonArry = [[NSMutableArray alloc]init];
    
    NSMutableArray* birthDayLists = [memberInfo setStartDropDownPanel];
    NSMutableArray* addressLists = [memberInfo setStartDropDownPanel];
    
    NSMutableArray* birthDayIcons = [memberInfo setDropDownIcon];
    NSMutableArray* addressIcons = [memberInfo setDropDownIcon];
    
    birthdaySelectedTxt = [memberInfo setSelectedTextPanel];
    addressSelectedTxt = [memberInfo setSelectedTextPanel];
    
    int j = 0;
    int k = 0;
    int index = 0;
    for (int i = 0; i < imageViews.count; i++) {
        UIImageView* aimgView = (UIImageView*)imageViews[i];
        if (i != 4)
        {
            UILabel* alabel =(UILabel*)labels[j];
            [aimgView addSubview:alabel];
            j++;
        }
        if (i != 1 && i!= 2 && i != 3)
        {
            if (i == 0 && [CommonFunction readUserDefaultsForUserInfo].count > 0)
            {
                UILabel* nickNameLabel = [memberInfo readOnlyNickNameField];
                nickNameLabel.text = [CommonFunction readUserDefaultsForUserInfo][@"nickName"];
                [aimgView addSubview:nickNameLabel];
                k++;
            }
            else
            {
                UITextField* aTextField = (UITextField*)textFields[k];
                [aimgView addSubview:aTextField];
                k++;
            }
        }
        if (i == 1)
        {
            for (int h = 0; h < options.count; h++) {
                if (h == 0||h == 2)
                {
                    UIImageView* aImageButton = (UIImageView*)options[h];
                    aImageButton.tag = index;
                    [aImageButton addGestureRecognizer:[self setTapGesture]];
                    [aimgView addSubview:aImageButton];
                    [imageButtonArry addObject:aImageButton];
                    index++;
                }
                else
                {
                    UILabel* alabel = (UILabel*)options[h];
                    [aimgView addSubview:alabel];
                }
            }
        }
        if (i == 2)
        {
            for (int v = 0; v < birthDayLists.count; v++) {
                UIImageView* startDropDownList = (UIImageView*)birthDayLists[v];
                startDropDownList.tag = index;
                [startDropDownList addGestureRecognizer:[self setTapGesture]];
                [startDropDownList addSubview:birthdaySelectedTxt[v]];
                [startDropDownList addSubview:birthDayIcons[v]];
                [aimgView addSubview:startDropDownList];
                index++;
            }
        }
        if (i == 3)
        {
            for (int v = 0; v < addressLists.count; v++) {
                UIImageView* startDropDownList = (UIImageView*)addressLists[v];
                startDropDownList.tag = index;
                [startDropDownList addGestureRecognizer:[self setTapGesture]];
                [startDropDownList addSubview:addressSelectedTxt[v]];
                [startDropDownList addSubview:addressIcons[v]];
                [aimgView addSubview:startDropDownList];
                index++;
            }
        }
        [memberInfoEditContent addSubview:aimgView];
    }
    isMale = YES;//default is male
}

-(BOOL)verifyRequiredTextFields
{
    int start = 0;
    if ([CommonFunction readUserDefaultsForUserInfo].count > 0)
    {
        start = 1;
    }
    
    for (int i = start; i < textFields.count; i++) {
        UITextField* aTextField = textFields[i];
        if([CommonFunction trimString:aTextField.text].length == 0)
        {
            switch (i) {
                case 0: //nickname
                    [CommonControllersView promptSingleButtonWarningDialog:@"请输入昵称!"];
                    break;
                case 1: //address
                    [CommonControllersView promptSingleButtonWarningDialog:@"请输入收货地址!"];
                    break;
                case 2: // email is not mandantory at this stage
                    continue;
                case 3: //contact
                    [CommonControllersView promptSingleButtonWarningDialog:@"请输入电话号码!"];
                    break;
            }
            return NO;
        }
    }
    
    return YES;
}

-(UITapGestureRecognizer*)setTapGesture
{
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapResponse:)];
    
    return tap;
}

-(void)tapResponse:(UITapGestureRecognizer*)sender
{
    long currTag = sender.view.tag;
    UIImageView* btnImage = (UIImageView*)sender.view;
    
    switch (currTag) {
        case 0:
        {
            isMale = YES;
            btnImage.image = [UIImage imageNamed:@"会员信息_05"];
            UIImageView* otherImgBtn = (UIImageView*)imageButtonArry[1];
            otherImgBtn.image = [UIImage imageNamed:@"会员信息_07"];
            break;
        }
        case 1:
        {
            isMale = NO;
            btnImage.image = [UIImage imageNamed:@"会员信息_05"];
            UIImageView* otherImgBtn = (UIImageView*)imageButtonArry[0];
            otherImgBtn.image = [UIImage imageNamed:@"会员信息_07"];
            break;
        }
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        {
            [self toggleDropDownList:currTag];
            break;
        }
        default:
            break;
    }
}

-(void)toggleDropDownList:(long)currTag
{
    [self toggleLogic:currTag-2];
}

-(void)toggleLogic:(long)index
{
    UIView* curDropDown =(UIView*)dropDownListArry[index];
    
    if (curDropDown.hidden == YES)
    {
        curDropDown.hidden = NO;
    }
    else
    {
        curDropDown.hidden = YES;
    }
    for (int i = 0; i < dropDownListArry.count; i++) {
        if(index != i)
        {
            ((UIView*)dropDownListArry[i]).hidden = YES;
        }
    }
}

-(void)logOffAction:(id)sender
{
    NSUserDefaults* loginOn = [NSUserDefaults standardUserDefaults];
    [loginOn setBool:NO forKey:@"isLoginOn"];
    
    [self redirectToLoginView];
}

-(void)controlSubViewsAction:(id)sender
{
    menuBtnIndex = (int)[sender tag];
    
    [self changeSubViewsByButtonClick:menuBtnIndex];
    
    [self highlightCurrMenuBtn:menuBtnIndex];
}

-(void)highlightCurrMenuBtn:(int)btnIndex
{
    for (int i = 0; i < [menuBtns count]; i++) {
        if (i == btnIndex)
        {
            [menuBtns[i] setBackgroundColor:[UIColor whiteColor]];
            
            [menuBtns[i] setTitleColor:[UIColor colorWithRed:41/255.0 green:110/255.0 blue:205/255.0 alpha:1] forState:UIControlStateNormal];
            
        }
        else
        {
            [menuBtns[i] setBackgroundColor:[UIColor colorWithRed:41/255.0 green:110/255.0 blue:205/255.0 alpha:1]];
            
            [menuBtns[i] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}

-(void)changeSubViewsByButtonClick:(int)btnIndex
{
    switch (btnIndex) {
        case 0:
            orderDetailContent.hidden = NO;
            memberInfoContent.hidden = YES;
            claimProductContent.hidden = YES;
            break;
        case 2:
            orderDetailContent.hidden = YES;
            memberInfoContent.hidden = NO;
            claimProductContent.hidden = YES;
            break;
        case 3:
            orderDetailContent.hidden = YES;
            memberInfoContent.hidden = YES;
            claimProductContent.hidden = NO;
            break;
        default:
            break;
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
