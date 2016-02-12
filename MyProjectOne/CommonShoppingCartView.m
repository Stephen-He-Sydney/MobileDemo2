//
//  CommonShoppingCartView.m
//  MyProjectOne
//
//  Created by StephenHe on 9/17/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "CommonShoppingCartView.h"

@implementation CommonShoppingCartView

-(UIButton*)setLeftGoBackButton
{
    UIImage* btnImage = [UIImage imageNamed:@"登录_03"];
    
    btnImage = [btnImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIButton* goBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [goBackBtn setFrame:CGRectMake(0, 0, 12, 20)];
    [goBackBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
    
    return goBackBtn;
}

-(UIView*)getCurrentContentView:(UINavigationController*)navigationController
{
     UIView* contentView =  [[UIView alloc]initWithFrame:CGRectMake(0,navigationController.navigationBar.frame.origin.y+navigationController.navigationBar.frame.size.height,CURRSIZE.width, 610)];
    
    return contentView;
}

@end
