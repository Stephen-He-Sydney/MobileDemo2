//
//  ProductDetailController.m
//  MyProjectOne
//
//  Created by StephenHe on 9/22/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "ProductDetailController.h"

@interface ProductDetailController ()

@end

@implementation ProductDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"商品详情";
    
    productDetailView = [[ProductDetailView alloc]init];
    commView = [[CommonControllersView alloc]init];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithCustomView:[self bindNavLeftBarButton]];
    
    [productDetailView setMainImage:self.navigationController];
    [self.view addSubview:productDetailView.prodImage];
    [productDetailView setProductTitle];
    [self.view addSubview:productDetailView.currTitle];
    
    NSMutableArray* prodPriceEles = [productDetailView setProdPrice];
    for (int i = 0; i < prodPriceEles.count; i++) {
        UILabel* currLabel =(UILabel*)prodPriceEles[i];
        if (i == 0)
        {
            currLabel.text = @"促销价:";
        }
        else
        {
            [currLabel setTextColor:[UIColor redColor]];
            currLabel.text = self.currPrice;
        }
        [self.view addSubview:currLabel];
    }
    
    [productDetailView setProdPoints];
    [self.view addSubview:productDetailView.pointTxt];
    
    NSMutableArray* stars =[productDetailView setStarMark];
    for (int i = 0; i < stars.count; i++) {
        UIImageView* currStar = (UIImageView*)stars[i];
        [self.view addSubview:currStar];
    }
    productDetailView.prodImage.image = [UIImage imageWithData:self.productImage];
    
    productDetailView.currTitle.text = self.currTitle;
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
