//
//  PhotaFacebookApp.m
//  PhotaCon-IOS
//
//  Created by Doug on 1/14/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import "FacebookApp.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation FacebookApp
-(id)init{
    self = [super init];
    if (self) {
        self.appName = @"facebook";
    }
    return self;
}
-(void)loginWithCallback:(appLoginCallback) callbackBlock
{
    NSLog(@"Facebook: trying to log in");
    [self openSession:callbackBlock];
}

-(void)logout{
    NSLog(@"Facebook: logging out");
    [FBSession.activeSession closeAndClearTokenInformation];
}

-(void)sessionStateChanged:(FBSession *)session
                     state:(FBSessionState) state
                     error:(NSError *)error
                  callback:(appLoginCallback) callbackBlock
{
    switch (state) {
        case FBSessionStateOpen: {
            NSLog(@"Facebook: session StateChanged. FBState: FBSessionStateOpen");
            callbackBlock(YES,session.accessToken,self.appName);
            break;
        case FBSessionStateClosed:
            NSLog(@"Facebook: session StateChanged. FBState: FBSessionStateClosed");
            break;
        case FBSessionStateClosedLoginFailed:
            // Once the user has logged in, we want them to
            // be looking at the root view.
            //[self.navController popToRootViewControllerAnimated:NO];
            NSLog(@"Facebook: session StateChanged. FBState: FBSessionStateClosedLoginFailed");
            [FBSession.activeSession closeAndClearTokenInformation];
            callbackBlock(NO,nil,self.appName);
            //[self showLoginView];
            break;
        default:
            NSLog(@"Facebook: session StateChanged. FBState: default");
            callbackBlock(NO,nil,self.appName);
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

-(BOOL)openSession:(appLoginCallback) callbackBlock
{
    NSLog(@"Facebook: openSession.");
    return [FBSession openActiveSessionWithReadPermissions:nil allowLoginUI:YES
        completionHandler: ^(FBSession *session, FBSessionState state, NSError *error) {
            NSLog(@"Facebook: openSession callback");
            [self sessionStateChanged:session state:state error:error callback:callbackBlock];
    }
    ];
}

-(BOOL)myApplication:(UIApplication *)myApplication
              openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSLog(@"Facebook: application handOpenUrl");
    return [FBSession.activeSession handleOpenURL:url];
}
@end
