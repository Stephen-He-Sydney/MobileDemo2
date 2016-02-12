//
//  HomePageController.h
//  MyProjectOne
//
//  Created by StephenHe on 9/10/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomHttpRequest.h"
#import "GlobalConstants.h"
#import "CommonHomePageView.h"
#import "HomeView.h"
#import "QuickBuyView.h"
#import "BestSaleView.h"
#import "CustomCollectionViewCell.h"
#import "QuickBuyTableViewCell.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "ProductDetailController.h"
#import "CheckOutController.h"
#import "CommonFunction.h"
#import "CommonControllersView.h"
#import "MemberCenterController.h"

@interface HomePageController : UIViewController
<UIScrollViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout,
UITableViewDelegate,
UITableViewDataSource,
UIAlertViewDelegate>
{
    CommonHomePageView* comm;
    CommonControllersView* commController;
    
    HomeView* homePage;
    QuickBuyView* quickBuy;
    BestSaleView* bestSale;
    
    UIView* homeContent;
    UIView* quickBuyContent;
    UIView* bestSaleContent;
    
    UIView* homePageView;
    UIView* quickBuyView;
    UIView* bestSaleView;
    
    UIButton* hprodBtn;
    UIButton* qprodBtn;
    UIButton* bprodBtn;
    
    UIScrollView* advScrollView;
    int scrollViewPageIndex;
    int totalScrollViewPage;
    UIPageControl* pageControl;
    NSTimer* advAutoTimer;
    
    NSDictionary* responseJson;
    
    NSMutableArray* homePageArray;
    NSMutableArray* quickBuyArray;
    NSMutableArray* bestSaleArray;
    
    NSMutableArray* homePageImage;
    NSMutableArray* quickBuyImage;
    NSMutableArray* bestSaleImage;
    
    NSMutableArray* imageUrls;
    
    NSMutableArray* menuBtns;
    
    int countReload;
    
    NSMutableArray* prodsRemainningSeconds;

    NSTimer* countDownTimer;
  
    int btnIndex;
    UICollectionView* homeViewCView;
    UICollectionView* bestSaleCView;
    UITableView* quickBuyTView;
    
    int pageIdx;//Used for pull and drag refreshing data
    
    int totalShoppingCart;
    
    NSMutableDictionary* prodToShoppingCart;
    NSMutableDictionary* prodToCheckOut;
    NSMutableArray* checkOutArry;
    
    NSMutableDictionary* tmpDic;
}

@end
