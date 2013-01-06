//
//  PhotaNavigationViewController.m
//  PhotaCon-IOS
//
//  Created by chenghao lin on 1/5/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import "PhotaNavigationViewController.h"
#import "PhotaLoginManager.h"
@interface PhotaNavigationViewController ()

@end

@implementation PhotaNavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)initLogin
{
    [NSThread sleepForTimeInterval:2.0];

    if ([PhotaLoginManager getManager].isLogin) {
        [self performSegueWithIdentifier:@"HomeView" sender:self];
    }else{
        [self performSegueWithIdentifier:@"LoginView" sender:self];
    }
}
- (void)viewDidAppear:(BOOL)animated{
    [self initLogin];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
