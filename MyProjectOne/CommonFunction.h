//
//  CommonFunction.h
//  MyProjectOne
//
//  Created by StephenHe on 9/23/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomHttpRequest.h"
#import "ProductDetailController.h"
#import "CommonControllersView.h"

@interface CommonFunction : NSObject

+(NSString *)tranfromTime:(long long)ts;

-(void)sendPostByCurrentProductID:(NSString*)productID WithImgData:(NSData*)imgData WithClassName:(NSString*)controllerName WithCustomHttp:(CustomHttpRequest*)customHttp WithNavigation:(UINavigationController*)navigationController;

-(void)saveSelectedProducts:(int)productID Withkey:(NSString*)currKey WithItemDict:(NSMutableDictionary*)targetDict WithSourceArry:(NSMutableArray*)dataArry WithImageArry:(NSMutableArray*)imageArry;

+(NSString*)trimString:(NSString*)inputStr;

+(NSMutableDictionary*)readUserDefaultsForUserInfo;
@end
