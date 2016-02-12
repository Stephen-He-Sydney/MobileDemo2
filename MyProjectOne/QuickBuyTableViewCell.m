//
//  QuickBuyTableViewCell.m
//  MyProjectOne
//
//  Created by StephenHe on 9/13/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "QuickBuyTableViewCell.h"

@implementation QuickBuyTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //自定义
    }
    return self;
}

-(void)setProdView:(UIView*) viewContainer
{
    self.prodContainer =[[UIView alloc]initWithFrame:CGRectMake(0,0,viewContainer.frame.size.width,viewContainer.frame.size.height/7*6-30)];
    
    [self.prodContainer.layer setBorderColor:[[UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1] CGColor]];
    
    [self.prodContainer.layer setBorderWidth:1];
    
    //[self.prodContainer setBackgroundColor:[UIColor yellowColor]];
    
    [self.contentView addSubview:self.prodContainer];
}

-(void)setHalfTableView
{
    self.topHalf =[[UIView alloc]initWithFrame:CGRectMake(0,0,self.prodContainer.frame.size.width,self.prodContainer.frame.size.height/2)];
    
    [self.topHalf.layer setBorderColor:[[UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1] CGColor]];
    
    [self.topHalf.layer setBorderWidth:1];
    
    [self.topHalf setUserInteractionEnabled:YES];
    
    [self.prodContainer addSubview:self.topHalf];
}

-(void)setRestOfTableView
{
    self.bottomHalf =[[UIView alloc]initWithFrame:CGRectMake(0,self.topHalf.frame.size.height,self.prodContainer.frame.size.width,self.prodContainer.frame.size.height/2)];
    
    [self.bottomHalf setUserInteractionEnabled:YES];
    
    [self.prodContainer addSubview:self.bottomHalf];
}

-(void)setMainImage
{
    self.prodImage = [[UIImageView alloc]
                      initWithFrame:CGRectMake(0,15,self.topHalf.frame.size.width/2-40,self.topHalf.frame.size.height/5*4-30)];
    
    self.prodImage.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.topHalf addSubview:self.prodImage];
}

-(void)setQtyAlreadyBought:(NSString*)quantity
{
    UILabel* qtyBoughtTxt = [[UILabel alloc]initWithFrame:CGRectMake(20,self.prodImage.frame.origin.y+self.prodImage.frame.size.height+10,self.topHalf.frame.size.width/5+10,self.topHalf.frame.size.height/5)];
    [qtyBoughtTxt setText:@"已购买数量:"];
    [qtyBoughtTxt setFont:[UIFont systemFontOfSize:15]];
    [qtyBoughtTxt setTextColor:[UIColor darkGrayColor]];
    [self.topHalf addSubview:qtyBoughtTxt];
    
    UILabel* boughtQuantity = [[UILabel alloc]initWithFrame:CGRectMake(qtyBoughtTxt.frame.origin.x+qtyBoughtTxt.frame.size.width,self.prodImage.frame.origin.y+self.prodImage.frame.size.height+10,self.topHalf.frame.size.width/5,self.topHalf.frame.size.height/5)];
    [boughtQuantity setText:quantity];
    [boughtQuantity setFont:[UIFont systemFontOfSize:15]];
    [boughtQuantity setTextColor:[UIColor darkGrayColor]];
    [self.topHalf addSubview:boughtQuantity];
}

