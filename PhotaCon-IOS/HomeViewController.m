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
@interface HomeViewController ()

@end

@implementation HomeViewController
{
    NSArray *tableData, *appImageNames;
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"search bar click");
    [[PhotaServerProxy sharedInstance] searchForUser:@"howard" withCallback:^(BOOL status, id Result, NSError *error) {
        NSLog(@"got result:%@",Result);
    }];
}

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
    appImageNames = [[NSArray alloc] initWithObjects:@"sheng.jpg",@"howard.jpg",@"william.jpg",@"bbking.jpg",@"troy.jpg",nil];
    
    tableData = [[NSArray alloc] initWithObjects:@"Sheng Jun Dong",@"Howard Lin",@"William Wu",@"BBking",@"Troy", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"UserCell";
    
    HomeUserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[HomeUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.userNameLabel.text = [tableData objectAtIndex:indexPath.row];
    UIImage * image = [UIImage imageNamed:[appImageNames objectAtIndex:indexPath.row]];
    cell.thumbnailImageView.image = image;
    return cell;
        
}
@end
