//
//  CustomHttpRequest.m
//  MyProjectOne
//
//  Created by StephenHe on 9/10/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import "CustomHttpRequest.h"

@implementation CustomHttpRequest

-(void)setCurrentInternetStatus
{
    reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(isCurrentStatusChanged:) name:kReachabilityChangedNotification object:nil];
    
    reachability = [Reachability reachabilityForInternetConnection];
    
    [reachability startNotifier];
    
    currStatus = [reachability currentReachabilityStatus];
}

-(void)isCurrentStatusChanged:(NSNotification*) notify
{
    currStatus = [reachability currentReachabilityStatus];
}

-(bool)IsCurrentWIFIReached
{
    [self setCurrentInternetStatus];
    
    if (currStatus == ReachableViaWiFi)
    {
        return YES;
    }
    return NO;
}

-(bool)IsCurrentInternentReached
{
    [self setCurrentInternetStatus];
    
    if (currStatus == ReachableViaWiFi||currStatus == ReachableViaWWAN)
    {
        return YES;
    }
    return NO;
}

-(void)fetchResponseByPost:(NSString*)serverUrl WithParameter:(NSString*)param WithPassSuccessResponse:(serverInfo)info;
{
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:serverUrl]];
    
    [request setHTTPMethod:@"POST"];
    
    [request setTimeoutInterval:15];//十五秒没有回复就终止请求，弹出对话框告知网络问题
    
    [request setHTTPBody:[param dataUsingEncoding:NSUTF8StringEncoding]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]  completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary* jsonData = [[NSDictionary alloc]init];
        if ([data length] > 0)
        {
            jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        }
        else
        {
            jsonData = @{@"fail":connectionError};
        }
        info(jsonData);
    }];
}

-(NSData*)fetchImageData:(NSString*)serverUrl
{
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:serverUrl]];
    [request setHTTPMethod:@"POST"];
    
    return [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
}

-(NSDictionary*)isResponseSuccess:(NSString*)serverUrl WithParamUrl:(NSString*)paramUrl
{
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:serverUrl]];
    [request setHTTPMethod:@"POST"];
    
    [request setHTTPBody:[paramUrl dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

@end
