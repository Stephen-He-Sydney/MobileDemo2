//
//  CommonHomePageView.m
//  MyProjectOne
//
//  Created by StephenHe on 9/11/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "CommonHomePageView.h"
#import "GlobalConstants.h"

@implementation CommonHomePageView
-(NSMutableArray*)setMenuBar:(UINavigationController*)navigationController
{
    menuBtns = [[NSMutableArray alloc]init];
    
    NSArray* menuTexts = @[@"首页",@"秒杀专区",@"热卖商品"];
    for ( int i = 0; i < 3; i++) {
        UIButton* menuBar = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [menuBar setFrame:
         CGRectMake(i*(CURRSIZE.width/3), navigationController.navigationBar.frame.origin.y + navigationController.navigationBar.frame.size.height, CURRSIZE.width/3, CURRSIZE.height/18)];
        
        [menuBar setTitle:[menuTexts objectAtIndex:i] forState:UIControlStateNormal];
        
        [menuBar.titleLabel setFont:[UIFont boldSystemFontOfSize:22]];
        
        [menuBtns addObject:menuBar];
    }
    
    return menuBtns;
}

-(void)highlightCurrMenuBtn:(int)btnIndex
{
    for (int i = 0; i < [menuBtns count]; i++) {
        if (i == btnIndex)
        {
            [menuBtns[i] setBackgroundColor:[UIColor whiteColor]];
            
            [menuBtns[i] setTitleColor:[UIColor colorWithRed:41/255.0 green:110/255.0 blue:205/255.0 alpha:1] forState:UIControlStateNormal];
            
        }
        else
        {
            [menuBtns[i] setBackgroundColor:[UIColor colorWithRed:41/255.0 green:110/255.0 blue:205/255.0 alpha:1]];
            
            [menuBtns[i] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}

/* scroll view codes */
-(UIScrollView*)setAdvScrollViewContainer:(UINavigationController*)navigationController
{
    NSArray* fileNamelist = @[@"秒杀专区_02",@"car.jpg",@"car2.jpg",@"car3.jpg",@"car4.jpg",@"car5.jpg"];
    
    self.totalPage = (int)[fileNamelist count];
    
    advScrollView = [[UIScrollView alloc]
                     initWithFrame:CGRectMake(0,navigationController.navigationBar.frame.origin.y +navigationController.navigationBar.frame.size.height+CURRSIZE.height/18, CURRSIZE.width, CURRSIZE.height/4)];
    
    [advScrollView setContentSize:CGSizeMake(CURRSIZE.width*self.totalPage, CURRSIZE.height/4)];
    [advScrollView setPagingEnabled:YES];
    [advScrollView setShowsHorizontalScrollIndicator:NO];
    [advScrollView setShowsVerticalScrollIndicator:NO];
    
    [self setAdvsToScrollView:self.totalPage WithfileNamelist:fileNamelist];
    
    return advScrollView;
}

-(void)setAdvsToScrollView:(int)length WithfileNamelist:(NSArray*)fileNamelist
{
    for (int i = 0; i < length; i++){
        UIImageView* imageView = [[UIImageView alloc]
                                  initWithFrame:CGRectMake(advScrollView.frame.size.width*i, 0, advScrollView.frame.size.width, advScrollView.frame.size.height)];
        
        imageView.image = [UIImage imageNamed:fileNamelist[i]];
        [advScrollView addSubview:imageView];
    }
}

-(UIPageControl*)setTimerAndPageControl
{
    pageControl = [[UIPageControl alloc]
                   initWithFrame:CGRectMake(0,advScrollView.frame.origin.y+advScrollView.frame.size.height, CURRSIZE.width, 10)];
    
    [pageControl setNumberOfPages:self.totalPage];
    [pageControl setBackgroundColor:[UIColor lightGrayColor]];
    
    return pageControl;
}

-(UIView*)getCurrentContentView:(UIPageControl*)pControl
{
    UIView* contentView =  [[UIView alloc]initWithFrame:CGRectMake(0,pControl.frame.origin.y+pControl.frame.size.height+10,CURRSIZE.width, 375)];
    
    return contentView;
}

-(UIButton*)getProductMainButton
{
    UIButton* productButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [productButton setFrame:
     CGRectMake(10,0,CURRSIZE.width/4, 35)];
    //[self.productButton setTitle:@"大家电" forState:UIControlStateNormal];
    [productButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [productButton setBackgroundColor:[UIColor colorWithRed:41/255.0 green:110/255.0 blue:205/255.0 alpha:1]];
    [productButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    return productButton;
}

-(UIView*)getViewDisplayContainer:(UIButton*)btn
{
    UIView* contentView =  [[UIView alloc]initWithFrame:CGRectMake(10,btn.frame.origin.y+btn.frame.size.height+10,CURRSIZE.width-20, 330)];
   
    return contentView;
}

-(UICollectionViewFlowLayout*)getFlowlayout
{
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
    [layout setItemSize:CGSizeMake((CURRSIZE.width-30)/2, 170)];
    [layout setMinimumInteritemSpacing:10];
    [layout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    return layout;
}

-(UICollectionView*)getCollectionView:(UIView*)currContainer
{
    UICollectionView* collectionView = [[UICollectionView alloc]
                      initWithFrame:currContainer.bounds collectionViewLayout:[self getFlowlayout]];
    
    [collectionView setBackgroundColor:[UIColor clearColor]];
    
    [collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"collectionView"];
    
    return collectionView;
}

@end
