//
//  MyTabBarController.m
//  15.08.21
//
//  Created by StephenHe on 8/21/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "MyTabBarController.h"
#import "HomePageController.h"
#import "SearchController.h"
#import "ListController.h"
#import "ShoppingCartController.h"
#import "MemberCenterController.h"

@interface MyTabBarController ()

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(MyTabBarController*)LoadTabBarAndNavComponents
{
    //设置navigation bar
    
    //UINavigationController* mainPageNav =[self getUINavigationController:@"ShoppingCartController"];
    
    //UINavigationController* mainPageNav =[self getUINavigationController:@"MemberCenterController"];
    
    UINavigationController* mainPageNav =[self getUINavigationController:@"HomePageController"];
    
    UINavigationController* searchViewNav =[self getUINavigationController:@"SearchController"];
    
    UINavigationController* listViewNav =[self getUINavigationController:@"ListController"];
    
    UINavigationController* shoppingNav =[self getUINavigationController:@"ShoppingCartController"];
    
    UINavigationController* memberCenterNav =[self getUINavigationController:@"MemberCenterController"];
    
    //设置 tab Bar
    NSArray* allNavs =@[mainPageNav,searchViewNav,listViewNav,shoppingNav,memberCenterNav];
    
    return [self getTabBarComponents:allNavs];
}

-(MyTabBarController*) getTabBarComponents:(NSArray*)allNavs
{
    MyTabBarController* myTabBar = [[MyTabBarController alloc] init];
    [myTabBar setViewControllers:allNavs];
    
    NSArray* tabNames = @[@"首页",@"搜索",@"列表",@"购物",@"个人中心"];
    NSArray* tabImages = @[@"icon_03",@"icon_12",@"icon_05",@"icon_07",@"icon_09"];
    NSArray* tabSelectedImages = @[@"icon_19",@"icon_23",@"icon_20",@"icon_21",@"icon_22"];
    
    for (int i = 0; i < 5; i++) {
        [myTabBar.tabBar.items[i] setTitle:[tabNames objectAtIndex:i]];
        
        UIImage* currImage = [self resizeTabItemImage:[UIImage imageNamed:[tabImages objectAtIndex:i]]];
    
        [myTabBar.tabBar.items[i] setImage:currImage];
        
        UIImage* selectedImage = [self resizeTabItemImage:[UIImage imageNamed:[tabSelectedImages objectAtIndex:i]]];
        
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [myTabBar.tabBar.items[i] setSelectedImage:selectedImage];
        [myTabBar.tabBar setTintColor:[UIColor whiteColor]];
        
        UIImage* resizeImage = [self resizeBackgroundImage:[UIImage imageNamed:@"登录--忘记密码--下一步1_03"]];
        [[UITabBar appearance]setSelectionIndicatorImage:resizeImage];
    }
    return myTabBar;
}

-(UINavigationController*) getUINavigationController:(NSString*) className
{
    id currPage = [[NSClassFromString(className) alloc] init];
    
    UINavigationController* currPageNav = [[UINavigationController alloc]
                                           initWithRootViewController:currPage];
    //设置导航栏背景色
    [currPageNav.navigationBar setBarTintColor:[UIColor colorWithRed:41/255.0 green:110/255.0 blue:205/255.0 alpha:1]];
    //设置导航栏文字颜色和文字大小
    [currPageNav.navigationBar setTitleTextAttributes:@{
                                                        NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:23.0f],
                                                        
                                                        }];
    

    return currPageNav;
}


-(UIImage*)resizeBackgroundImage:(UIImage*)selectedBgImage
{
    CGSize tabItemSize = CGSizeMake(CGRectGetWidth(self.view.frame)/5, 49);
    UIGraphicsBeginImageContext(tabItemSize);
    [selectedBgImage drawInRect:CGRectMake(0, 0, tabItemSize.width, tabItemSize.height)];
    
    UIImage* resizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resizeImage;
}

-(UIImage*)resizeTabItemImage:(UIImage*)currImage 
{
    CGSize tabItemSize = CGSizeMake(CGRectGetWidth(self.view.frame)/8, 49);
    UIGraphicsBeginImageContext(tabItemSize);
    [currImage drawInRect:CGRectMake(11, 10, tabItemSize.width*0.6, tabItemSize.height*0.6)];
    
    UIImage* resizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resizeImage;
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
