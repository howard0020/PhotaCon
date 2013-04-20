//
//  UserProfileTableViewController.m
//  PhotaCon-IOS
//
//  Created by Doug on 1/23/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import "UserProfileTableViewController.h"
#import "FriendRequestViewController.h"
#import "User.h"

#define IS_FRIEND @"FRIEND"
#define IS_NOT_FRIEND @"NOT FRIEND"

@interface UserProfileTableViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addFriendsBtn;
@property (nonatomic, strong) NSMutableArray *userApplications; // application name => boolean indicating whether
@property (nonatomic, strong) NSMutableDictionary *friendRelation;
@property (nonatomic, strong) NSMutableArray *selectedAppsArray;
@end

@implementation UserProfileTableViewController
@synthesize userApplications = _userApplications;
@synthesize friendRelation = _friendRelation;
@synthesize personToView = _personToView;
@synthesize selectedAppsArray = _selectedAppsArray;
@synthesize addFriendsBtn = _addFriendsBtn;

- (NSMutableArray *)userApplications
{
    if (_userApplications == nil)
    {
        _userApplications = [[NSMutableArray alloc]initWithObjects:
                            @"facebook", 
                            @"linkedin",
                            @"twitter", 
                            @"wechat", nil];
    }
    return _userApplications;
}

- (NSMutableArray *)selectedAppsArray
{
    if (_selectedAppsArray== nil) {
        _selectedAppsArray = [[NSMutableArray alloc]init];
    }
    return _selectedAppsArray;
}

- (NSMutableDictionary *)friendRelation
{
    if (_friendRelation == nil)
    {
        _friendRelation = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                             IS_NOT_FRIEND, @"facebook",
                             IS_FRIEND, @"linkedin",
                             IS_FRIEND, @"twitter",
                             IS_FRIEND, @"wechat", nil];
    }
    return _friendRelation;
}

- (void)viewDidLoad
{
    self.navigationItem.title = self.personToView.name;
}

- (BOOL) isFriendInApplication:(NSString *)applicationName
{
    return [self.friendRelation objectForKey:applicationName] == IS_FRIEND;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"%i", [self.personToView.applications count]);
    return [self.personToView.applications count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"userApp";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        NSLog(@"cell is nil");
    }
    
    NSDictionary *userApp = [self.personToView.applications objectAtIndex:indexPath.row];
    
    NSString *appName = [userApp valueForKey:@"plugin"];
    if ([self.selectedAppsArray containsObject:appName]) {
        cell.imageView.image = [UIImage imageNamed:@"checked.png"];
    }
    else {
        cell.imageView.image = [UIImage imageNamed:@"unchecked.png"];
    }
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleChecking:)];
    [cell addGestureRecognizer:tap];
    cell.imageView.userInteractionEnabled = YES; //added based on @John 's comment
    
    cell.textLabel.text = appName;
    
    /*
    cell.detailTextLabel.text = @"add friend";
    if ([self isFriendInApplication:userApp]) {
        cell.detailTextLabel.text = @"already friend";
        cell.accessoryView = nil;
        cell.userInteractionEnabled = NO;
    }
    */
    NSLog(@"%i", indexPath.row);
    
    return cell;
}

- (void) handleChecking:(UITapGestureRecognizer *)tapRecognizer {
    CGPoint tapLocation = [tapRecognizer locationInView:self.tableView];
    NSIndexPath *tappedIndexPath = [self.tableView indexPathForRowAtPoint:tapLocation];
    NSString *appName = [[self.personToView.applications objectAtIndex:tappedIndexPath.row] objectForKey:@"plugin"];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:tappedIndexPath];
    if ([self.selectedAppsArray containsObject:appName]) {
        [self.selectedAppsArray removeObject:appName];
        cell.imageView.image = [UIImage imageNamed:@"unchecked.png"];
    }
    else {
        [self.selectedAppsArray addObject:appName];
        cell.imageView.image = [UIImage imageNamed:@"checked.png"];
    }

    self.addFriendsBtn.enabled = [self.selectedAppsArray count]!= 0;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    NSLog(@"%@", @"selecting a cell");
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"addFriends"]) {
        // pass data to next view controller
        //NSURL *friendRequestURL = [NSURL URLWithString:@"http://facebook.com/dialog/friends/?id=1368420155&app_id=145499585599212&redirect_uri=http://localhost:8080/"];
        //[segue.destinationViewController setFriendRequestURL:friendRequestURL];
        [segue.destinationViewController setPersonToAdd:self.personToView];
        NSLog(@"passing data to next view controller");
    }
}
@end
