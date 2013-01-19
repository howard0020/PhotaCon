//
//  HomeViewController.h
//  PhotaCon-IOS
//
//  Created by Doug on 1/17/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@end
