//
//  PhotaFacebookApp.m
//  PhotaCon-IOS
//
//  Created by Doug on 1/14/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import "PhotaFacebookApp.h"
#import <FacebookSDK/FacebookSDK.h>


static PhotaFacebookApp *sharedInstance = nil;

@implementation PhotaFacebookApp

@synthesize isLogin = _isLogin;

+(PhotaFacebookApp *)sharedInstance
{
    @synchronized(self) {
        if(sharedInstance == nil)
            sharedInstance = [[super alloc] init];
    }
    return sharedInstance;
}

-(void)logMeIn:(LoginCallbackBlock) callbackBlock
{
    NSLog(@"Facebook: trying to log in");
    [self openSession:callbackBlock];
}

-(void)logMeOut{
    NSLog(@"Facebook: logging out");
    [FBSession.activeSession closeAndClearTokenInformation];
}

-(void)sessionStateChanged:(FBSession *)session
                     state:(FBSessionState) state
                     error:(NSError *)error
                  callback:(LoginCallbackBlock) callbackBlock
{
    switch (state) {
        case FBSessionStateOpen: {
            NSLog(@"Facebook: session StateChanged. FBState: FBSessionStateOpen");
            self.isLogin = YES;
            callbackBlock(YES);
            break;
        case FBSessionStateClosed:
            NSLog(@"Facebook: session StateChanged. FBState: FBSessionStateClosed");
            break;
        case FBSessionStateClosedLoginFailed:
            // Once the user has logged in, we want them to
            // be looking at the root view.
            //[self.navController popToRootViewControllerAnimated:NO];
            NSLog(@"Facebook: session StateChanged. FBState: FBSessionStateClosedLoginFailed");
            self.isLogin = NO;
            [FBSession.activeSession closeAndClearTokenInformation];
            callbackBlock(NO);
            //[self showLoginView];
            break;
        default:
            NSLog(@"Facebook: session StateChanged. FBState: default");
            self.isLogin = YES;
            callbackBlock(NO);
            break;
        }
    }
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
    
}

-(BOOL)openSession:(LoginCallbackBlock) callbackBlock
{
    NSLog(@"Facebook: openSession.");
    return [FBSession openActiveSessionWithReadPermissions:nil allowLoginUI:YES
        completionHandler: ^(FBSession *session, FBSessionState state, NSError *error) {
            NSLog(@"Facebook: openSession callback");
            [self sessionStateChanged:session state:state error:error callback:callbackBlock];
    }
    ];
}
- (BOOL)myApplication:(UIApplication *)myApplication
              openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSLog(@"Facebook: application handOpenUrl");
    return [FBSession.activeSession handleOpenURL:url];
}
- (void)handleApplicationDidBecomeActive
{
    NSLog(@"Facebook: handleApplicationDidBecomeActive");
    [FBSession.activeSession handleDidBecomeActive];
}


@end
