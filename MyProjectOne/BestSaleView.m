//
//  BestSaleView.m
//  MyProjectOne
//
//  Created by StephenHe on 9/11/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "BestSaleView.h"

@implementation BestSaleView

-(UIView*)getCurrentContentView:(UIPageControl*)pControl
{
    UIView* bestSaleView = [super getCurrentContentView:pControl];
    
    //[bestSaleView setBackgroundColor:[UIColor greenColor]];
    
    return bestSaleView;
}

-(UIButton*)getProductMainButton
{
    UIButton* productButton = [super getProductMainButton];
    [productButton setTitle:@"热卖商品" forState:UIControlStateNormal];
    
    return productButton;
}

-(UIView*)getViewDisplayContainer:(UIButton*)btn
{
    UIView* container = [super getViewDisplayContainer:btn];
    //[container setBackgroundColor:[UIColor yellowColor]];
    
    return container;
}

-(UICollectionView*)getCollectionView:(UIView*)currContainer
{
    return [super getCollectionView:currContainer];
}

@end
