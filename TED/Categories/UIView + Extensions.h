//
//  UIView + Extensions.h
//  TrainingBook
//
//  Created by Mikk Pavelson on 11/7/11.
//  Copyright (c) 2011 Mobi Solutions OÜ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
  DirectionUp,
  DirectionDown,
  DirectionLeft,
  DirectionRight
} Direction;

@interface UIView (Extensions)

+ (UIView *)loadViewFromXib:(NSString *)xibName;
- (void)keepDistance:(CGFloat)distanceFromViewCenter fromViews:(NSArray *)otherViews;

@end
