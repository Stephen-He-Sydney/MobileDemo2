//
//  OrderDetailView.m
//  MyProjectOne
//
//  Created by StephenHe on 9/17/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "OrderDetailView.h"

@implementation OrderDetailView

-(UIView*)getMainContentView:(UIImageView*) mainImage
{
    UIView* currentMainView = [super getMainContentView:mainImage];
    
    [currentMainView setBackgroundColor:[UIColor redColor]];
    
    return currentMainView;
}

@end
