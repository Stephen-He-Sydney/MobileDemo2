//
//  CommonMemberCenterView.m
//  MyProjectOne
//
//  Created by StephenHe on 9/16/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "CommonMemberCenterView.h"

@implementation CommonMemberCenterView

-(UIButton*)setLeftGoBackButton
{
    UIImage* btnImage = [UIImage imageNamed:@"登录_03"];
    
    btnImage = [btnImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIButton* goBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [goBackBtn setFrame:CGRectMake(0, 0, 12, 20)];
    [goBackBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
    
    return goBackBtn;
}

-(UIButton*)setRightButton
{
    UIButton* rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [rightBtn setFrame:CGRectMake(0, 0, 60, 40)];
    
    [rightBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:22]];
   
    [rightBtn setBackgroundColor:[UIColor clearColor]];
    
    //[rightBtn setBackgroundColor:[UIColor redColor]];
    
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    return rightBtn;
}

-(UIView*)getCurrentContentView:(UINavigationController*)navigationController
{
    UIView* contentView =  [[UIView alloc]initWithFrame:CGRectMake(15,navigationController.navigationBar.frame.origin.y+navigationController.navigationBar.frame.size.height+15,CURRSIZE.width-30, 600)];
    
    return contentView;
}

-(UIView*)getFullSizeContentView:(UINavigationController*)navigationController
{
    UIView* contentView =  [[UIView alloc]initWithFrame:CGRectMake(0,navigationController.navigationBar.frame.origin.y+navigationController.navigationBar.frame.size.height,CURRSIZE.width, 620)];
    
    //[contentView setBackgroundColor:[UIColor purpleColor]];
    
    return contentView;
}

-(NSMutableArray*)setNavBar:(UINavigationBar*) navigationBar
{
    menuBtns = [[NSMutableArray alloc]init];
    
    NSArray* menuTexts = @[@"订单详情",@"优惠劵",@"会员信息",@"收货地址",@"消息"];
    for (int i = 0; i < 5; i++) {
        UIButton* menuBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [menuBtn setFrame:CGRectMake(i*CURRSIZE.width/5,0,CURRSIZE.width/5,navigationBar.frame.size.height/2+10)];
        
        [menuBtn setTitle:[menuTexts objectAtIndex:i] forState:UIControlStateNormal];
        [menuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [menuBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
        [menuBtn setBackgroundColor:[UIColor colorWithRed:41/255.0 green:110/255.0 blue:205/255.0 alpha:1]];
        [menuBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        
        [menuBtns addObject:menuBtn];
    }
    return menuBtns;
}

-(UIImageView*) setMainImage:(UINavigationBar*) navigationBar
{
    UIImageView* mainImage = [[UIImageView alloc]
                              initWithFrame:CGRectMake(0,navigationBar.frame.size.height/2+10, CURRSIZE.width,CURRSIZE.height/5)];
    [mainImage setImage:[UIImage imageNamed:@"会员信息_02"]];
    
    UIImageView* roundImage = [[UIImageView alloc]
                               initWithFrame:CGRectMake(mainImage.frame.size.width/2-CURRSIZE.width/12,mainImage.frame.size.height/8, CURRSIZE.width/6,mainImage.frame.size.height/2)];
    [roundImage setImage:[UIImage imageNamed:@"会员中心"]];
    [mainImage addSubview:roundImage];
    [mainImage setUserInteractionEnabled:YES];
    
    return mainImage;
}

-(UIButton*)setExitBtn:(UIImageView*) mainImage
{
    UIButton* exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitBtn setFrame:
     CGRectMake(mainImage.frame.size.width/2-CURRSIZE.width/12,mainImage.frame.size.height/8+mainImage.frame.size.height/2+10, CURRSIZE.width/6,30)];
    [exitBtn setBackgroundImage:[UIImage imageNamed:@"会员中心注销"] forState:UIControlStateNormal];
    [exitBtn setTitle:@"注销" forState:UIControlStateNormal];
    [exitBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [exitBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];

    return exitBtn;
}

-(UIView*)getMainContentView:(UIImageView*) mainImage
{
    UIView* contentView =  [[UIView alloc]initWithFrame:CGRectMake(10,mainImage.frame.origin.y+mainImage.frame.size.height+10, CURRSIZE.width-20, 420)];
    
    return contentView;
}

@end
