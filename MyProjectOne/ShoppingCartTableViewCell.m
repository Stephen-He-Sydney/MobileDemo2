//
//  ShoppingCartTableViewCell.m
//  MyProjectOne
//
//  Created by StephenHe on 9/19/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "ShoppingCartTableViewCell.h"

@implementation ShoppingCartTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self prepareTviewContainer];
        
        [self placeMainImage];
        
        [self placeProductDescription];
        
        [self placePriceSection];
        
        [self placeQtyText];
        
        [self placeMinusButton];
        
        [self placeQuantityVal];
        
        [self placePlusButton];
        
        [self placeTickedButton];
    }
    return self;
}

-(void)placeTickedButton
{
    self.tickedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.tickedBtn setFrame:CGRectMake(CURRSIZE.width-50,30, 20, 20)];
    [self.tickedBtn setBackgroundImage:[UIImage imageNamed:@"购物车_13"] forState:UIControlStateNormal];
    [self.tickedBtn addTarget:self action:@selector(toggleTickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.tViewCellContainer addSubview:self.tickedBtn];
}

-(void)placePlusButton
{
    self.plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.plusBtn setFrame:CGRectMake(self.prodQuantity.frame.origin.x+self.prodQuantity.frame.size.width, self.prodPrice.frame.origin.y+28, 25, 25)];
    [self.plusBtn setBackgroundImage:[UIImage imageNamed:@"购物车_09"] forState:UIControlStateNormal];
    [self.plusBtn addTarget:self action:@selector(plusBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.tViewCellContainer addSubview:self.plusBtn];
}

-(void)placeQuantityVal
{
    self.prodQuantity = [[UILabel alloc]initWithFrame:CGRectMake(self.minusBtn.frame.origin.x+self.minusBtn.frame.size.width,self.prodPrice.frame.origin.y+28,40,25)];
    [self.prodQuantity setText:@"1"];
    [self.prodQuantity setFont:[UIFont systemFontOfSize:15]];
    [self.prodQuantity.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.prodQuantity.layer setBorderWidth:1];
    [self.prodQuantity setTextAlignment:NSTextAlignmentCenter];

    [self.tViewCellContainer addSubview:self.prodQuantity];
}

-(void)placeMinusButton
{
    self.minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.minusBtn setFrame:CGRectMake(self.prodQuantityText.frame.origin.x+self.prodQuantityText.frame.size.width+5, self.prodPrice.frame.origin.y+28, 25, 25)];
    [self.minusBtn setBackgroundImage:[UIImage imageNamed:@"购物车_07"] forState:UIControlStateNormal];
    [self.minusBtn addTarget:self action:@selector(minusBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.tViewCellContainer addSubview:self.minusBtn];
}

-(void)placeQtyText
{
    self.prodQuantityText = [[UILabel alloc]initWithFrame:CGRectMake(self.mainImage.frame.origin.x+self.mainImage.frame.size.width+20,self.prodPrice.frame.origin.y+30,CURRSIZE.width/6,20)];
    [self.prodQuantityText setText:@"购买数量:"];
    [self.prodQuantityText setFont:[UIFont systemFontOfSize:15]];

    [self.tViewCellContainer addSubview:self.prodQuantityText];
}

-(void)prepareTviewContainer
{
    self.tViewCellContainer = [[UIView alloc]
                                  initWithFrame:CGRectMake(0, 0, CURRSIZE.width, CURRSIZE.height/4-20)];

    [self.contentView addSubview:self.tViewCellContainer];
}

-(void)placeMainImage
{
    self.mainImage = [[UIImageView alloc] initWithFrame:CGRectMake(30, self.tViewCellContainer.frame.size.height/3-20, CURRSIZE.width/5+10, self.tViewCellContainer.frame.size.height/4+10)];
    
    self.mainImage.contentMode = UIViewContentModeScaleAspectFit;
    self.mainImage.image = [UIImage imageNamed:@"noimage"];
    
    [self.tViewCellContainer addSubview:self.mainImage];
}

-(void)placePriceSection
{
    self.prodPrice = [[UILabel alloc]initWithFrame:CGRectMake(self.mainImage.frame.origin.x+self.mainImage.frame.size.width+20,self.prodDescription.frame.origin.y+30,CURRSIZE.width/8,20)];
    [self.prodPrice setText:@"促销价:"];
    [self.prodPrice setFont:[UIFont systemFontOfSize:14]];

    [self.tViewCellContainer addSubview:self.prodPrice];
    
    self.prodPriceVal = [[UILabel alloc]initWithFrame:CGRectMake(self.prodPrice.frame.origin.x+self.prodPrice.frame.size.width+5,self.prodDescription.frame.origin.y+30,CURRSIZE.width/5, 20)];
    [self.prodPriceVal setFont:[UIFont systemFontOfSize:15]];
    [self.prodPriceVal setTextColor:[UIColor redColor]];

    [self.tViewCellContainer setUserInteractionEnabled:YES];
    [self.tViewCellContainer addSubview:self.prodPriceVal];
}

-(void)placeProductDescription
{
    self.prodDescription = [[UILabel alloc]initWithFrame:CGRectMake(self.mainImage.frame.origin.x+self.mainImage.frame.size.width+20, 30, CURRSIZE.width/3, 20)];

    [self.prodDescription setFont:[UIFont systemFontOfSize:14]];
    [self.tViewCellContainer addSubview:self.prodDescription];
}

-(void)minusBtnAction:(id)sender
{
    if ([UIImagePNGRepresentation([self.tickedBtn backgroundImageForState:UIControlStateNormal]) isEqualToData:UIImagePNGRepresentation([UIImage imageNamed:@"购物车_03"])])
    {
        int currQty = (int)[self.prodQuantity.text integerValue];
        if (currQty > 1)
        {
            currQty--;
            self.prodQuantity.text = [NSString stringWithFormat:@"%d",currQty];
            
            self.changeTotalPrice(-[self getCurrentTotalPrice:@"1"]);
        }
    }
}

-(void)plusBtnAction:(id)sender
{
    if ([UIImagePNGRepresentation([self.tickedBtn backgroundImageForState:UIControlStateNormal]) isEqualToData:UIImagePNGRepresentation([UIImage imageNamed:@"购物车_03"])])
    {
        int currQty = (int)[self.prodQuantity.text integerValue];
        currQty++;
        self.prodQuantity.text = [NSString stringWithFormat:@"%d",currQty];
        
        self.changeTotalPrice([self getCurrentTotalPrice:@"1"]);
    }
}

-(void)toggleTickBtn:(id)sender
{
    UIButton* btn = (UIButton*)sender;
        
    if ([UIImagePNGRepresentation([btn backgroundImageForState:UIControlStateNormal]) isEqualToData:UIImagePNGRepresentation([UIImage imageNamed:@"购物车_13"])])
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"购物车_03"] forState:UIControlStateNormal];

        self.addTotalPrice([self getCurrentTotalPrice:self.prodQuantity.text]);
    }
    else{
        [btn setBackgroundImage:[UIImage imageNamed:@"购物车_13"] forState:UIControlStateNormal];
        self.addTotalPrice(-[self getCurrentTotalPrice:self.prodQuantity.text]);
    }
}

-(double)getCurrentTotalPrice:(NSString*)currQty
{
    currQty = [CommonFunction trimString:currQty];
    self.prodPriceVal.text = [CommonFunction trimString:self.prodPriceVal.text];
    double unitPrice = (double)[[self.prodPriceVal.text substringFromIndex:1] doubleValue];
    double quantity = (double)[currQty doubleValue];
    
    return unitPrice * quantity;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
