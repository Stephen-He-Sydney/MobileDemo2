//
//  LoginRegisterViewController.h
//  MyProjectOne
//
//  Created by StephenHe on 9/18/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginView.h"
#import "RegisterView.h"
#import "CustomHttpRequest.h"
#import "CommonControllersView.h"
#import "CommonFunction.h"

typedef enum sourcePage{
    none,
    shoppingcartPage,
    quickBuyPage
}originalPage;
@interface LoginRegisterViewController : UIViewController<UITextFieldDelegate>
{
    UIView* loginView;
    UIView* registerView;

    LoginView* loginObj;
    RegisterView* registerObj;

    UIView* fullSizeView;
    
    CommonControllersView* commView;
}

-(void)initializeAttributes;

-(UIButton*)bindNavLeftBarButton;

-(void)reflectNavigationBarRightBtn;

-(void)redirectToLoginView;

-(void)setAllStaticViews:(int)currTag;

-(BOOL)verifyLoginStatus;

-(void)resetCurrView;

@end









