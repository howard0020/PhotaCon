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
-(BOOL)loginUser:(NSString *)userName with:(NSString *)password;
@end
