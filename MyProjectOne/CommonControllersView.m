//
//  CommonControllersView.m
//  MyProjectOne
//
//  Created by StephenHe on 9/18/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "CommonControllersView.h"

@implementation CommonControllersView

-(UIButton*)setLeftGoBackButton
{
    UIImage* btnImage = [UIImage imageNamed:@"登录_03"];
    
    btnImage = [btnImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIButton* goBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [goBackBtn setFrame:CGRectMake(0, 0, 12, 20)];
    [goBackBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
    
    return goBackBtn;
}

#pragma mark - 弹出对应的对话框提醒
+(void)promptSingleButtonWarningDialog:(NSString*)msg
{
    UIAlertView* warnAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [warnAlert show];
}

-(UITableView*)getCurrentTableView:(UIView*)currContainer
{
    UITableView* tableView = [[UITableView alloc]initWithFrame:currContainer.bounds style:UITableViewStylePlain];
    
    [tableView setUserInteractionEnabled:YES];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    return tableView;
}
@end
