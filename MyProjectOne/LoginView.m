//
//  LoginView.m
//  MyProjectOne
//
//  Created by StephenHe on 9/16/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView
{
    UIImageView* loginIDField;
    
    UIImageView* passwordField;
    
    UIButton* forgetBtn;
}


-(UIView*)getCurrentContentView:(UINavigationController*)navigationController
{
    UIView* currContentView = [super getCurrentContentView:navigationController];
    
    //[currContentView setBackgroundColor:[UIColor yellowColor]];
    
    return currContentView;
}

-(UIButton*)setRightButton
{
    UIButton* goToRegisterBtn = [super setRightButton];

    [goToRegisterBtn setTitle:@"注册" forState:UIControlStateNormal];
    
    return goToRegisterBtn;
}

-(UIImageView*) setLoginIDField:(UIView*)currView
{
    loginIDField = [[UIImageView alloc]
                                 initWithFrame:CGRectMake(0, 5, currView.frame.size.width, 50)];
    
    [loginIDField.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    
    [loginIDField.layer setBorderWidth:1];
    [loginIDField setAlpha:0.5];

    [loginIDField setUserInteractionEnabled:YES];
    
    [self setElementsToLoginIDField];
    
    return loginIDField;
}

-(UIImageView*) setPasswordField:(UIView*)currView
{
    passwordField = [[UIImageView alloc]
                                  initWithFrame:CGRectMake(0, 90, currView.frame.size.width, 50)];
    
    [passwordField.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [passwordField.layer setBorderWidth:1];
    [passwordField setAlpha:0.5];
    [passwordField setUserInteractionEnabled:YES];
    
    [self setElementsToPasswordField];
    
    return passwordField;
}

-(void)setElementsToLoginIDField
{
    UILabel* loginIDTitle = [[UILabel alloc]
                             initWithFrame:CGRectMake(10, loginIDField.bounds.size.height/4+2, 70, 20)];
    
    [loginIDTitle setText:@"用户名:"];
    [loginIDTitle setFont:[UIFont boldSystemFontOfSize:20]];
    [loginIDTitle setTextColor:[UIColor blackColor]];
    
    self.loginIDInput = [[UITextField alloc]
                                 initWithFrame:CGRectMake(90, loginIDField.frame.size.height/4+2, loginIDField.bounds.size.width-loginIDTitle.bounds.size.width-10, 20)];
    
    [self.loginIDInput setPlaceholder:@"手机号/邮箱/昵称"];
    [self.loginIDInput setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.loginIDInput setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [self.loginIDInput setFont:[UIFont systemFontOfSize:20]];
    
    [loginIDField addSubview:loginIDTitle];
    [loginIDField addSubview:self.loginIDInput];
}

-(void)setElementsToPasswordField
{
    UILabel* passwordTitle = [[UILabel alloc]
                              initWithFrame:CGRectMake(10, passwordField.bounds.size.height/4+2, 70, 20)];
    
    [passwordTitle setText:@"密码:"];
    [passwordTitle setFont:[UIFont boldSystemFontOfSize:20]];
    [passwordTitle setTextColor:[UIColor blackColor]];
    
    self.passwordInput = [[UITextField alloc]
                                  initWithFrame:CGRectMake(90, passwordField.bounds.size.height/4+2, passwordField.bounds.size.width-passwordTitle.bounds.size.width-10, 20)];
    
    //[passwordInput setPlaceholder:@"请输入密码"];
    [self.passwordInput setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.passwordInput setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [self.passwordInput setSecureTextEntry:YES];
    
    [passwordField addSubview:passwordTitle];
    [passwordField addSubview:self.passwordInput];
}

-(UIButton*)setForgetBtn:(UIView*)currView
{
    forgetBtn = [UIButton buttonWithType:UIButtonTypeSystem] ;
    
    [forgetBtn setFrame:
     CGRectMake(currView.frame.size.width-100,passwordField.frame.origin.y+70, 100, 50)];
    [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [forgetBtn.titleLabel setFont:[UIFont systemFontOfSize:19]];
    
    return forgetBtn;
}

-(UIButton*)setLoginBtn:(UIView*)currView
{
    UIButton* loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [loginBtn setFrame:
     CGRectMake(0,forgetBtn.frame.origin.y+70, currView.frame.size.width, 40)];
    [loginBtn setTitle:@"登   录" forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor colorWithRed:41/255.0 green:110/255.0 blue:205/255.0 alpha:1]];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn.titleLabel setFont:[UIFont systemFontOfSize:22]];

    return loginBtn;
}

@end
