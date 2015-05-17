//
//  UIView + Extensions.m
//  TrainingBook
//
//  Created by Mikk Pavelson on 11/7/11.
//  Copyright (c) 2011 Mobi Solutions OÜ. All rights reserved.
//

#import "UIView + Extensions.h"

@implementation UIView (Extensions)

+ (UIView *)loadViewFromXib:(NSString *)xibName {
  UIView *result = nil;
  NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];
  for (id currentObject in topLevelObjects) {
    if ([currentObject isKindOfClass:[UIView class]]) {
      result = currentObject; 
      break;
    }
  }
  
  return result;
}

- (void)keepDistance:(CGFloat)distanceFromViewCenter fromViews:(NSArray *)otherViews
{
  CGPoint newCenter = CGPointZero;
  newCenter.y = CGRectGetMaxY(self.frame) + distanceFromViewCenter;
  
  for (UIView *otherView in otherViews) {
    newCenter.x = otherView.center.x;
    [otherView setCenter:newCenter];
  }
}

@end
