//
//  UILabel+Common.m
//  Coding_iOS
//
//  Created by 王 原闯 on 14-8-8.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import "UILabel+Common.h"

@implementation UILabel (Common)

- (void) setLongString:(NSString *)str withFitWidth:(CGFloat)width maxHeight:(CGFloat)maxHeight{
    self.numberOfLines = 0;
    CGSize resultSize = [str getSizeWithFont:self.font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)];
    CGFloat resultHeight = resultSize.height;
    if (maxHeight > 0 && resultHeight > maxHeight) {
        resultHeight = maxHeight;
    }
    CGRect frame = self.frame;
    frame.size.height = resultHeight;
    [self setFrame:frame];
    self.text = str;
}
+ (instancetype) initWithFrame: (CGRect)frame withFont :(float)font andText:(NSString *)text textColor:(UIColor *)textColor
{
    UILabel *label = [self new];
   
    
    if (!font) {
        
        label.font = [UIFont systemFontOfSize:font];
    }
    
    if (!textColor) {
        
        label.textColor = [UIColor blackColor];
        
    }
    
    if (!text) {
        
        label.text = @"";
    }
    
    label.frame = frame;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = textColor;
    label.text = text;
    
    return label;
    
}

@end
