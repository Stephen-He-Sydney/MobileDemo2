//
//  CustomCollectionViewCell.m
//  MyProjectOne
//
//  Created by StephenHe on 9/11/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setProdPanelBorder];
        
        [self setProdMainImage];
        
        [self setProdTextPanel];
        
        [self setProdDescription];
        
        [self setProdPrice];
    }
    
    return self;
}

-(void)setProdPanelBorder
{
    [self.contentView.layer setBorderColor:[[UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1] CGColor]];
    [self.contentView.layer setBorderWidth:1];
}

-(void)setProdMainImage
{
    self.mainImage = [[UIImageView alloc]
                      initWithFrame:CGRectMake(40, 20, (CURRSIZE.width-30)/3-20, 75)];
    
    self.mainImage.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.contentView addSubview:self.mainImage];
}

-(void)setProdTextPanel
{
    self.prodTextPanel = [[UIImageView alloc]
                          initWithFrame:CGRectMake(0,self.contentView.frame.size.height-55,self.contentView.frame.size.width,55)];
    [self.prodTextPanel setBackgroundColor:[UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1]];
    [self.contentView addSubview:self.prodTextPanel];
}

-(void)setProdDescription
{
    self.prodDesp = [[UILabel alloc]initWithFrame:CGRectMake(5, 0,self.contentView.frame.size.width,self.contentView.frame.size.height/5)];
    [self.prodDesp setText:@"TCL LE50D69 50英寸"];
    [self.prodDesp setFont:[UIFont systemFontOfSize:13]];
    [self.prodDesp setTextColor:[UIColor darkGrayColor]];
    [self.prodTextPanel addSubview:self.prodDesp];
}

-(void)setProdPrice
{
    UILabel* rmbSign = [[UILabel alloc]initWithFrame:CGRectMake(5, 22,10,self.contentView.frame.size.height/5)];
    
    [rmbSign setText:@"￥"];
    [rmbSign setTextColor:[UIColor redColor]];
    [rmbSign setFont:[UIFont systemFontOfSize:13]];
    [self.prodTextPanel addSubview:rmbSign];
    
    
    self.prodPrice = [[UILabel alloc]initWithFrame:CGRectMake(20, 22,self.contentView.frame.size.width,self.contentView.frame.size.height/5)];
    [self.prodPrice setText:@"8000"];
    [self.prodPrice setTextColor:[UIColor redColor]];
    [self.prodPrice setFont:[UIFont systemFontOfSize:13]];
    [self.prodTextPanel addSubview:self.prodPrice];
}

@end
