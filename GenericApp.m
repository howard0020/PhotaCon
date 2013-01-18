//
//  GenericApp.m
//  PhotaCon-IOS
//
//  Created by Doug on 1/16/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import "GenericApp.h"

static GenericApp *sharedInstance = nil;
@interface GenericApp()
@end
@implementation GenericApp
@synthesize appName = _appName;


+(GenericApp * )sharedInstance
{
    @synchronized(self) {
        if(sharedInstance == nil)
            sharedInstance = [[super alloc] init];
    }
    return sharedInstance;

}
-(void)loginWithCallback:(appLoginCallback) callbackBlock
{
}
-(BOOL)myApplication:(UIApplication *)myApplication openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
}
-(void)logout
{
}
@end
