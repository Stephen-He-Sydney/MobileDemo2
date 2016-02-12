//
//  LoginRegisterViewController.m
//  MyProjectOne
//
//  Created by StephenHe on 9/18/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "LoginRegisterViewController.h"

@interface LoginRegisterViewController ()

@end

@implementation LoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initializeAttributes
{
    loginView = [[UIView alloc]init];
    registerView = [[UIView alloc]init];
    fullSizeView = [[UIView alloc]init];
    
    loginObj = [[LoginView alloc]init];
    registerObj = [[RegisterView alloc]init];
    commView = [[CommonControllersView alloc]init];
}

-(UIButton*)bindNavLeftBarButton
{
    UIButton* goBackBtn = [commView setLeftGoBackButton];
    
    [goBackBtn addTarget:self action:@selector(goBackAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return goBackBtn;
}

-(void)goBackAction:(id)sender
{
    [self.parentViewController.tabBarController setSelectedIndex:0];
    [self.tabBarController.viewControllers objectAtIndex:0];
}

-(void)reflectNavigationBarRightBtn
{
    UIView* rightBtnView;
    if (loginView.hidden == NO)
    {
        self.navigationItem.title = @"登录";
        
        UIButton* goToRegisterBtn =[loginObj setRightButton];
        
        [goToRegisterBtn addTarget:self action:@selector(goToRegisterView:) forControlEvents:UIControlEventTouchUpInside];
        
        rightBtnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, goToRegisterBtn.frame.size.width, goToRegisterBtn.frame.size.height)];
        
        [rightBtnView addSubview:goToRegisterBtn];
    }
    else if (registerView.hidden == NO)
    {
        self.navigationItem.title = @"注册";
        
        UIButton* goToLoginBtn =[registerObj setRightButton];
        
        [goToLoginBtn addTarget:self action:@selector(goToLoginView:) forControlEvents:UIControlEventTouchUpInside];
        
        rightBtnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, goToLoginBtn.frame.size.width, goToLoginBtn.frame.size.height)];
        
        [rightBtnView addSubview:goToLoginBtn];
    }
    if (rightBtnView)
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                                  initWithCustomView:rightBtnView];
    }
}

-(void)goToRegisterView:(id)sender
{
    loginView.hidden = YES;
    registerView.hidden = NO;
    
    [self reflectNavigationBarRightBtn];
}

-(BOOL)verifyLoginStatus
{
    NSUserDefaults* checkIfLoginOn = [NSUserDefaults standardUserDefaults];
    return (BOOL)[checkIfLoginOn boolForKey:@"isLoginOn"];
}

-(void)redirectToLoginView
{
    loginView.hidden = NO;
    registerView.hidden = YES;
    fullSizeView.hidden = YES;
    
    [self reflectNavigationBarRightBtn];
}

-(void)goToLoginView:(id)sender
{
    [self redirectToLoginView];
}

-(void)setAllStaticViews:(int)currTag
{
    loginObj = [[LoginView alloc]init];
    registerObj = [[RegisterView alloc]init];
    
    [self loadLoginViewComponents:currTag];
    [self loadRegisterViewComponents];
    registerView.hidden = YES;
}

-(void)loadRegisterViewComponents
{
    registerObj.mobileNumber.delegate = self;
    registerObj.verifyCode.delegate = self;
    registerObj.registerPwd.delegate = self;
    registerObj.confirmPwd.delegate = self;
    registerObj.emailAddress.delegate = self;
    
    registerView = [registerObj getCurrentContentView:self.navigationController];
    
    NSMutableArray* allFields = [registerObj setAllTextFields:registerView];
    for (UIImageView* inputField in allFields) {
        [registerView addSubview:inputField];
    }
    
    UIButton* registerButton = [registerObj setRegisterBtn:registerView];
    [registerButton addTarget:self action:@selector(registerSubmission:) forControlEvents:UIControlEventTouchUpInside];
    
    [registerView addSubview:registerButton];
    [self.view addSubview:registerView];
}

