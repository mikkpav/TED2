//
//  UtilityManager.h
//  TED
//
//  Created by Mikk Pavelson on 15/03/15.
//  Copyright (c) 2015 mp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UtilityManager : NSObject

+ (UtilityManager *)sharedManager;
- (void)showNetworkErrorAlert;
- (void)showNetworkErrorAlertWithText:(NSString *)text;
- (UIFont *)appFontWithSize:(CGFloat)size;

@end
