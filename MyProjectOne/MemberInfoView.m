//
//  MemberInfoView.m
//  MyProjectOne
//
//  Created by StephenHe on 9/17/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "MemberInfoView.h"

@implementation MemberInfoView

-(UIView*)getMainContentView:(UIImageView*) mainImage
{
    UIView* currentMainView = [super getMainContentView:mainImage];
    
    //[currentMainView setBackgroundColor:[UIColor yellowColor]];
    return currentMainView;
}

-(UIView*)getMemberInfoDisplayPanel:(UIView*) containContainer
{
    UIView* contentView =  [[UIView alloc]initWithFrame:CGRectMake(10,10,containContainer.frame.size.width-20,containContainer.frame.size.height-20)];
    
    [contentView.layer setBorderColor:[UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1].CGColor];
    [contentView.layer setBorderWidth:1];
    
    //[contentView setBackgroundColor:[UIColor redColor]];
    
    return contentView;
}

-(NSMutableArray*)setCurrMemberInfo:(NSMutableArray*)labelVals WithParentContainer:(UIView*)parentContainer
{
    NSMutableArray* labels = [[NSMutableArray alloc]init];
    NSArray* labelTxts = @[@"昵称: ",@"性别: ",@"生日: ",@"地址: ",@"邮箱: ",@"电话: "];
    for (int i = 0; i < 6; i++) {
        UILabel* inputLabel = [[UILabel alloc]
                  initWithFrame:CGRectMake(25,15+i*50,parentContainer.frame.size.width-50,30)];
        
        [inputLabel setText:[NSString stringWithString:[[labelTxts objectAtIndex:i]stringByAppendingString:[labelVals objectAtIndex:i]]]];
        
        [inputLabel setFont:[UIFont boldSystemFontOfSize:18]];
        //[inputLabel setBackgroundColor:[UIColor redColor]];
        [labels addObject:inputLabel];
    }
    
    return labels;
}

-(NSMutableArray*)setEmptyMemberInfo:(UIView*)parentContainer
{
    NSMutableArray* labels = [[NSMutableArray alloc]init];
    NSArray* labelTxts = @[@"昵称: ",@"性别: ",@"生日: ",@"地址: ",@"邮箱: ",@"电话: "];
    for (int i = 0; i < 6; i++) {
        UILabel* inputLabel = [[UILabel alloc]
                               initWithFrame:CGRectMake(25,15+i*50,parentContainer.frame.size.width-50,30)];
        
        [inputLabel setText:[labelTxts objectAtIndex:i]];
        
        [inputLabel setFont:[UIFont boldSystemFontOfSize:18]];
        //[inputLabel setBackgroundColor:[UIColor redColor]];
        [labels addObject:inputLabel];
    }
    
    return labels;
}

-(NSMutableArray*)setMemberInfoEditableArea:(UIView*)parentContainer
{
    NSMutableArray* imageViews = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 7; i++) {
        UIImageView* imgView = [[UIImageView alloc]initWithFrame:CGRectMake(15,15+i*45,parentContainer.frame.size.width-30,40)];
        //[imgView setBackgroundColor:[UIColor redColor]];
        [imgView setUserInteractionEnabled:YES];
        [imageViews addObject:imgView];
    }
    
    return imageViews;
}

-(NSMutableArray*)setMemberInfoEditableTxts
{
    NSMutableArray* labels = [[NSMutableArray alloc]init];
    NSArray* labelTxts = @[@"*昵称: ",@" 性别: ",@" 生日: ",@"*地址: ",@" 邮箱: ",@"*电话: "];
    for (int i = 0; i < 6; i++) {
        UILabel* inputLabel = [[UILabel alloc]
                               initWithFrame:CGRectMake(0,0,50,40)];
        
        [inputLabel setText:[labelTxts objectAtIndex:i]];
        [inputLabel setFont:[UIFont boldSystemFontOfSize:17]];
        inputLabel.numberOfLines = 0;//自动换行
        //[inputLabel setBackgroundColor:[UIColor yellowColor]];
        if (i == 0 || i == 3 || i == 5)
        {
            [inputLabel setTextColor:[UIColor redColor]];
        }
        [labels addObject:inputLabel];
    }
    
    return labels;
}

-(NSMutableArray*)setMemberInfoTextFields
{
    NSMutableArray* textFields = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 4; i++) {
        UITextField* textfield =[[UITextField alloc]
                               initWithFrame:CGRectMake(50,0,300,40)];
        
        [textfield setClearButtonMode:UITextFieldViewModeWhileEditing];
        [textfield setAutocapitalizationType:UITextAutocapitalizationTypeNone];
      
        [textfield.layer setBorderColor:[UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1].CGColor];
        [textfield.layer setBorderWidth:1];
        
        [textFields addObject:textfield];
    }

    return textFields;
}

