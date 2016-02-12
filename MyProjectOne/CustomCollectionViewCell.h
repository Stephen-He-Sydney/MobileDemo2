//
//  CustomCollectionViewCell.h
//  MyProjectOne
//
//  Created by StephenHe on 9/11/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConstants.h" 

@interface CustomCollectionViewCell : UICollectionViewCell

@property(strong, nonatomic) UIImageView* mainImage;

@property(strong, nonatomic) UIImageView* prodTextPanel;

@property(strong, nonatomic) UILabel* prodDesp;

@property(strong, nonatomic) UILabel* prodPrice;

@end
