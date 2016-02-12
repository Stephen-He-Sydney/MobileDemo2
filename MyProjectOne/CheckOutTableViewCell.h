//
//  CheckOutTableViewCell.h
//  MyProjectOne
//
//  Created by StephenHe on 9/25/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckOutTableViewCell : UITableViewCell

@property(strong,nonatomic)UIView* tViewCellContainer;
@property(strong, nonatomic)UILabel* receiveAddressTxt;
@property(strong, nonatomic)UILabel* changeAddressBtn;
@property(strong, nonatomic)UILabel* nickName;
@property(strong, nonatomic)UILabel* existingAddress;
@property(strong, nonatomic)UILabel* mobileNumber;

@end
