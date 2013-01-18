//
//  PhotaServerProxy.h
//  PhotaCon-IOS
//
//  Created by chenghao lin on 1/9/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"
@interface PhotaServerProxy : AFHTTPClient
+(PhotaServerProxy *) sharedInstance;
-(void)loginUser:(NSString *)userName
    withPassword:(NSString *)password
        callback:(void (^)(BOOL status,id Result,NSError *error))callback;
-(void)registerUser:(NSString *)userName
       withPassword:(NSString *)password
           callback:(void (^)(BOOL status,id Result,NSError *error))callback;
-(void)postAccessToken:(NSString *)token forApp:(NSString *)app;
@end
