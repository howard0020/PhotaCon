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
-(BOOL)loginUser:(NSString *)userName with:(NSString *)password
{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"howard0020" forKey:@"email"];
    [dic setObject:@"52012345" forKey:@"password"];
    
    NSMutableURLRequest * request = [self requestWithMethod:@"GET" path:@"login/user" parameters:dic];
    AFHTTPRequestOperation * operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"success %@",JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"success %@",error);
    }];
    [operation start];
    return true;
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
