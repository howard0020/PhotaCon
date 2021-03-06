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
#import "UserProfileTableViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize userArray;
@synthesize mySearchBar;
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
    NSLog(@"Searching text: %@", text);
    [[PhotaServerProxy sharedInstance] searchForUser:text withCallback:^(BOOL status, id Result, NSError *error) {
        
        NSArray * list = (NSArray *)Result;
        [self.userArray removeAllObjects];
        for (NSDictionary * userDict in list) {
            NSDictionary * user = [userDict objectForKey:@"user"];
            User *newUser = [User initWithDict:user];
            [self.userArray addObject:newUser];
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
    appImageNames = [[NSArray alloc] initWithObjects:@"photacon.png",@"facebook.png",@"twitter.png",@"foursquare.png",@"googleplus.png",@"linkedin.png",@"myspace.png",@"orkut.png",@"tumblr.png",nil];
    
    appImageLabel = [[NSArray alloc] initWithObjects:@"photacon",@"facebook",@"twitter",@"foursquare",@"googleplus",@"linkedin",@"myspace",@"orkut",@"tumblr", nil];
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
    [cell removeCellContent];
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
    
    cell.userNameLabel.text = [user firstName];
    NSLog(@"Name: %@", [user firstName]);
    NSLog(@"applications count: %i", user.applications.count);
    
    for (NSInteger i = 0; user.applications.count > i; i++) {
        id dict = user.applications[i];
        NSInteger imageIndex = [appImageLabel indexOfObject:[dict valueForKey:@"plugin"]];
        UIImage * image = [UIImage imageNamed:[appImageNames objectAtIndex:imageIndex]];
        if(i == 0)
            cell.app1.image = image;
        else if(i == 1)
            cell.app2.image = image;
        else if(i == 2)
            cell.app3.image = image;
        else if(i == 3)
            cell.app4.image = image;
        else
            cell.app5.image = image;
    }
    //Populate sample thumbnail image
    if([user.firstName isEqualToString:@"Sheng Jun"])
        cell.thumbnailImageView.image = [UIImage imageNamed:@"sheng.jpg"];
    else if([user.firstName isEqualToString:@"Xiao Qiang"])
        cell.thumbnailImageView.image = [UIImage imageNamed:@"william.jpg"];
    else if([user.firstName isEqualToString:@"howard"])
        cell.thumbnailImageView.image = [UIImage imageNamed:@"howard.jpg"];
    else if([user.firstName isEqualToString:@"Troy"])
        cell.thumbnailImageView.image = [UIImage imageNamed:@"troy.jpg"];
    else if([user.firstName isEqualToString:@"Bbk"])
        cell.thumbnailImageView.image = [UIImage imageNamed:@"bbking.jpg"];
    else
        cell.thumbnailImageView.image = [UIImage imageNamed:@"ab.jpg"];
    
    //cell.emailLabel.text = [user email];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"clicking cell");
    UITableViewCell *userCell = [tableView cellForRowAtIndexPath:indexPath];
    if (userCell){
        [self performSegueWithIdentifier:@"userProfile" sender:userCell];
    }
        
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]] && [segue.identifier isEqualToString:@"userProfile"]) {
        //User *user = [userArray objectAtIndex:[sender row]];
        //[segue.destinationViewController setPersonToView:user];
        UITableViewCell *cell = sender;
        NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForCell:cell];
        if (indexPath) {
            // get the current user
            User *user = [userArray objectAtIndex:[indexPath row]];
            
            // pass data to next view controller
            [segue.destinationViewController setPersonToView:user];
            
        }
        NSLog(@"preparing for segue");
    }
}

@end
