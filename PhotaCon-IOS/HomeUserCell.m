//
//  HomeUserCell.m
//  PhotaCon-IOS
//
//  Created by Doug on 1/17/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import "HomeUserCell.h"

@implementation HomeUserCell

@synthesize userNameLabel = _userNameLabel;
@synthesize emailLabel = _emailLabel;
@synthesize thumbnailImageView = _thumbnailImageView;
@synthesize app1 = _app1;
@synthesize app2 = _app2;
@synthesize app3 = _app3;
@synthesize app4 = _app4;
@synthesize app5 = _app5;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"HomeUserCell" owner:self options:nil];
        self = [array objectAtIndex:0];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) removeCellContent{
    self.app1.image = nil;
    self.app2.image = nil;
    self.app3.image = nil;
    self.app4.image = nil;
    self.app5.image = nil;
    self.thumbnailImageView.image = nil;
}

@end
