//
//  PhotaLoginManager.h
//  PhotaCon-IOS
//
//  Created by chenghao lin on 1/5/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotaLoginManager : NSObject

@property BOOL isLogin;
+ (PhotaLoginManager * )sharedInstance;
-(void)loginUser:(NSString *)userName with:(NSString *)password;
@end
