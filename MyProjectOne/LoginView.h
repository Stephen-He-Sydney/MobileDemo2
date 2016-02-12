//
//  LoginView.h
//  MyProjectOne
//
//  Created by StephenHe on 9/16/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "CommonMemberCenterView.h"

@interface LoginView : CommonMemberCenterView

-(UIImageView*) setLoginIDField:(UIView*)currView;

-(UIImageView*) setPasswordField:(UIView*)currView;

-(UIButton*)setForgetBtn:(UIView*)currView;

-(UIButton*)setLoginBtn:(UIView*)currView;

@property(strong,nonatomic)UITextField* loginIDInput;

@property(strong,nonatomic)UITextField* passwordInput;

@end
