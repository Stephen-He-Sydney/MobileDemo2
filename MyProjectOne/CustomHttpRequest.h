//
//  CustomHttpRequest.h
//  MyProjectOne
//
//  Created by StephenHe on 9/10/15.
//  Copyright (c) 2015 StephenHe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

typedef void(^serverInfo)(NSDictionary* info);

@interface CustomHttpRequest : NSObject
{
    Reachability* reachability;
    
    NetworkStatus currStatus;
}

-(bool)IsCurrentWIFIReached;

-(bool)IsCurrentInternentReached;

-(void)fetchResponseByPost:(NSString*)serverUrl WithParameter:(NSString*)param WithPassSuccessResponse:(serverInfo)info;

-(NSData*)fetchImageData:(NSString*)serverUrl;

-(NSDictionary*)isResponseSuccess:(NSString*)serverUrl WithParamUrl:(NSString*)paramUrl;

@end
