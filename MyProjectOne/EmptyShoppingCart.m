//
//  EmptyShoppingCart.m
//  MyProjectOne
//
//  Created by StephenHe on 9/17/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "EmptyShoppingCart.h"

@implementation EmptyShoppingCart

-(UIView*)getCurrentContentView:(UINavigationController*)navigationController
{
    UIView* currView = [super getCurrentContentView:navigationController];
    //[currView setBackgroundColor:[UIColor greenColor]];
    
    return currView;
}

-(UIImageView*)getProdImage:(UINavigationController*)navigationController
{
    prodImage = [[UIImageView alloc]
                 initWithFrame:CGRectMake(CURRSIZE.width/4-10,navigationController.navigationBar.frame.origin.y + navigationController.navigationBar.frame.size.height,CURRSIZE.width/2,CURRSIZE.width/2)];
    [prodImage setImage:[UIImage imageNamed:@"购物车--空_0w"]];

    return prodImage;
}

-(UILabel*)getHintLabel
{
    hintLabel = [[UILabel alloc]
                 initWithFrame:CGRectMake(prodImage.frame.origin.x-10,prodImage.frame.origin.y+prodImage.frame.size.height+20,prodImage.frame.size.width+20,30)];
    [hintLabel setText:@"您的购物车空空如也,快去逛逛吧!"];
    [hintLabel setFont:[UIFont boldSystemFontOfSize:15]];
    //[titleLabel setTextAlignment:NSTextAlignmentCenter];
    [hintLabel setTextColor:[UIColor lightGrayColor]];

    return hintLabel;
}

-(UIButton*)getGoShoppingButton
{
    shoppingBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [shoppingBtn setFrame:
     CGRectMake(hintLabel.frame.origin.x+45,hintLabel.frame.origin.y+hintLabel.frame.size.height+30, CURRSIZE.width/3,40)];
    [shoppingBtn setTitle:@"马上去逛逛" forState:UIControlStateNormal];
    [shoppingBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [shoppingBtn setBackgroundColor:[UIColor colorWithRed:41/255.0 green:110/255.0 blue:205/255.0 alpha:1]];
    [shoppingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    return shoppingBtn;
}

@end
