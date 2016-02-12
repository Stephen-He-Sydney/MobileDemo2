//
//  MemberCenterController.h
//  MyProjectOne
//
//  Created by StephenHe on 9/18/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "LoginRegisterViewController.h"
#import "OrderDetailView.h"
#import "MemberInfoView.h"
#import "ClaimProductView.h"
#import "ShoppingCartController.h"

@interface MemberCenterController : LoginRegisterViewController<UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate>
{
    CommonMemberCenterView* commMemberCenter;
    OrderDetailView* orderDetail;
    MemberInfoView* memberInfo;
    ClaimProductView* claimProduct;
    int menuBtnIndex;
    NSMutableArray* menuBtns;
    UIImageView* mainImage;
    UIButton* exitButton;
    
    UIView* orderDetailContent;
    
    UIView* memberInfoContent;
    UIView* memberInfoLabelContent;
    NSMutableArray* infoData;
    
    UIView* memberInfoEditContent;
    NSMutableArray* imageButtonArry;
    NSMutableArray* dropDownListArry;
    NSMutableArray* textFields;
    NSMutableArray* birthdaySelectedTxt;
    NSMutableArray* addressSelectedTxt;
    NSMutableArray* yearArray;
    NSMutableArray* monthArray;
    NSMutableArray* dateArray;
    NSArray* provinceArray;
    NSArray* cityArray;
    NSArray* streetArray;
    NSMutableArray* tableViews;
    
    NSString* birthdayVal;
    BOOL isMale;
    NSMutableDictionary* saveFields;
   
    UIView* claimProductContent;
}

@property(assign,nonatomic)originalPage currState;
@property(assign,nonatomic)NSMutableArray* checkOutArry;
@end
