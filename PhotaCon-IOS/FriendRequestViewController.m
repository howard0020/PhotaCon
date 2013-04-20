//
//  FriendRequestViewController.m
//  PhotaCon-IOS
//
//  Created by Doug on 1/23/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import "FriendRequestViewController.h"

// the sooner we can remove these the better
#import "Facebook.h"
#import "FBLoginDialog.h"

@interface FriendRequestViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation FriendRequestViewController
@synthesize webView = _webView;
@synthesize friendRequestURL = _friendRequestURL;
@synthesize fbDialogParam = _fbDialogParam;
@synthesize personToAdd = _personToAdd;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    //NSURL *friendRequestURL = [NSURL URLWithString:@"http://facebook.com/dialog/friends/?id=1368420155&app_id=145499585599212&redirect_uri=http://localhost:8080/"];
    
    
    NSURL *friendRequestURL = [NSURL URLWithString:[self constructFacebookFriendRequestLink:[self.personToAdd getAppID:@"facebook"] appID:@"145499585599212" redirectLink:@"http://localhost:8080/"]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:friendRequestURL];
    [self.webView loadRequest:request];
    //Facebook *fb = [[Facebook alloc]init];
    
    /*
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"1368420155", @"id",
                                   @"145499585599212", @"app_id",
                                   @"http://localhost:8080/", @"redirect_uri",
                                   nil];
        
    
    [fb dialog:@"friends" andParams:params andDelegate:nil];
     */
    NSLog(@"loading request");
}
-(NSString *)concatUrlParam:(NSString *)paramKey withParamValue:(NSString *)paramValue{
    
    return [NSString stringWithFormat:@"&%@=%@",paramKey, paramValue];
    
}
-(NSString *)constructFacebookFriendRequestLink:(NSString *)userID appID:(NSString *)appID redirectLink:(NSString *)redirect
{
    return [NSString stringWithFormat:@"http://facebook.com/dialog/friends/?id=%@&app_id=%@&redirect_uri=%@",userID, appID, redirect];

}
-(BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@", request.URL.absoluteString);
    NSRange rng = [request.URL.absoluteString rangeOfString:@"action"];
    if(rng.location != NSNotFound)
    {
        NSLog(@"found finish");
        //[self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.navigationController popViewControllerAnimated:YES];

        return NO;
    }
    else{
        return YES;
    }
}

@end
