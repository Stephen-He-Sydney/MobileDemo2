//
//  CommonFunction.m
//  MyProjectOne
//
//  Created by StephenHe on 9/23/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "CommonFunction.h"

@implementation CommonFunction

//将秒转化为具体日期
+(NSString *)tranfromTime:(long long)ts
{
    NSDate *date=[[NSDate alloc]initWithTimeIntervalSince1970:ts];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    //[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strTime=[formatter stringFromDate:date];
    return strTime;
}

-(void)sendPostByCurrentProductID:(NSString*)productID WithImgData:(NSData*)imgData WithClassName:(NSString*)controllerName WithCustomHttp:(CustomHttpRequest*)customHttp WithNavigation:(UINavigationController*)navigationController
{
    id controllerObj = [[NSClassFromString(controllerName) alloc] init];
    
    if ([controllerObj respondsToSelector:@selector(setProductID:)])
    {
        NSString* serverUrl = @"http://112.74.105.205/upload/mapi/index.php?act=goodsdesc";
        NSString* paramUrl = [NSString stringWithFormat:@"r_type=1&id=%@",productID];
        
        [customHttp fetchResponseByPost:serverUrl WithParameter:paramUrl WithPassSuccessResponse:^(NSDictionary *info){
    
        NSDictionary* productDetailJson = [NSMutableDictionary dictionaryWithDictionary:info];

        if (![productDetailJson objectForKey:@"fail"])
        {            
            [controllerObj setProductID:productID];
            [controllerObj setProductImage:imgData];
            [controllerObj setCurrPrice:productDetailJson[@"cur_price_format"]];
            [controllerObj setCurrTitle:productDetailJson[@"title"]];
            [controllerObj setStartDate:[CommonFunction tranfromTime:[productDetailJson[@"start_date"]longLongValue]]];
            [controllerObj setEndDate:[CommonFunction tranfromTime:[productDetailJson[@"end_date"]longLongValue]]];
            
            [navigationController pushViewController:controllerObj animated:NO];
        }
        else
        {
            [CommonControllersView promptSingleButtonWarningDialog:@"服务器连接超时,请检查网络!"];
        }
        }];
    }
}

-(void)saveSelectedProducts:(int)productID Withkey:(NSString*)currKey WithItemDict:(NSMutableDictionary*)targetDict WithSourceArry:(NSMutableArray*)dataArry WithImageArry:(NSMutableArray*)imageArry
{
    NSMutableDictionary* tmpDic = [[NSMutableDictionary alloc]init];
    
    for (int i = 0; i < dataArry.count; i++) {
        if ((int)[dataArry[i][@"goods_id"] integerValue] == productID)
        {
            [tmpDic setObject:dataArry[i][@"goods_id"] forKey:@"productID"];
            [tmpDic setObject:dataArry[i][@"title"] forKey:@"title"];
            [tmpDic setObject:@(1) forKey:@"quantity"];
            [tmpDic setObject:dataArry[i][@"cur_price_format"] forKey:@"cur_price_format"];

            for (int j = 0; j < imageArry.count; j++) {
                if ([imageArry[j] objectForKey:dataArry[i][@"goods_id"]])
                {
                    NSString* imgKey = [NSString stringWithFormat:@"%ld",[dataArry[i][@"goods_id"]integerValue]];
                    [tmpDic setObject:imageArry[j][imgKey] forKey:@"imgData"];
                    break;
                }
            }
            break;
        }
    }
    
    [targetDict setObject:tmpDic forKey:currKey];
}

+(NSString*)trimString:(NSString*)inputStr
{
    return [inputStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+(NSMutableDictionary*)readUserDefaultsForUserInfo
{
    NSMutableDictionary* readUserInfo = [[NSMutableDictionary alloc]init];
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    readUserInfo = [userDefaults objectForKey:@"userInfo"];
    
    return readUserInfo;
}

@end
