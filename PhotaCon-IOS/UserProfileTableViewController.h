//
//  UserProfileTableViewController.h
//  PhotaCon-IOS
//
//  Created by Doug on 1/23/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"


@interface UserProfileTableViewController : UITableViewController
@property (nonatomic, strong) User *personToView;
@end
