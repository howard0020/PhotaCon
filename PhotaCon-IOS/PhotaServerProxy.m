//
//  PhotaServerProxy.m
//  PhotaCon-IOS
//
//  Created by chenghao lin on 1/9/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import "PhotaServerProxy.h"
#import "AFJSONRequestOperation.h"
@interface PhotaServerProxy()
@end

static PhotaServerProxy *sharedProxy = nil;
#define proxyHost @"http://localhost:8080/api/"
@implementation PhotaServerProxy

-(void)loginUser:(NSString *)userName
    withPassword:(NSString *)password
        callback:(void (^)(BOOL, id, NSError *))callback{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    [dic setObject:userName forKey:@"email"];
    [dic setObject:password forKey:@"password"];
    
    NSMutableURLRequest *request = [self requestWithMethod:@"GET" path:@"user/login/user" parameters:dic];
    AFHTTPRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"success %@",JSON);
        callback(YES,JSON,nil);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"error %@",error);
        callback(NO,JSON,error);
    }];
    [operation start];
}
-(void)registerUser:(NSString *)userName
       withPassword:(NSString *)password
           callback:(void (^)(BOOL, id, NSError *))callback{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setObject:userName forKey:@"email"];
    [dic setObject:password forKey:@"password"];
    
    NSMutableURLRequest *request = [self requestWithMethod:@"GET" path:@"user/register" parameters:dic];
    AFHTTPRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"register user success:%@",JSON);
        callback(YES,JSON,nil);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"register user error:%@",error);
        callback(NO,JSON,error);
    }];
    [operation start];
}
-(id)init
{
    self = [super init];
    if (self == nil)
    {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
        [self setParameterEncoding:AFJSONParameterEncoding];
    }
    return self;
}

+(PhotaServerProxy *)sharedInstance
{
    @synchronized(self) {
        if(sharedProxy == nil)
            sharedProxy = [[super alloc] initWithBaseURL:[NSURL URLWithString:proxyHost]];
    }
    return sharedProxy;
}
@end
