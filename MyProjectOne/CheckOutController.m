//
//  CheckOutController.m
//  MyProjectOne
//
//  Created by StephenHe on 9/22/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "CheckOutController.h"

@interface CheckOutController ()

@end

@implementation CheckOutController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    [self initializeAttributes];
    
    checkOutView = [[CheckOutView alloc]init];
    
    commView = [[CommonControllersView alloc]init];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithCustomView:[self bindNavLeftBarButton]];
  
    [self reloadCheckOutView];
}

-(void)reloadCheckOutView
{
    [self setCheckOutView];
    
    [self reflectNavigationBarRightBtn];
    
    NSMutableArray* checkOutArray = [self getCurrCheckOutInfo];
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    for (UIView* subView in self.view.subviews) {
//        [subView removeFromSuperview];
//    }
//    
//    [self reloadCheckOutView];
//}

-(void)setCheckOutView
{
    [self setAllStaticViews:003];
    
    fullSizeView.hidden = YES;
    
    if ([self verifyLoginStatus] == YES){
        [self resetCurrView];
         self.navigationItem.title = @"去结算";
    }
}

-(UIButton*)bindNavLeftBarButton
{
    UIButton* goBackBtn = [commView setLeftGoBackButton];
    [goBackBtn addTarget:self action:@selector(goBackAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return goBackBtn;
}

-(void)goBackAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(NSMutableArray*)getCurrCheckOutInfo
{
    NSUserDefaults* checkOutUserDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray* checkOutArry = [checkOutUserDefaults objectForKey:@"checkOut"];
    
    return checkOutArry;
    //return [currTotal allValues];//convert dic to immutable array
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
