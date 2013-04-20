//
//  HomeUserCell.h
//  PhotaCon-IOS
//
//  Created by Doug on 1/17/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeUserCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UIImageView *app1;
@property (weak, nonatomic) IBOutlet UIImageView *app2;
@property (weak, nonatomic) IBOutlet UIImageView *app3;
@property (weak, nonatomic) IBOutlet UIImageView *app4;
@property (weak, nonatomic) IBOutlet UIImageView *app5;

-(void) removeCellContent;
@end
