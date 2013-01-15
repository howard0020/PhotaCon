//
//  RegisterPhotaConViewController.m
//  PhotaCon-IOS
//
//  Created by chenghao lin on 1/12/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import "RegisterPhotaConViewController.h"
#import "PhotaLoginManager.h"
#import "PhotaStringUtil.h"
@interface RegisterPhotaConViewController ()

@end

@implementation RegisterPhotaConViewController
@synthesize email,password,repeatPassword;
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

- (IBAction)doRegister {
    //if email is empty or not valid
    if([email.text isEqualToString:@""] || ![PhotaStringUtil NSStringIsValidEmail:email.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Empty Email"
                                                        message:@"Please enter a valid email!"
                                                       delegate:self
                                              cancelButtonTitle:@"Retry"
                                              otherButtonTitles: nil];
        [alert show];
    //if password is empty or not equal to each other
    }else if ([password.text isEqualToString:@""] || ![password.text isEqualToString:repeatPassword.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Check Password"
                                                        message:@"Password does not match!"
                                                       delegate:self
                                              cancelButtonTitle:@"Retry"
                                              otherButtonTitles: nil];
        [alert show];
    }else {
        NSLog(@"do register");
        PhotaLoginModel * model = [[PhotaLoginModel alloc] init];
        model.loginName = email.text;
        model.password = password.text;
        __weak RegisterPhotaConViewController *weakSelf = self;
        model.loginCallBack =^(BOOL status) {
            if (!status) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                                    message:@"Unable to register"
                                                                   delegate:weakSelf
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                [alertView show];
            }else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Welcome to PhotaCon"
                                                                    message:@"Enjoy!"
                                                                   delegate:weakSelf
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                [alertView show];
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            }
        };
        [[PhotaLoginManager sharedInstance] registerUser:model];
    }
}
@end
