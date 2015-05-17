//
//  DetailViewController.h
//  TED
//
//  Created by Mikk Pavelson on 12/03/15.
//  Copyright (c) 2015 mp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Item;

@interface DetailViewController : UITableViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

- (id)initWithItem:(Item *)item;

@end

