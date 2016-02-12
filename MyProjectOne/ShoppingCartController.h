//
//  ShoppingCartController.h
//  MyProjectOne
//
//  Created by StephenHe on 9/18/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "LoginRegisterViewController.h"
#import "CommonShoppingCartView.h"
#import "NormalShoppingCart.h"
#import "EmptyShoppingCart.h"
#import "ShoppingCartTableViewCell.h"
#import "CheckOutController.h"
#import "CommonFunction.h"
#import "CustomHttpRequest.h"
#import "CommonControllersView.h"
#import "MemberCenterController.h"

@interface ShoppingCartController : LoginRegisterViewController<UITableViewDelegate,
UITableViewDataSource, UIAlertViewDelegate>
{
    CommonMemberCenterView* commMemberCenter;
    CommonShoppingCartView* commShoppingCart;
    NormalShoppingCart* normalShoppingCart;
    EmptyShoppingCart* emptyShoppingCart;
    CommonControllersView* commController;
    
    UIView* normalShoppingCartView;
    UIView* emptyShoppingCartView;
    
    UITableView* shoppingCartTView;
    NSMutableArray* shoppingCartArray;
    
    NSMutableArray* checkOutArry;
    
    bool isSelectAll;
    double updateTotalPrice;
    double changeOfTotalPrice;
}
@end
