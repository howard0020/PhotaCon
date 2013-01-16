//
//  PhotaLoginManager.h
//  PhotaCon-IOS
//
//  Created by chenghao lin on 1/5/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotaLoginModel.h"

@interface PhotaLoginManager : NSObject

@property BOOL isLogin;
+ (PhotaLoginManager * )sharedInstance;
/*
-(void)loginUser:(NSString *)userName
            withPassword:(NSString *)password
        callback:(void (^)(BOOL status))callback;
-(void)registerUser:(NSString *)userName
       withPassword:(NSString *)password
           callback:(void (^)(BOOL status))callback;
 */
-(void)loginUser:(PhotaLoginModel *) loginModel;
-(void)registerUser:(PhotaLoginModel *) loginModel;
-(void)loginInWithFacebook: (PhotaLoginModel *) loginModel;
-(void)logout;
@end
