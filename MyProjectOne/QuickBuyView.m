//
//  QuickBuyView.m
//  MyProjectOne
//
//  Created by StephenHe on 9/11/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "QuickBuyView.h"

@implementation QuickBuyView

-(UIView*)getCurrentContentView:(UIPageControl*)pControl
{
    UIView* quickBuyView = [super getCurrentContentView:pControl];
    
    //[quickBuyView setBackgroundColor:[UIColor yellowColor]];
    
    return quickBuyView;
}

-(UIButton*)getProductMainButton
{
    UIButton* productButton = [super getProductMainButton];
    [productButton setTitle:@"秒杀专区" forState:UIControlStateNormal];
    
    return productButton;
}

-(UIView*)getViewDisplayContainer:(UIButton*)btn
{
    UIView* container = [super getViewDisplayContainer:btn];
    //[container setBackgroundColor:[UIColor blueColor]];
    
    return container;
}

@end
