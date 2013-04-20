//
//  User.h
//  PhotaCon-IOS
//
//  Created by Doug on 1/19/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSMutableArray *applications; //Array of dictionary. Dictionary contains email, plugin, pluginId
@property (nonatomic, strong) NSMutableDictionary *friendRelation; //Specify if I'm a friend with this user.

+(id) initWithDict:(NSDictionary *)dict;
-(NSString *) getAppID:(NSString *)appName;
@end