-(void)registerSubmission:(id)sender
{
    CustomHttpRequest* customHttp = [[CustomHttpRequest alloc]init];
    if ([customHttp IsCurrentInternentReached] == YES)
    {
        registerObj.serverUrl = @"http://112.74.105.205/upload/mapi/index.php?act=register";
        
        registerObj.paramUrl = [NSString stringWithFormat:@"r_type=1&email=%@&password=%@&user_name=%@",[CommonFunction trimString:registerObj.emailAddress.text], [CommonFunction trimString:registerObj.registerPwd.text], [CommonFunction trimString:registerObj.mobileNumber.text]];
        
        NSDictionary* responseJson = [self getResponseByPost:registerObj WithCustomHttpRequest:customHttp];
        
        if ([responseJson[@"return"] integerValue] == 0)
        {
            [CommonControllersView promptSingleButtonWarningDialog:responseJson[@"info"]];
        }
        else
        {//注册成功自动转到登录页面
            [self redirectToLoginView];
        }
    }
    else
    {
        [CommonControllersView promptSingleButtonWarningDialog:@"网络不给力，请稍候再试!"];
    }
}

-(void)loadLoginViewComponents:(int)currTag
{
    loginObj.loginIDInput.delegate = self;
    loginObj.passwordInput.delegate = self;
    
    loginView = [loginObj getCurrentContentView:self.navigationController];
    [loginView addSubview:[loginObj setLoginIDField:loginView]];
    [loginView addSubview:[loginObj setPasswordField:loginView]];
    [loginView addSubview:[loginObj setForgetBtn:loginView]];
    
    UIButton* loginButton = [loginObj setLoginBtn:loginView];
    loginButton.tag = currTag;
    [loginButton addTarget:self action:@selector(loginSubmission:) forControlEvents:UIControlEventTouchUpInside];
    
    [loginView addSubview:loginButton];
    
    [self.view addSubview:loginView];
}

-(void)loginSubmission:(id)sender
{
    CustomHttpRequest* customHttp = [[CustomHttpRequest alloc]init];
    if ([customHttp IsCurrentInternentReached] == YES)
    {
        loginObj.serverUrl = @"http://112.74.105.205/upload/mapi/index.php?act=login";
        
        loginObj.paramUrl = [NSString stringWithFormat:@"r_type=1&email=%@&pwd=%@",[CommonFunction trimString:loginObj.loginIDInput.text], [CommonFunction trimString:loginObj.passwordInput.text]];
        
        NSDictionary* responseJson = [self getResponseByPost:loginObj WithCustomHttpRequest:customHttp];
        
        if ([responseJson[@"return"] integerValue] == 0)
        {
            [CommonControllersView promptSingleButtonWarningDialog:responseJson[@"info"]];
        }
        else
        {//登录成功自动转到购物车,会员中心页面页面,或去结算页面
            [self saveCurrentLoginStatus];
            if ((int)[sender tag] == 001)
            {
                [self resetCurrView];
                self.navigationItem.title = @"购物车";
            }
            else if((int)[sender tag] == 002)
            {
                [self resetCurrView];
                self.navigationItem.title = @"会员中心";
            }
            else
            {
                [self resetCurrView];
                self.navigationItem.title = @"去结算";
            }
        }
    }
    else
    {
        [CommonControllersView promptSingleButtonWarningDialog:@"网络不给力，请稍候再试!"];
    }
}

-(void)resetCurrView
{
    loginView.hidden = YES;
    fullSizeView.hidden = NO;
    self.navigationItem.rightBarButtonItem = nil;
}

-(void)saveCurrentLoginStatus
{
    NSUserDefaults* loginOn = [NSUserDefaults standardUserDefaults];
    [loginOn setBool:YES forKey:@"isLoginOn"];
}

-(NSDictionary*)getResponseByPost:(CommonMemberCenterView*)commMemberObj WithCustomHttpRequest:(CustomHttpRequest*) customHttp
{
    return [customHttp isResponseSuccess:commMemberObj.serverUrl WithParamUrl:commMemberObj.paramUrl];
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
