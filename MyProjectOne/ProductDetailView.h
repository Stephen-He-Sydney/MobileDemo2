//
//  ProductDetailView.h
//  MyProjectOne
//
//  Created by StephenHe on 9/22/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConstants.h"

@interface ProductDetailView : UIView

@property(strong,nonatomic)NSString* prodID;

@property(strong,nonatomic)UIImageView* prodImage;

@property(strong,nonatomic)UILabel* currTitle;

@property(strong,nonatomic)UILabel* pointTxt;

-(void)setMainImage:(UINavigationController*)navigationController;

-(void)setProductTitle;

-(NSMutableArray*)setProdPrice;

-(void)setProdPoints;

-(NSMutableArray*)setStarMark;

@end
