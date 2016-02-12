//
//  EmptyShoppingCart.h
//  MyProjectOne
//
//  Created by StephenHe on 9/17/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "CommonShoppingCartView.h"

@interface EmptyShoppingCart : CommonShoppingCartView
{
    UIImageView* prodImage;
    UILabel* hintLabel;
    UIButton* shoppingBtn;
}

-(UIImageView*)getProdImage:(UINavigationController*)navigationController;

-(UILabel*)getHintLabel;

-(UIButton*)getGoShoppingButton;

@end
