//
//  CommonShoppingCartView.h
//  MyProjectOne
//
//  Created by StephenHe on 9/17/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConstants.h"

@interface CommonShoppingCartView : UIView

-(UIButton*)setLeftGoBackButton;

-(UIView*)getCurrentContentView:(UINavigationController*)navigationController;

@end
