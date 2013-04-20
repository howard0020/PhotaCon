//
//  PhotaLoginModel.h
//  PhotaCon-IOS
//
//  Created by Doug on 1/14/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^LoginCallbackBlock)(BOOL isLoggedIn);

@interface LoginModel : NSObject

@property (nonatomic, strong) NSString *loginName;
@property (nonatomic, strong) NSString *password;
@property (readwrite, copy) LoginCallbackBlock loginCallBack;
@property (nonatomic, strong) NSString *loginAppAs;

@end
