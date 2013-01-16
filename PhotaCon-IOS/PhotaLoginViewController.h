//
//  photaViewController.h
//  PhotaCon-IOS
//
//  Created by chenghao lin on 1/3/13.
//  Copyright (c) 2013 billionaire. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotaLoginViewController : UICollectionViewController <UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSArray *appImageNames,*appImageLabel;
    NSString *appSelected;
}
@end
