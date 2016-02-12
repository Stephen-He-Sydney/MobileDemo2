//
//  RegisterView.h
//  MyProjectOne
///Applications/XMind.app
//  Created by StephenHe on 9/16/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "CommonMemberCenterView.h"

@interface RegisterView : CommonMemberCenterView

-(NSMutableArray*)setAllTextFields:(UIView*)currView;

-(UIButton*)setRegisterBtn:(UIView*)currView;

-(void)AddVerifyCodeButton:(UIImageView*)inputField;

@property(strong,nonatomic)UITextField* mobileNumber;

@property(strong,nonatomic)UITextField* verifyCode;

@property(strong,nonatomic)UITextField* registerPwd;

@property(strong,nonatomic)UITextField* confirmPwd;

@property(strong,nonatomic)UITextField* emailAddress;

/*这个按钮功能要问老师*/
@property(strong,nonatomic)UIButton* verifyCodeBtn;

@end
