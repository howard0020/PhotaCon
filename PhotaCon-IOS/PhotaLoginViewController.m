//
//  photaViewController.m
//  PhotaCon-IOS
//
//  Created by chenghao lin on 1/3/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import "PhotaLoginViewController.h"
#import "LoginAppCell.h"
@interface PhotaLoginViewController ()

@end

@implementation PhotaLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	appImageNames = [[NSArray alloc] initWithObjects:@"facebook.png",@"twitter.png",@"foursquare.png",@"googleplus.png",@"linkedin.png",@"myspace.png",@"orkut.png",@"tumblr.png",nil];
    
    appImageLabel = [[NSArray alloc] initWithObjects:@"facebook",@"twitter",@"foursquare",@"googleplus",@"linkedin",@"myspace",@"orkut",@"tumblr", nil];
    
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
    }
    return myCell;
}
-(void)doLoginBtnPressed:(id)sender
{
    NSLog(@"did doLoginBtn");
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"did select %@",indexPath.description);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