-(void)setProductRightInfo:(NSString*)prodName AndProdPrice:(NSString*)prodPrice AndQuickBuyPrice:(NSString*)quickBuyPrice AndRemainQty:(NSString*)remainQty;
{
    NSArray* txts = @[@"商品名称:",@"商品价格:",@"秒杀价:",@"剩余数量:"];
    NSArray* txtVals = @[prodName,prodPrice,quickBuyPrice,remainQty];
    
    for (int i = 0; i < 4; i++) {
        UILabel* labelTxt = [[UILabel alloc]initWithFrame:CGRectMake(self.prodImage.frame.origin.x+self.prodImage.frame.size.width+5,i*self.topHalf.frame.size.height/5+10,self.topHalf.frame.size.width/5-10,self.topHalf.frame.size.height/5)];
        [labelTxt setText:[txts objectAtIndex:i]];
        [labelTxt setFont:[UIFont systemFontOfSize:15]];
        [labelTxt setTextColor:[UIColor darkGrayColor]];
        //[labelTxt setBackgroundColor:[UIColor redColor]];
        [self.topHalf addSubview:labelTxt];
        
        UILabel* labelVal = [[UILabel alloc]initWithFrame:CGRectMake(self.prodImage.frame.origin.x+self.prodImage.frame.size.width+5+self.topHalf.frame.size.width/5-10,i*self.topHalf.frame.size.height/5+10,self.topHalf.frame.size.width/4,self.topHalf.frame.size.height/5)];
        [labelVal setText:txtVals[i]];
        [labelVal setFont:[UIFont systemFontOfSize:15]];
        [labelVal setTextColor:[UIColor darkGrayColor]];
        [self.topHalf addSubview:labelVal];
    }
}

-(void)addBottomHalfComponents
{
    UILabel* reversingLabel = [[UILabel alloc]
                               initWithFrame:CGRectMake(10,5, self.bottomHalf.frame.size.width/2, self.bottomHalf.frame.size.height/4)];
    [reversingLabel setText:@"倒计时"];
    [reversingLabel setFont:[UIFont boldSystemFontOfSize:18]];
    //[titleLabel setTextAlignment:NSTextAlignmentCenter];
    [reversingLabel setTextColor:[UIColor colorWithRed:203/255.0 green:41/255.0 blue:41/255.0 alpha:1]];
    [self.bottomHalf addSubview:reversingLabel];
    
    //NSArray* arr = @[@"1",@"天",@"1",@"小时"];
    
    NSArray* arr = @[@"0",@"分",@"0",@"秒"];
    
    for (int i = 0; i < 4; i++) {
        UILabel* timerLabel = [[UILabel alloc]
                               initWithFrame:CGRectMake(10+i*(self.bottomHalf.frame.size.width/8),reversingLabel.frame.size.height+10, self.bottomHalf.frame.size.width/8, self.bottomHalf.frame.size.height/3)];
        [timerLabel setText:[arr objectAtIndex:i]];
        [timerLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [timerLabel setTextAlignment:NSTextAlignmentCenter];
        if (i % 2 == 0)//第一个存分钟，第二个存秒
        {
            if (i == 0)
            {
                self.remainMins = timerLabel;
            }
            else
            {
                self.remainSecond = timerLabel;
            }
            
            [timerLabel setBackgroundColor:[UIColor colorWithRed:203/255.0 green:41/255.0 blue:41/255.0 alpha:1]];
            [timerLabel setTextColor:[UIColor whiteColor]];
        }
        else
        {
            [timerLabel setTextColor:[UIColor blackColor]];
        }
        [self.bottomHalf addSubview:timerLabel];
    }
    
    //[self setTwoBtns];
}

-(NSMutableArray*)setTwoBtns
{
    NSMutableArray* purchaseBtns = [[NSMutableArray alloc]init];
    
    NSArray* btnNames= @[@"立即购买",@"加入购物车"];
    for (int i = 0; i < 2; i++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setFrame:CGRectMake(self.bottomHalf.frame.size.width/2+30, (10+self.bottomHalf.frame.size.height/3)*i+10, self.bottomHalf.frame.size.width/3, self.bottomHalf.frame.size.height/3)];
        
        [btn setTitle:[btnNames objectAtIndex:i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        
        if (i == 0)
        {
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [btn setBackgroundColor:[UIColor colorWithRed:41/255.0 green:110/255.0 blue:205/255.0 alpha:1]];
        }
        else
        {
            [btn setTitleColor:[UIColor colorWithRed:80/255.0 green:125/255.0 blue:209/255.0 alpha:1] forState:UIControlStateNormal];
            [btn.layer setBorderColor:[[UIColor colorWithRed:41/255.0 green:110/255.0 blue:205/255.0 alpha:1]CGColor]];
            [btn.layer setBorderWidth:2];
        }
        
        [self.bottomHalf addSubview:btn];
        [purchaseBtns addObject:btn];
    }
    
    return purchaseBtns;
}



@end
