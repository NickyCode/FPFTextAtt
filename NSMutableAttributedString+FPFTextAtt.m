//
//  NSMutableAttributedString+FPFTextAtt.m
//  FanPink
//
//  Created by NickyWan on 16/8/8.
//  Copyright © 2016年 Kugou. All rights reserved.
//

#import "NSMutableAttributedString+FPFTextAtt.h"
#import <objc/runtime.h>

@implementation NSMutableAttributedString (FPFTextAtt)

+ (NSMutableAttributedString *)fpf_attributeText:(NSString *)string
{
    if (string) {
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:string];
        return att;
    }
    return nil;
}

- (CGSize)fpf_drawingSizeWithSize:(CGSize)size
{
    CGSize drawingSize =  [self boundingRectWithSize:size
                                             options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                             context:nil].size;
    return drawingSize;
}

- (void)fpf_setFont:(UIFont *)font
{
    [self fpf_setFont:font range:NSMakeRange(0, self.length)];
}

- (void)fpf_setFont:(UIFont *)font range:(NSRange)range
{
    [self addAttributes:@{NSFontAttributeName : font} range:range];
}

- (void)fpf_setColor:(UIColor *)color
{
    [self fpf_setColor:color range:NSMakeRange(0, self.length)];
}

- (void)fpf_setColor:(UIColor *)color range:(NSRange)range
{
    [self addAttributes:@{NSForegroundColorAttributeName : color} range:range];
}

#pragma mark - about paragraph

- (void)fpf_setLineSpace:(NSInteger)space
{
    [self.paragraph setLineSpacing:space];
    [self addAttribute:NSParagraphStyleAttributeName value:self.paragraph range:NSMakeRange(0, self.length)];
}

- (void)fpf_setLineSpace:(NSInteger)space range:(NSRange)range
{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    [paragraph setLineSpacing:space];
    [self addAttribute:NSParagraphStyleAttributeName value:paragraph range:range];
}

- (void)fpf_setLineHeight:(NSInteger)height
{
    [self.paragraph setMinimumLineHeight:height];
    [self addAttribute:NSParagraphStyleAttributeName value:self.paragraph range:NSMakeRange(0, self.length)];
}

- (void)fpf_setLineHeight:(NSInteger)height range:(NSRange)range
{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    [paragraph setMinimumLineHeight:height];
    [self addAttribute:NSParagraphStyleAttributeName value:paragraph range:range];
}

- (void)fpf_setLineBreakMode:(NSLineBreakMode)breakMode
{
    [self.paragraph setLineBreakMode:breakMode];
    [self addAttribute:NSParagraphStyleAttributeName value:self.paragraph range:NSMakeRange(0, self.length)];
}

- (void)fpf_setLineBreakMode:(NSLineBreakMode)breakMode range:(NSRange)range
{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    [paragraph setLineBreakMode:breakMode];
    [self addAttribute:NSParagraphStyleAttributeName value:paragraph range:range];
}

- (void)fpf_setAlignment:(NSTextAlignment)alitnment
{
    [self.paragraph setAlignment:alitnment];
    [self addAttribute:NSParagraphStyleAttributeName value:self.paragraph range:NSMakeRange(0, self.length)];
}

#pragma mark - image

+ (NSAttributedString *)fpf_attachmentAttributedWithImage:(UIImage *)image
{
    return [[self class] fpf_attachmentAttributedWithImage:image offset:0];
}

+ (NSAttributedString *)fpf_attachmentAttributedWithImage:(UIImage *)image offset:(CGFloat)offset
{
    if (image) {
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        attachment.image = image;
        attachment.bounds = CGRectMake(0, offset, image.size.width, image.size.height);
        return [NSAttributedString attributedStringWithAttachment:attachment];
    }
    return nil;
}

- (void)fpf_addImage:(UIImage *)image atIndex:(NSInteger)idx
{
    if (image) {
        [self insertAttributedString:[[self class] fpf_attachmentAttributedWithImage:image] atIndex:idx];
    }
}

- (void)fpf_addImage:(UIImage *)image atIndex:(NSInteger)idx offset:(CGFloat)offset
{
    if (image) {
        [self insertAttributedString:[[self class] fpf_attachmentAttributedWithImage:image offset:offset] atIndex:idx];
    }}

- (void)fpf_replaceCharactersInRange:(NSRange)range withImage:(UIImage *)image
{
    if (image) {
        [self replaceCharactersInRange:range withAttributedString:[[self class] fpf_attachmentAttributedWithImage:image]];
    }
}

#pragma mark - paragarph porperty

- (NSMutableParagraphStyle *)paragraph
{
    NSMutableParagraphStyle *paragraph =  objc_getAssociatedObject(self, @selector(paragraph));
    
    if (!paragraph) {
        self.paragraph = [[NSMutableParagraphStyle alloc] init];
    }
    
    return paragraph;
}

- (void)setParagraph:(NSMutableParagraphStyle *)paragraph
{
    objc_setAssociatedObject(self, @selector(paragraph), paragraph, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
