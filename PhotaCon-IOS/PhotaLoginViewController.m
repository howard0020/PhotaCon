//
//  photaViewController.m
//  PhotaCon-IOS
//
//  Created by chenghao lin on 1/3/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import "PhotaLoginViewController.h"
#import "LoginAppCell.h"
#import "PhotaLoginManager.h"
#import "PhotaLoginPhotaConViewController.h"

@interface PhotaLoginViewController ()

@end

@implementation PhotaLoginViewController{
@private BOOL firstTime;
}


-(void)viewWillAppear:(BOOL)animated
{
    [self checkLogin];
}
-(void)checkLogin{
    if ([PhotaLoginManager sharedInstance].isLogin) {
        [self performSegueWithIdentifier:@"HomeView" sender:self];
        NSLog(@"logined in!");
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkLogin) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    firstTime = YES;
	appImageNames = [[NSArray alloc] initWithObjects:@"photacon.png",@"facebook.png",@"twitter.png",@"foursquare.png",@"googleplus.png",@"linkedin.png",@"myspace.png",@"orkut.png",@"tumblr.png",nil];
    
    appImageLabel = [[NSArray alloc] initWithObjects:@"photacon",@"facebook",@"twitter",@"foursquare",@"googleplus",@"linkedin",@"myspace",@"orkut",@"tumblr", nil];
}
-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return appImageNames.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"CellID";
    LoginAppCell * myCell = (LoginAppCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if(indexPath.section == 0){
        UIImage * image = [UIImage imageNamed:[appImageNames objectAtIndex:indexPath.item]];
        [myCell.cellBtn setImage:image forState:UIControlStateNormal];
        [myCell.cellBtn setTag:indexPath.item];
        [myCell.cellBtn addTarget:self action:@selector(doLoginBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [myCell.cellBtn  setTitle:[appImageLabel objectAtIndex:indexPath.item] forState:UIControlStateNormal];
    }
    return myCell;
}
-(void)doLoginBtnPressed:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    NSString * appSelected = [button titleLabel].text;
    
    if([appSelected isEqualToString: @"facebook"]){
        
        PhotaLoginModel * model = [[PhotaLoginModel alloc] init];
        __weak PhotaLoginViewController *weakSelf = self;
        model.loginCallBack = ^(BOOL status) {
            if (status) {
                NSLog(@"Logged into Facebook!");
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Welcome to PhotaCon"
                                                                    message:@"Emjoy!"
                                                                   delegate:weakSelf
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                [alertView show];
            }else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                                    message:@"Unable to login!"
                                                                   delegate:weakSelf
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                [alertView show];
            }
            
        };
        [[PhotaLoginManager sharedInstance] loginInWithFacebook:model];
    }else{
        [self performSegueWithIdentifier:@"LoginIn" sender:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)appButtonClicked:(id)sender {
}
@end
