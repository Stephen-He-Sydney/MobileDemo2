//
//  CheckOutController.h
//  MyProjectOne
//
//  Created by StephenHe on 9/22/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "LoginRegisterViewController.h"
#import "CheckOutView.h"
#import "ShoppingCartController.h" 

@interface CheckOutController : LoginRegisterViewController
{
    CheckOutView* checkOutView;
    NSMutableArray* checkOutArray;
}
@property(nonatomic,assign)originalPage currState;
@end
