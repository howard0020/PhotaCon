//
//  PhotaLoginManager.h
//  PhotaCon-IOS
//
//  Created by chenghao lin on 1/5/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"

@interface PhotaLoginManager : NSObject

@property BOOL isLogin;
+ (PhotaLoginManager * )sharedInstance;

-(void)loginUser:(LoginModel *) loginModel;
-(void)registerUser:(LoginModel *) loginModel;
-(void)loginInWithApp: (LoginModel *) loginModel;
-(void)logout;
-(BOOL)myApplication:(UIApplication *)myApplication openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
@end
