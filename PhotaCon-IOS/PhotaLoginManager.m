//
//  PhotaLoginManager.m
//  PhotaCon-IOS
//
//  Created by chenghao lin on 1/5/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import "PhotaLoginManager.h"
#import "PhotaServerProxy.h"
@interface PhotaLoginManager()
@end

static PhotaLoginManager *sharedLoginManager = nil;

@implementation PhotaLoginManager
@synthesize isLogin = _isLogin;
-(void)loginUser:(NSString *)userName with:(NSString *)password{
    [[PhotaServerProxy sharedInstance] loginUser:userName with:password];
}
+(PhotaLoginManager *)sharedInstance
{
    @synchronized(self) {
        if(sharedLoginManager == nil)
            sharedLoginManager = [[super alloc] init];
    }
    return sharedLoginManager;
}
@end
