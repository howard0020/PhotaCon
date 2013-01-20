//
//  HomeViewController.m
//  PhotaCon-IOS
//
//  Created by Doug on 1/17/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeUserCell.h"
#import "PhotaServerProxy.h"
#import "User.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize userArray;
@synthesize mySearchBar;
@synthesize myTableView;
@synthesize filteredUserArray;

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self searchUser:searchBar.text];
}
- (NSMutableArray *)userArray
{
    if (userArray == nil) {
        userArray = [[NSMutableArray alloc] init];
    }
    return userArray;
}

-(void)searchUser:(NSString *) text
{
    NSLog(@"search bar click");
    [[PhotaServerProxy sharedInstance] searchForUser:text withCallback:^(BOOL status, id Result, NSError *error) {
        
        NSArray * list = (NSArray *)Result;
        [self.userArray removeAllObjects];
        for (NSDictionary * userDict in list) {
            NSDictionary * user = [userDict objectForKey:@"user"];
            User *newUser = [User initWithDict:user];
            [self.userArray addObject:newUser];
            NSLog(@"User Name: %@", newUser.name);
        }
        [self.searchDisplayController.searchResultsTableView reloadData];
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //NSLog(@"viewWillAppear");
    //NSLog(@"bounds=(%g, %g)", self.myTableView.bounds.size.width, self.myTableView.bounds.size.height);
    // Hide the search bar until user scrolls up
    //CGRect newBounds = [self.mySearchBar bounds];
    //newBounds.origin.y = newBounds.origin.y - mySearchBar.bounds.size.height;
    //[self.searchDisplayController.searchResultsTableView setBounds:newBounds];
    //[self.myTableView setBounds:newBounds];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Don't show the scope bar or cancel button until editing begins
    //[mySearchBar setShowsScopeBar:NO];
    //[mySearchBar sizeToFit];
    
    /*
    userArray = [NSArray arrayWithObjects:
                 [User initWithName:@"Sheng Jun Dong"],
                 [User initWithName:@"Howard Lin"],
                 [User initWithName:@"William Wu"],
                 [User initWithName:@"BBking"],
                 [User initWithName:@"Troy"],nil];
    
    // Initialize the filteredCandyArray with a capacity equal to the candyArray's capacity
    filteredUserArray = [NSMutableArray arrayWithCapacity:[userArray count]];
    */
    // Reload the table
    //[[self myTableView] reloadData];
    
	// Do any additional setup after loading the view.
    //appImageNames = [[NSArray alloc] initWithObjects:@"sheng.jpg",@"howard.jpg",@"william.jpg",@"bbking.jpg",@"troy.jpg",nil];
    
    //tableData = [[NSArray alloc] initWithObjects:@"Sheng Jun Dong",@"Howard Lin",@"William Wu",@"BBking",@"Troy", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [userArray count];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"UserCell";

    HomeUserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[HomeUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    User *user = nil;
    /*
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        user = [filteredUserArray objectAtIndex:[indexPath row]];
    }
	else
	{*/
        user = [userArray objectAtIndex:[indexPath row]];
    //}
    
    cell.userNameLabel.text = [user name];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    //UIImage * image = [UIImage imageNamed:[appImageNames objectAtIndex:indexPath.row]];
    //cell.thumbnailImageView.image = image;
    return cell;
        
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	// Update the filtered array based on the search text and scope.
	
    // Remove all objects from the filtered search array
    
    [self searchUser:searchText];
    
    
	//[self.filteredUserArray removeAllObjects];
    
	// Filter the array using NSPredicate
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    //NSArray *tempArray = [userArray filteredArrayUsingPredicate:predicate];
    
    //filteredUserArray = [NSMutableArray arrayWithArray:tempArray];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

@end
