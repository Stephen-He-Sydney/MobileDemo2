//
//  RegisterView.m
//  MyProjectOne
//
//  Created by StephenHe on 9/16/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "RegisterView.h"

@implementation RegisterView

-(UIView*)getCurrentContentView:(UINavigationController*)navigationController
{
    UIView* currContentView = [super getCurrentContentView:navigationController];
    
    //[currContentView setBackgroundColor:[UIColor greenColor]];
    
    return currContentView;
}

-(UIButton*)setRightButton
{
    UIButton* goToLoginBtn = [super setRightButton];
    
    [goToLoginBtn setTitle:@"登录" forState:UIControlStateNormal];
    
    return goToLoginBtn;
}

-(NSMutableArray*)setAllTextFields:(UIView*)currView
{
    NSMutableArray* allInputFields = [[NSMutableArray alloc]init];
    
    NSArray* labelTexts = @[@"手机号:",@"验证码:",@"密码:",@"确认密码:",@"邮箱:"];
    
    float startX = 0;
    float startY = 0;
    for (int i = 0; i < 5; i++) {
        UIImageView* inputField = [[UIImageView alloc]
                                   initWithFrame:CGRectMake(startX,startY,currView.frame.size.width, 50)];
        
        [inputField.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [inputField.layer setBorderWidth:1];
        [inputField setUserInteractionEnabled:YES];
        
        [self setAllInputLabels:inputField WithLabel:[labelTexts objectAtIndex:i] WithTxtFieldIndex:i];
        
        [allInputFields addObject:inputField];
        
        startY += inputField.frame.size.height + 15;
    }
    return allInputFields;
}

-(UILabel*)setInputTitles:(UIImageView*)inputField WithLabel:(NSString*) labelName
{
    UILabel* inputTitle = [[UILabel alloc]
                           initWithFrame:CGRectMake(10, inputField.frame.size.height/5, inputField.frame.size.width/6+30, 30)];
    
    [inputTitle setText:labelName];
    [inputTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [inputTitle setTextColor:[UIColor blackColor]];
    
    return inputTitle;
}

-(void)setAllInputLabels:(UIImageView*)inputField WithLabel:(NSString*) labelName WithTxtFieldIndex:(int)txtFieldIndex
{
    UILabel* inputTitle = [self setInputTitles:inputField WithLabel:labelName];
    [inputField addSubview:inputTitle];
    
    if ([labelName isEqualToString:@"验证码:"])
    {
        self.verifyCode =[[UITextField alloc]
                  initWithFrame:CGRectMake(inputTitle.frame.size.width+2, inputField.frame.size.height/5, inputField.frame.size.width/6*3+15, 30)];
        
        [self.verifyCode setEnabled:NO];
        [inputField addSubview:self.verifyCode];
        [self AddVerifyCodeButton:inputField];
    }
    else
    {
        UITextField* textBox =[[UITextField alloc]
                  initWithFrame:CGRectMake(inputTitle.frame.size.width+2, inputField.frame.size.height/5, inputField.frame.size.width/6*4, 30)];
        
        [textBox setClearButtonMode:UITextFieldViewModeWhileEditing];
        [textBox setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        
        if ([labelName isEqualToString:@"密码:"]
            ||[labelName isEqualToString:@"确认密码:"])
        {
            [textBox setSecureTextEntry:YES];
            
        }
        [self setAllPropertiesToUI:txtFieldIndex WithTextBox:textBox WithInputField:inputField];
    }
}

-(void)setAllPropertiesToUI:(int)txtFieldIndex WithTextBox:(UITextField*)textBox WithInputField:(UIImageView*)inputField
{
    switch (txtFieldIndex) {
        case 0:
            self.mobileNumber = textBox;
            [inputField addSubview:self.mobileNumber];
            break;
        case 2:
            self.registerPwd = textBox;
            [inputField addSubview:self.registerPwd];
            break;
        case 3:
            self.confirmPwd = textBox;
            [inputField addSubview:self.confirmPwd];
            break;
        case 4:
            self.emailAddress = textBox;
            [inputField addSubview:self.emailAddress];
            break;
        default:
            break;
    }
}

-(void)AddVerifyCodeButton:(UIImageView*)inputField
{
    self.verifyCodeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [self.verifyCodeBtn setFrame:
     CGRectMake(inputField.frame.size.width/5*4,0, inputField.frame.size.width/5, inputField.frame.size.height)];
    [self.verifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.verifyCodeBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [self.verifyCodeBtn setBackgroundColor:[UIColor colorWithRed:41/255.0 green:110/255.0 blue:205/255.0 alpha:1]];
    [self.verifyCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [inputField addSubview:self.verifyCodeBtn];
}

-(UIButton*)setRegisterBtn:(UIView*)currView
{
    UIButton* loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [loginBtn setFrame:
     CGRectMake(0,currView.frame.size.height/2+40, currView.frame.size.width, 40)];
    [loginBtn setTitle:@"注   册" forState:UIControlStateNormal];
    //[loginBtn.titleLabel setFont:[UIFont systemFontOfSize:19]];
    [loginBtn setBackgroundColor:[UIColor colorWithRed:41/255.0 green:110/255.0 blue:205/255.0 alpha:1]];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn.titleLabel setFont:[UIFont systemFontOfSize:22]];
    
    return loginBtn;
}





@end
