//
//  PhotaLoginPhotaConViewController.m
//  PhotaCon-IOS
//
//  Created by chenghao lin on 1/7/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import "PhotaLoginPhotaConViewController.h"
#import "AFJSONRequestOperation.h"

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
    NSLog(@"Login with PhotaCon...username:%@ - password:%@",nameTextField.text,passwordTextField.text);
    NSURL *url = [NSURL URLWithString:@"http://localhost:8080/api/login/testJson"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"IP Address: %@", [JSON valueForKeyPath:@"foo"]);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"faile");
    }];
    
    [operation start];
}
@end
