//
//  Item.h
//  TED
//
//  Created by Mikk Pavelson on 12/03/15.
//  Copyright (c) 2015 mp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Item : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *urlImage;
@property (nonatomic, copy) NSString *urlVideo;
@property (nonatomic, strong, setter = setImageBig:) UIImage *image;
@property (nonatomic, strong) UIImage *imageThumb;
@property (nonatomic, copy) NSString *summary;

+ (Item *)item;

- (void)appendToTitle:(NSString *)string;
- (void)appendToSummary:(NSString *)string;
- (void)cleanUpSummary;
- (void)appendToURLImage:(NSString *)string;
- (void)appendToURLVideo:(NSString *)string;
- (BOOL)allDataParsed;
- (void)setImage:(UIImage *)image;

@end