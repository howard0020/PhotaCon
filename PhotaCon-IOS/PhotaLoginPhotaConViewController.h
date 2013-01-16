//
//  PhotaLoginPhotaConViewController.h
//  PhotaCon-IOS
//
//  Created by chenghao lin on 1/7/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotaLoginPhotaConViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)doLogin:(UIButton *)sender;
@property (nonatomic, strong) NSString *appName;
@end
