//
//  BackgroundImageCell.h
//  TED
//
//  Created by Mikk Pavelson on 14/03/15.
//  Copyright (c) 2015 mp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Item;

@interface BackgroundImageCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

+ (BackgroundImageCell *)cellWithItem:(Item *)item;

- (void)refresh;

@end
