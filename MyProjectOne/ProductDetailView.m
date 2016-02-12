//
//  ProductDetailView.m
//  MyProjectOne
//
//  Created by StephenHe on 9/22/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "ProductDetailView.h"

@implementation ProductDetailView

-(void)setMainImage:(UINavigationController*)navigationController
{
    self.prodImage = [[UIImageView alloc]initWithFrame:CGRectMake(80, navigationController.navigationBar.frame.origin.y+navigationController.navigationBar.frame.size.height+10, CURRSIZE.width-160, 130)];
    
    self.prodImage.image = [UIImage imageNamed:@"秒杀专区_05"];
    self.prodImage.contentMode = UIViewContentModeScaleAspectFit;
}

-(void)setProductTitle
{
    self.currTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, self.prodImage.frame.origin.y+self.prodImage.frame.size.height+25, CURRSIZE.width-20, 20)];
    [self.currTitle setText:@"智能电视"];
    [self.currTitle setFont:[UIFont boldSystemFontOfSize:16]];
    //[self.currTitle setBackgroundColor:[UIColor redColor]];
    [self.currTitle setTextAlignment:NSTextAlignmentCenter];
}

-(NSMutableArray*)setProdPrice
{
    NSMutableArray* priceElements = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 2; i++) {
        UILabel* displayLabel = [[UILabel alloc]initWithFrame:CGRectMake(20+60*i, self.currTitle.frame.origin.y+self.currTitle.frame.size.height+15, 90, 20)];
        [displayLabel setFont:[UIFont boldSystemFontOfSize:16]];
        //[displayLabel setBackgroundColor:[UIColor redColor]];
        [priceElements addObject:displayLabel];
    }
    
    return priceElements;
}

-(void)setProdPoints
{
    self.pointTxt = [[UILabel alloc]initWithFrame:CGRectMake(20, self.currTitle.frame.origin.y+self.currTitle.frame.size.height+40, 90, 20)];
    [self.pointTxt setText:@"商品积分:"];
    [self.pointTxt setFont:[UIFont boldSystemFontOfSize:16]];
}

-(NSMutableArray*)setStarMark
{
    NSMutableArray* stars = [[NSMutableArray alloc]init];
    for (int i = 0; i < 5; i++) {
        UIImageView* star = [[UIImageView alloc]initWithFrame:CGRectMake(90+25*i,self.currTitle.frame.origin.y+self.currTitle.frame.size.height+40,30,20)];
        
        star.image = [UIImage imageNamed:@"评价_03"];
        star.contentMode = UIViewContentModeScaleAspectFit;
        [stars addObject:star];
    }
    
    return stars;
}

@end





