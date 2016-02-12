//
//  ProductDetailController.h
//  MyProjectOne
//
//  Created by StephenHe on 9/22/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonControllersView.h"
#import "ProductDetailView.h"

@interface ProductDetailController : UIViewController
{
    ProductDetailView* productDetailView;
    CommonControllersView* commView;
}
@property(strong,nonatomic)NSString* productID;
@property(strong,nonatomic)NSData* productImage;
@property(strong,nonatomic)NSString* currPrice;
@property(strong,nonatomic)NSString* currTitle;
@property(strong,nonatomic)NSString* startDate;
@property(strong,nonatomic)NSString* endDate;

@end
