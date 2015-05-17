//
//  Item.m
//  TED
//
//  Created by Mikk Pavelson on 12/03/15.
//  Copyright (c) 2015 mp. All rights reserved.
//

#import "Item.h"
#import "UIImage + Extensions.h"

@implementation Item

+ (Item *)item
{
  Item *newItem = [[Item alloc] init];
  [newItem setTitle:[NSString string]];
  [newItem setSummary:[NSString string]];
  [newItem setUrlImage:[NSString string]];
  [newItem setUrlVideo:[NSString string]];
  [newItem description];
  
  return newItem;
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"title: %@\nimageURL: %@\nvideoURL: %@" , self.title, self.urlImage, self.urlVideo];
}

- (void)appendToTitle:(NSString *)string
{
  NSMutableString *tempString = [NSMutableString stringWithString:self.title];
  [tempString appendString:string];
  [self setTitle:tempString];
}

- (void)appendToSummary:(NSString *)string
{
  NSMutableString *tempString = [NSMutableString stringWithString:self.summary];
  [tempString appendString:string];
  [self setSummary:tempString];
}

- (void)cleanUpSummary
{
  // @"&lt;"
  NSArray *comps = [self.summary componentsSeparatedByString:@"<"];
  NSString *finalString = comps.firstObject;
  
  [self setSummary:finalString];
}

- (void)appendToURLImage:(NSString *)string
{
  NSMutableString *tempString = [NSMutableString stringWithString:self.urlImage];
  [tempString appendString:string];
  [self setUrlImage:tempString];
}

- (void)appendToURLVideo:(NSString *)string
{
  NSMutableString *tempString = [NSMutableString stringWithString:self.urlVideo];
  [tempString appendString:string];
  [self setUrlVideo:tempString];
}

- (BOOL)allDataParsed
{
  BOOL hasTitle = self.title.length > 0;
  BOOL hasSummary = self.summary.length > 0;
  BOOL hasImageURL = self.urlImage.length > 0;
  BOOL hasVideoURL = self.urlVideo.length > 0;
  
  return (hasTitle && hasSummary && hasImageURL && hasVideoURL);
}

- (void)setImage:(UIImage *)image
{
  [self setImageBig:image];
  
  CGSize size = image.size;
  CGFloat ratio = size.height / size.width;
  UIImage *resizedImage = [image convertToSize:CGSizeMake(70.0, 70.0 * ratio)];
  [self setImageThumb:resizedImage];
}

@end
