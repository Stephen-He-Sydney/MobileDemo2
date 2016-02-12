//
//  CommonHomePageView.h
//  MyProjectOne
//
//  Created by StephenHe on 9/11/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCollectionViewCell.h"


@interface CommonHomePageView : UIView
{
    NSMutableArray* menuBtns;
    
    UIScrollView* advScrollView;
    
    UIPageControl* pageControl;
}

@property(strong,nonatomic)NSString* serverUrl;
@property(strong,nonatomic)NSString* paramUrl;

@property(assign,nonatomic) int totalPage;

-(NSMutableArray*)setMenuBar:(UINavigationController*)navigationController;

-(void)highlightCurrMenuBtn:(int)btnIndex;

-(UIScrollView*)setAdvScrollViewContainer:(UINavigationController*)navigationController;

-(UIPageControl*)setTimerAndPageControl;

-(UIView*)getCurrentContentView:(UIPageControl*)pControl;

-(UIButton*)getProductMainButton;

-(UIView*)getViewDisplayContainer:(UIButton*)btn;

-(UICollectionViewFlowLayout*)getFlowlayout;

-(UICollectionView*)getCollectionView:(UIView*)currContainer;

@end
