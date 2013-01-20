//
//  User.h
//  PhotaCon-IOS
//
//  Created by Doug on 1/19/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, copy) NSString *name;
+ (id) initWithName:(NSString *)name;
+(id) initWithDict:(NSDictionary *)dict;
@end
