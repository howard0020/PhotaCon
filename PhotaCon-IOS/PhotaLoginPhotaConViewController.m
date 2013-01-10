//
//  PhotaLoginPhotaConViewController.m
//  PhotaCon-IOS
//
//  Created by chenghao lin on 1/7/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import "PhotaLoginPhotaConViewController.h"
#import "AFJSONRequestOperation.h"
#import "PhotaLoginManager.h"

@interface PhotaLoginPhotaConViewController ()

@end

@implementation PhotaLoginPhotaConViewController
@synthesize nameTextField,passwordTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doLogin:(UIButton *)sender {
    //TODO start activity indicator
    if(![PhotaLoginManager sharedInstance].isLogin)
    {
        [[PhotaLoginManager sharedInstance] loginUser:@"howard" with:@"52012345"];
    }
}
@end