-(UILabel*)readOnlyNickNameField
{
    UILabel* nickName = [[UILabel alloc]
                           initWithFrame:CGRectMake(50,0,270,40)];
    [nickName setFont:[UIFont boldSystemFontOfSize:17]];
    
    return nickName;
}

-(NSMutableArray*)setGenderOption
{
    NSMutableArray* options = [[NSMutableArray alloc]init];
    int j = 0;
    for (int i = 0; i < 4; i++) {
        if (i == 0 || i == 2)
        {
            UIImageView* imageButton = [[UIImageView alloc]initWithFrame:CGRectMake(55+50*i, 7, 25, 25)];
            
            imageButton.image = i==0?[UIImage imageNamed:@"会员信息_05"]:[UIImage imageNamed:@"会员信息_07"];
            [imageButton setUserInteractionEnabled:YES];
            [options addObject:imageButton];
        }
        else
        {
            UILabel* genderTxt = [[UILabel alloc]initWithFrame:CGRectMake(85+100*j, 5, 30, 30)];
            genderTxt.text = i == 1? @"男":@"女";
            [genderTxt setFont:[UIFont boldSystemFontOfSize:20]];
            
            [options addObject:genderTxt];
            j++;
        }
    }
    
    return options;
}

-(NSMutableArray*)setStartDropDownPanel
{
    NSMutableArray* startDropDownLists = [[NSMutableArray alloc]init];

    for (int i = 0; i < 3; i++) {

        UIImageView* startDropDownList = [[UIImageView alloc]initWithFrame:CGRectMake(50+100*i, 5, 93, 30)];
        [startDropDownList.layer setBorderColor:[UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1].CGColor];
        [startDropDownList.layer setBorderWidth:1];
        [startDropDownList setUserInteractionEnabled:YES];
        
        [startDropDownLists addObject:startDropDownList];
    }
    
    return startDropDownLists;
}

-(NSMutableArray*)setDropDownIcon
{
    NSMutableArray* dropDownIcons = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 3; i++) {
        
        UIImageView* dropDownIcon = [[UIImageView alloc]initWithFrame:CGRectMake(63,0,30,30)];
        [dropDownIcon.layer setBorderColor:[UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1].CGColor];
        [dropDownIcon.layer setBorderWidth:1];
        [dropDownIcon setUserInteractionEnabled:YES];

        UIImageView* curIcon = [[UIImageView alloc]initWithFrame:CGRectMake(8, 13, dropDownIcon.frame.size.width/3+3, dropDownIcon.frame.size.height/3-3)];
        curIcon.image = [UIImage imageNamed:@"去结算_07"];
        [dropDownIcon addSubview:curIcon];
        
        [dropDownIcons addObject:dropDownIcon];
    }
    
    return dropDownIcons;
}

-(NSMutableArray*)setSelectedTextPanel
{
    NSMutableArray* selectedTxtPanel = [[NSMutableArray alloc]init];
    for (int i = 0; i < 3; i++) {
        UILabel* showLabel = [[UILabel alloc]
                               initWithFrame:CGRectMake(0,0,63,30)];
        
        [showLabel setFont:[UIFont systemFontOfSize:14]];
        [showLabel setTextAlignment:NSTextAlignmentCenter];
        [showLabel setText:@"--选择--"];
        [selectedTxtPanel addObject:showLabel];
    }
    
    return selectedTxtPanel;
}

-(UIView*)setDropDownListContainer:(CGFloat)width WithHeight:(CGFloat)height WithStartLeft:(CGFloat)startLeft WithStartTop:(CGFloat)startTop
{
    UIView* dropDownList = [[UIView alloc]initWithFrame:CGRectMake(startLeft,startTop,width,height)];
    [dropDownList.layer setBorderColor:[UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1].CGColor];
    [dropDownList.layer setBorderWidth:1];
    [dropDownList setUserInteractionEnabled:YES];
    [dropDownList setBackgroundColor:[UIColor whiteColor]];
    
    return dropDownList;
}

-(NSMutableArray*)setTwoChangeButtons:(UIView*)parentContainer
{
    NSMutableArray* buttons = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 2; i++) {
        UIButton* changeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [changeBtn setFrame:CGRectMake(parentContainer.frame.size.width/2-120+i*150, parentContainer.frame.size.height/5*4+20, parentContainer.frame.size.width/4+20, 50)];
        [changeBtn setBackgroundColor:[UIColor colorWithRed:41/255.0 green:110/255.0 blue:205/255.0 alpha:1]];
        [changeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [changeBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        
        [buttons addObject:changeBtn];
    }
    
    return buttons;
}

@end











