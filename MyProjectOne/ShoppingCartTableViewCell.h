//
//  ShoppingCartTableViewCell.h
//  MyProjectOne
//
//  Created by StephenHe on 9/19/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConstants.h"
#import "CommonFunction.h"

typedef void(^addSingleTotalBlock)(double addTotalPrice);

typedef void(^addChangingTotalBlock)(double changeTotalPrice);

@interface ShoppingCartTableViewCell : UITableViewCell

-(void)placeTickedButton;
-(void)placePlusButton;
-(void)placeQuantityVal;
-(void)placeMinusButton;
-(void)placeQtyText;
-(void)prepareTviewContainer;
-(void)placeMainImage;
-(void)placePriceSection;
-(void)placeProductDescription;

@property(strong,nonatomic)addSingleTotalBlock addTotalPrice;

@property(strong,nonatomic)addChangingTotalBlock changeTotalPrice;

@property(strong,nonatomic)UIView* tViewCellContainer;
@property(strong, nonatomic)UIImageView* mainImage;
@property(strong, nonatomic)UILabel* prodDescription;
@property(strong, nonatomic)UILabel* prodPrice;
@property(strong, nonatomic)UILabel* prodPriceVal;
@property(strong, nonatomic)UILabel* prodQuantityText;
@property(strong, nonatomic)UILabel* prodQuantity;
@property(strong, nonatomic)UIButton* plusBtn;
@property(strong, nonatomic)UIButton* minusBtn;
@property(strong, nonatomic)UIButton* tickedBtn;
@property(strong, nonatomic)UIButton* untickedBtn;

-(double)getCurrentTotalPrice:(NSString*)currQty;

@end
