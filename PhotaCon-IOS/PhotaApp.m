//
//  PhotaApp.m
//  PhotaCon-IOS
//
//  Created by Doug on 1/14/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import "PhotaApp.h"

static PhotaApp *sharedInstance = nil;

@implementation PhotaApp

@synthesize isLogin = _isLogin;

+(PhotaApp *)sharedInstance
{
    @synchronized(self) {
        if(sharedInstance == nil)
            sharedInstance = [[super alloc] init];
    }
    return sharedInstance;
}

-(void)logMeIn:(LoginCallbackBlock) callbackBlock
{
    NSLog(@"PhotaApp: trying to log in");
}

-(void)logMeOut{
    NSLog(@"PhotaApp: logging out");
}

- (BOOL)myApplication:(UIApplication *)myApplication
              openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSLog(@"Facebook: application handOpenUrl");
    return true;
}

- (void)handleApplicationDidBecomeActive
{
    NSLog(@"Facebook: handleApplicationDidBecomeActive");
}


@end
