//
//  User.m
//  PhotaCon-IOS
//
//  Created by Doug on 1/19/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize name;

+ (id) initWithName:(NSString *)name
{
    User *user = [[self alloc] init];
    [user setName:name];
    return user;
}

+(User *) initWithDict:(NSDictionary *)dict{
    User *user = [[self alloc] init];
    
    NSString * firstName = [dict objectForKey:@"firstName"];
    NSString * lastName = [dict objectForKey:@"lastName"];
    
    [user setName: [[firstName stringByAppendingString:@" " ] stringByAppendingString: lastName]];
    
    return user;
}

@end
