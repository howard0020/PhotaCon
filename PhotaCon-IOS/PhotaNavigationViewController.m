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

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewDidDisappear:animated];
}
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
    [self performSegueWithIdentifier:@"LoginView" sender:self];
    
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
