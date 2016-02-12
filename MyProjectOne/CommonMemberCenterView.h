//
//  CommonMemberCenterView.h
//  MyProjectOne
//
//  Created by StephenHe on 9/16/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConstants.h" 

@interface CommonMemberCenterView : UIView
{
    NSMutableArray* menuBtns;
}

-(UIButton*)setLeftGoBackButton;

-(UIView*)getCurrentContentView:(UINavigationController*)navigationController;

-(UIButton*)setRightButton;

-(NSMutableArray*)setNavBar:(UINavigationBar*) navigationBar;

-(UIImageView*) setMainImage:(UINavigationBar*) navigationBar;

-(UIView*)getMainContentView:(UIImageView*) mainImage;

-(UIButton*)setExitBtn:(UIImageView*) mainImage;

-(UIView*)getFullSizeContentView:(UINavigationController*)navigationController;

@property(strong,nonatomic)NSString* serverUrl;

@property(strong,nonatomic)NSString* paramUrl;

@end
