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
@property (nonatomic, weak) IBOutlet UILabel *distantLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;

@end
