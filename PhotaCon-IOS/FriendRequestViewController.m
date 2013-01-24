//
//  FriendRequestViewController.m
//  PhotaCon-IOS
//
//  Created by Doug on 1/23/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import "FriendRequestViewController.h"

@interface FriendRequestViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation FriendRequestViewController
@synthesize webView = _webView;
@synthesize friendRequestURL = _friendRequestURL;

- (void) viewDidLoad
{
    [super viewDidLoad];

    NSURLRequest *request = [NSURLRequest requestWithURL:self.friendRequestURL];
    [self.webView loadRequest:request];
    NSLog(@"loading request");
}

@end
