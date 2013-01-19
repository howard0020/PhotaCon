//
//  PhotaLoginManager.m
//  PhotaCon-IOS
//
//  Created by chenghao lin on 1/5/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import "PhotaLoginManager.h"
#import "PhotaServerProxy.h"
#import "FacebookApp.h"
#import "GenericApp.h"

@interface PhotaLoginManager()
@property (nonatomic,strong)GenericApp *currentApp;
@end

static PhotaLoginManager *sharedLoginManager = nil;

@implementation PhotaLoginManager
@synthesize isLogin = _isLogin;
@synthesize currentApp = _currentApp;

-(void)loginUser:(LoginModel *) loginModel{
    [[PhotaServerProxy sharedInstance] loginUser:loginModel.loginName withPassword:loginModel.password callback:^(BOOL status, id Result, NSError *error) {
        if (status) {
            NSLog(@"LoginManager user logged in:%@",Result);
            self.isLogin = YES;
        }else{
            NSLog(@"LoginManager user NOT logged in - Result:%@ Error:%@",Result,error);
        }
        loginModel.loginCallBack(self.isLogin);
    }];
}

-(void)registerUser:(LoginModel *) loginModel{
    [[PhotaServerProxy sharedInstance] registerUser:loginModel.loginName withPassword:loginModel.password callback:^(BOOL status, id Result, NSError *error) {
        if (status) {
            NSLog(@"LoginManager user registered and logged in.");
            self.isLogin =YES;
        }else {
            NSLog(@"LoginManager fail to register user");
        }
        loginModel.loginCallBack(self.isLogin);
    }];
}

-(void)loginInWithApp: (LoginModel *) loginModel{
    
    //LoginModel * model = [[LoginModel alloc] init];
    if([loginModel.loginAppAs isEqualToString:@"facebook"]){
        self.currentApp = [FacebookApp sharedInstance];
    }
    
    [self.currentApp loginWithCallback:^(BOOL status,NSString *accessToken,NSString *appName) {
        if (status)
            self.isLogin = YES;
        [[PhotaServerProxy sharedInstance] postAccessToken:accessToken forApp:appName];
        loginModel.loginCallBack(status);
    }];
}

-(void)logout{
    self.isLogin = NO;
    [self.currentApp logout];
}

-(BOOL)myApplication:(UIApplication *)myApplication openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSLog(@"GenericApp: handleApplicationDidBecomeActive");
    [self.currentApp myApplication:myApplication openURL:url sourceApplication:sourceApplication annotation:annotation];
}

+(PhotaLoginManager *)sharedInstance
{
    @synchronized(self) {
        if(sharedLoginManager == nil)
            sharedLoginManager = [[super alloc] init];
    }
    return sharedLoginManager;
}
@end
