//
//  PhotaApp.h
//  PhotaCon-IOS
//
//  Created by Doug on 1/14/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotaLoginManager.h"
@interface PhotaApp : NSObject

@property BOOL isLogin;
+ (PhotaApp * )sharedInstance;
-(void)logMeIn:(LoginCallbackBlock) callbackBlock;
- (BOOL)myApplication:(UIApplication *)myApplication openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
- (void)handleApplicationDidBecomeActive;
-(void)logMeOut;

@end