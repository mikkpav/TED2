//
//  UtilityManager.m
//  TED
//
//  Created by Mikk Pavelson on 15/03/15.
//  Copyright (c) 2015 mp. All rights reserved.
//

#import "UtilityManager.h"

@implementation UtilityManager

+ (UtilityManager *)sharedManager
{
  static UtilityManager *_sharedManager = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedManager = [[UtilityManager alloc] init];
  });
  return _sharedManager;
}

- (void)showNetworkErrorAlert
{
  [self showNetworkErrorAlertWithText:@"It seems that you have no internet connection.\nFeel free to try again later!"];
}

- (void)showNetworkErrorAlertWithText:(NSString *)text
{
  UIAlertView *networkAlert = [[UIAlertView alloc] initWithTitle:@"Network problem"
                                                         message:text
                                                        delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
  [networkAlert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
  
}

- (UIFont *)appFontWithSize:(CGFloat)size
{
  return [UIFont fontWithName:@"HelveticaNeue-Light" size:size];
}

@end
