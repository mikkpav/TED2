//
//  BackgroundImageCell.m
//  TED
//
//  Created by Mikk Pavelson on 14/03/15.
//  Copyright (c) 2015 mp. All rights reserved.
//

#import "BackgroundImageCell.h"
#import "Item.h"
#import "UIView + Extensions.h"

@interface BackgroundImageCell ()

@property (nonatomic, strong) CAGradientLayer *gradient;
@property (nonatomic, strong) Item *item;

@end

@implementation BackgroundImageCell

+ (BackgroundImageCell *)cellWithItem:(Item *)item
{
  BackgroundImageCell *cell = (BackgroundImageCell *)[BackgroundImageCell loadViewFromXib:@"BackgroundImageCell"];
  [cell setItem:item];
  [cell.backgroundImageView setImage:item.image];
  [cell.titleLabel setText:item.title];
  [cell.titleLabel sizeToFit];
  
  CGRect frame = cell.titleLabel.frame;
  frame.origin.y = cell.frame.size.height - frame.size.height;
  frame.origin.x = (cell.frame.size.width - frame.size.width) / 2;
  [cell.titleLabel setFrame:frame];
  
  CAGradientLayer *gradient = [CAGradientLayer layer];
  gradient.frame = cell.backgroundImageView.bounds;
  [gradient setColors:@[(id)[[UIColor clearColor] CGColor], (id)[[UIColor blackColor] CGColor]]];
  [cell.backgroundImageView.layer insertSublayer:gradient below:cell.titleLabel.layer];
  [cell setGradient:gradient];
  
  return cell;
}

- (void)refresh
{
  self.gradient.frame = self.backgroundImageView.bounds;

  [self.titleLabel setText:self.item.title];
  [self.titleLabel sizeToFit];
  
  CGRect frame = self.titleLabel.frame;
  frame.origin.y = self.frame.size.height - frame.size.height;
  frame.origin.x = (self.frame.size.width - frame.size.width) / 2;
  [self.titleLabel setFrame:frame];
}

@end
