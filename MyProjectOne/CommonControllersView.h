//
//  CommonControllersView.h
//  MyProjectOne
//
//  Created by StephenHe on 9/18/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonControllersView : UIView

-(UIButton*)setLeftGoBackButton;

+(void)promptSingleButtonWarningDialog:(NSString*)msg;

-(UITableView*)getCurrentTableView:(UIView*)currContainer;

@end
