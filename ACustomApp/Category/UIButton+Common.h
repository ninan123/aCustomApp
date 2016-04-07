//
//  UIButton+Common.h
//  Coding_iOS
//
//  Created by 王 原闯 on 14-8-5.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TouchedBlock)(NSInteger tag);

@interface UIButton (Common)

/**
 *  快速初始化button
 */
+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)color buttonFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor;

/**
 *  验证码倒计时
 *
 *  */
-(void)startTime:(NSInteger )timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle;

/**
 *  设置button圆角
 */
- (void) buttonLayerRadius:(float)cornerRadius borderColor:(UIColor *)borderColor borderWidth:(float)borderWidth;
/**
 *  添加button点击事件
 *
 */
-(void)addActionHandler:(TouchedBlock)touchHandler;

@end
