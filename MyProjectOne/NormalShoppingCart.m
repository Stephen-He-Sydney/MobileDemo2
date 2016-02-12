//
//  NormalShoppingCart.m
//  MyProjectOne
//
//  Created by StephenHe on 9/17/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "NormalShoppingCart.h"

@implementation NormalShoppingCart

-(UIView*)getCurrentContentView:(UINavigationController*)navigationController
{
    UIView* contentView =  [[UIView alloc]initWithFrame:CGRectMake(0,0,CURRSIZE.width, 300)];
    //[contentView setBackgroundColor:[UIColor redColor]];
    
    return contentView;
}

-(void)getSelectAllButton:(UIView*)tableViewContainer
{
    self.selectAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectAllBtn setFrame:CGRectMake(CURRSIZE.width-50,tableViewContainer.frame.origin.y+tableViewContainer.frame.size.height+25, 20, 20)];
    
    [self.selectAllBtn setBackgroundImage:[UIImage imageNamed:@"购物车_13"] forState:UIControlStateNormal];
}

-(void)getSelectAllTxt:(UIView*)tableViewContainer
{
    self.selectAllTxt = [[UILabel alloc]initWithFrame:CGRectMake(CURRSIZE.width-80-self.selectAllBtn.frame.size.width,tableViewContainer.frame.origin.y+tableViewContainer.frame.size.height+25, 40, 20)];
    [self.selectAllTxt setText:@"全选"];
    [self.selectAllTxt setFont:[UIFont systemFontOfSize:18]];
    [self.selectAllTxt setTextColor:[UIColor blackColor]];
    //[selectAllTxt setBackgroundColor:[UIColor redColor]];
}

-(void)getTotalPriceNumber
{
    self.totalPriceVal = [[UILabel alloc]initWithFrame:CGRectMake(CURRSIZE.width-120,self.selectAllTxt.frame.origin.y+self.selectAllTxt.frame.size.height+25, 110, 20)];
    [self.totalPriceVal setText:@"￥0.00"];
    [self.totalPriceVal setFont:[UIFont systemFontOfSize:18]];
    [self.totalPriceVal setTextColor:[UIColor redColor]];
    //[totalPriceTxt setBackgroundColor:[UIColor blueColor]];
}

-(void)getTotalPriceTitle
{
    self.totalPriceTxt = [[UILabel alloc]initWithFrame:CGRectMake(CURRSIZE.width-self.totalPriceVal.frame.size.width-50,self.selectAllTxt.frame.origin.y+self.selectAllTxt.frame.size.height+25, 40, 20)];
    [self.totalPriceTxt setText:@"小计"];
    [self.totalPriceTxt setFont:[UIFont systemFontOfSize:18]];
    [self.totalPriceTxt setTextColor:[UIColor redColor]];
    //[self.totalPriceTxt setBackgroundColor:[UIColor greenColor]];
}

-(void)getGoCheckOutBtn
{
    self.checkOutBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [self.checkOutBtn setFrame:
     CGRectMake(10,self.totalPriceTxt.frame.origin.y+self.totalPriceTxt.frame.size.height+20,CURRSIZE.width-20, 45)];
    [self.checkOutBtn setTitle:@"去结算" forState:UIControlStateNormal];
    [self.checkOutBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:22]];
    [self.checkOutBtn setBackgroundColor:[UIColor colorWithRed:41/255.0 green:110/255.0 blue:205/255.0 alpha:1]];
    [self.checkOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

@end
