//
//  HomeViewController.h
//  PhotaCon-IOS
//
//  Created by Doug on 1/17/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate, UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong,nonatomic) NSMutableArray *userArray;
@property (strong,nonatomic) NSMutableArray *filteredUserArray;
@end
