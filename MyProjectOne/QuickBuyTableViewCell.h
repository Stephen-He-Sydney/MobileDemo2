//
//  QuickBuyTableViewCell.h
//  MyProjectOne
//
//  Created by StephenHe on 9/13/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuickBuyTableViewCell : UITableViewCell

@property(strong, nonatomic)UIView* prodContainer;

@property(strong, nonatomic)UIImageView* prodImage;

@property(strong, nonatomic)UIView* topHalf;

@property(strong, nonatomic)UIView* bottomHalf;

@property(strong, nonatomic) UILabel* remainMins;

@property(strong, nonatomic)UILabel* remainSecond;

-(void)setProdView:(UIView*) viewContainer;

-(void)setHalfTableView;

-(void)setRestOfTableView;

-(void)setMainImage;

-(void)setQtyAlreadyBought:(NSString*)quantity;

-(void)setProductRightInfo:(NSString*)prodName AndProdPrice:(NSString*)prodPrice AndQuickBuyPrice:(NSString*)quickBuyPrice AndRemainQty:(NSString*)remainQty;

-(void)addBottomHalfComponents;

-(NSMutableArray*)setTwoBtns;

@end
