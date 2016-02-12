//
//  HomeView.m
//  MyProjectOne
//
//  Created by StephenHe on 9/11/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "HomeView.h"

@implementation HomeView

-(UIView*)getCurrentContentView:(UIPageControl*)pControl
{
    UIView* homeView = [super getCurrentContentView:pControl];
    
    //[homeView setBackgroundColor:[UIColor blueColor]];
    
    return homeView;
}

-(UIButton*)getProductMainButton
{
    UIButton* productButton = [super getProductMainButton];
    [productButton setTitle:@"大家电" forState:UIControlStateNormal];
    
    return productButton;
}

-(UIView*)getViewDisplayContainer:(UIButton*)btn
{
    UIView* container = [super getViewDisplayContainer:btn];
    //[container setBackgroundColor:[UIColor purpleColor]];
    
    return container;
}

-(UICollectionView*)getCollectionView:(UIView*)currContainer
{
    return [super getCollectionView:currContainer];
}

@end
