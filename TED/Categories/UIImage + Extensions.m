//
//  UIImage + Extensions.m
//  TED
//
//  Created by Mikk Pavelson on 14/03/15.
//  Copyright (c) 2015 mp. All rights reserved.
//

#import "UIImage + Extensions.h"

@implementation UIImage (Extensions)

- (UIImage *)convertToSize:(CGSize)size
{
  UIGraphicsBeginImageContext(size);
  [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
  UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return resizedImage;
}

@end
