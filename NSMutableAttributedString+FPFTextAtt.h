//
//  NSMutableAttributedString+FPFTextAtt.h
//  FanPink
//
//  Created by NickyWan on 16/8/8.
//  Copyright © 2016年 Kugou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (FPFTextAtt)

+ (NSMutableAttributedString *)fpf_attributeText:(NSString *)string;

- (CGSize)fpf_drawingSizeWithSize:(CGSize)size;

- (void)fpf_setFont:(UIFont *)font;

- (void)fpf_setFont:(UIFont *)font range:(NSRange)range;

- (void)fpf_setColor:(UIColor *)color;

- (void)fpf_setColor:(UIColor *)color range:(NSRange)range;

- (void)fpf_setLineSpace:(NSInteger)space;

- (void)fpf_setLineHeight:(NSInteger)height;

- (void)fpf_setLineBreakMode:(NSLineBreakMode)breakMode;


+ (NSAttributedString *)fpf_attachmentAttributedWithImage:(UIImage *)image;

+ (NSAttributedString *)fpf_attachmentAttributedWithImage:(UIImage *)image offset:(CGFloat)offset;

- (void)fpf_addImage:(UIImage *)image atIndex:(NSInteger)idx;

- (void)fpf_addImage:(UIImage *)image atIndex:(NSInteger)idx offset:(CGFloat)offset;

- (void)fpf_replaceCharactersInRange:(NSRange)range withImage:(UIImage *)image;

@end
