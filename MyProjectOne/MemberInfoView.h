//
//  MemberInfoView.h
//  MyProjectOne
//
//  Created by StephenHe on 9/17/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "CommonMemberCenterView.h"

@interface MemberInfoView : CommonMemberCenterView

-(UIView*)getMemberInfoDisplayPanel:(UIView*) containContainer;

-(NSMutableArray*)setCurrMemberInfo:(NSMutableArray*)labelVals WithParentContainer:(UIView*)parentContainer;

-(NSMutableArray*)setEmptyMemberInfo:(UIView*)parentContainer;

-(NSMutableArray*)setTwoChangeButtons:(UIView*)parentContainer;

-(NSMutableArray*)setMemberInfoEditableArea:(UIView*)parentContainer;

-(NSMutableArray*)setMemberInfoEditableTxts;

-(NSMutableArray*)setMemberInfoTextFields;

-(UILabel*)readOnlyNickNameField;

-(NSMutableArray*)setGenderOption;

-(NSMutableArray*)setStartDropDownPanel;

-(NSMutableArray*)setDropDownIcon;

-(NSMutableArray*)setSelectedTextPanel;

-(UIView*)setDropDownListContainer:(CGFloat)width WithHeight:(CGFloat)height WithStartLeft:(CGFloat)startLeft WithStartTop:(CGFloat)startTop;

@end
