//
//  RegisterPhotaConViewController.h
//  PhotaCon-IOS
//
//  Created by chenghao lin on 1/12/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterPhotaConViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *repeatPassword;
- (IBAction)doRegister;
@end
