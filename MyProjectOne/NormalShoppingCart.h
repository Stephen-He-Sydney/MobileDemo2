//
//  NormalShoppingCart.h
//  MyProjectOne
//
//  Created by StephenHe on 9/17/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "CommonShoppingCartView.h"

@interface NormalShoppingCart : CommonShoppingCartView

@property(strong, nonatomic)UIButton* selectAllBtn;

@property(strong, nonatomic)UILabel* totalPriceVal;

@property(strong,nonatomic)UILabel* selectAllTxt;

@property(strong,nonatomic)UILabel* totalPriceTxt;

@property(strong,nonatomic)UIButton* checkOutBtn;

-(void)getSelectAllTxt:(UIView*)tableViewContainer;

-(void)getSelectAllButton:(UIView*)tableViewContainer;

-(void)getTotalPriceNumber;

-(void)getTotalPriceTitle;

-(void)getGoCheckOutBtn;

@end
