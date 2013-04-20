//
//  GenericApp.h
//  PhotaCon-IOS
//
//  Created by Doug on 1/16/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"
typedef void (^appLoginCallback)(BOOL isLoggedIn,NSString *accessToken, NSString *userName, NSString *forApp);
@interface GenericApp : NSObject
@property (nonatomic) NSString *appName;
+(GenericApp * )sharedInstance;
-(void)loginWithCallback:(appLoginCallback) callbackBlock;
- (BOOL)myApplication:(UIApplication *)myApplication openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
-(void)logout;
@end
