//
//  DetailViewController.m
//  TED
//
//  Created by Mikk Pavelson on 12/03/15.
//  Copyright (c) 2015 mp. All rights reserved.
//

#import "DetailViewController.h"
#import "Item.h"
#import "BackgroundImageCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AFNetworking.h"
#import "UtilityManager.h"

@interface DetailViewController ()

@property (nonatomic, strong) Item *item;
@property (nonatomic, strong) BackgroundImageCell *backgroundCell;

@end



@implementation DetailViewController

#pragma mark - Managing the detail item

- (id)initWithItem:(Item *)item
{
  self = [super init];
  if (self)
  {
    [self setItem:item];
  }
  
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self.tableView setSeparatorColor:[UIColor whiteColor]];
  
  BackgroundImageCell *cell = [BackgroundImageCell cellWithItem:self.item];
  [self setBackgroundCell:cell];
}

- (void)viewWillLayoutSubviews
{
  [self.backgroundCell refresh];
}

#pragma mark - Table view

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  CGFloat height = self.backgroundCell.frame.size.height;
  
  if (indexPath.row == 1)
  {
    // Get the approximate height for the cell based on the item's summary.
    // if this was a regular repetetive table view row I would find a more effective way.
    UILabel *gettingSizeLabel = [[UILabel alloc] init];
    gettingSizeLabel.font = [[UtilityManager sharedManager] appFontWithSize:19.0];
    gettingSizeLabel.text = self.item.summary;
    gettingSizeLabel.numberOfLines = 0;
    gettingSizeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    // I'm substracting 50.0, because the cell's textLabel isn't as wide as the view itself,
    // but its width is unobtainable without hacks.
    CGSize maximumLabelSize = CGSizeMake(self.view.frame.size.width, 9999);
    CGSize expectSize = [gettingSizeLabel sizeThatFits:maximumLabelSize];
    
    height = expectSize.height;
  }
  
  return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *identifier = @"CellIdentifier";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  
  if (indexPath.row == 0)
  {
    cell = self.backgroundCell;
  }
  else if (!cell && indexPath.row == 1)
  {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    [cell.textLabel setNumberOfLines:0];
    [cell.textLabel setFont:[[UtilityManager sharedManager] appFontWithSize:17.0]];
    [cell.textLabel setText:self.item.summary];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
  }
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.row == 0)
  {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    if (!manager.reachable)
    {
      [[UtilityManager sharedManager] showNetworkErrorAlert];
      
      return;
    }
    
    MPMoviePlayerViewController *videoController = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:self.item.urlVideo]];
    [self presentViewController:videoController animated:YES completion:nil];
  }
}

@end
