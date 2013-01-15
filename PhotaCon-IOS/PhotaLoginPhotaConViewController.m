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
#import "photaHomeViewController.h"
#import "PhotaStringUtil.h"
#import "MBProgressHUD.h"

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
    //comme
    nameTextField.text = @"howard0020@yahoo.com"; passwordTextField.text = @"52012345";
    //TODO start activity indicator
    if(![PhotaStringUtil NSStringIsValidEmail:nameTextField.text]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Email Error"
                                                            message:@"Please enter a valid email!"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];

    }else if ([passwordTextField.text isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Password Error"
                                                            message:@"Please enter a valid password!"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }else {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        PhotaLoginModel * model = [[PhotaLoginModel alloc] init];
        model.loginName = nameTextField.text;
        model.password = passwordTextField.text;
        __weak PhotaLoginPhotaConViewController *weakSelf = self;
        model.loginCallBack = ^(BOOL status) {
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            if (status) {
                NSLog(@"Logged into photacon!");
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Welcome to PhotaCon"
                                                                    message:@"Emjoy!"
                                                                   delegate:weakSelf
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                [alertView show];
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            }else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                                    message:@"Unable to login!"
                                                                   delegate:weakSelf
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                [alertView show];
            }
            
        };
        
        [[PhotaLoginManager sharedInstance] loginUser:model];
    }
}
@end
