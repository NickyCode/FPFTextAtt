//
//  NSMutableAttributedString+FPFTextAtt.m
//  FanPink
//
//  Created by NickyWan on 16/8/8.
//  Copyright © 2016年 Kugou. All rights reserved.
//

#import "NSMutableAttributedString+FPFTextAtt.h"

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

- (void)fpf_setLineSpace:(NSInteger)space
{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
}

- (void)fpf_setLineHeight:(NSInteger)height
{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setMinimumLineHeight:height];
    [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
}

- (void)fpf_setLineBreakMode:(NSLineBreakMode)breakMode
{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineBreakMode:breakMode];
    [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
}

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

@end
