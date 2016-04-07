//
//  UIButton+Common.m
//  Coding_iOS
//
//  Created by 王 原闯 on 14-8-5.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import "UIButton+Common.h"
#import <math.h>
#import <objc/runtime.h>
#import "NSString+Common.h"

static const void *UIButtonBlockKey = &UIButtonBlockKey;

@implementation UIButton (Common)

-(void)startTime:(NSInteger )timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle{
    __block NSInteger timeOut=timeout; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeOut<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setTitle:tittle forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeOut % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%@",strTime);
                [self setTitle:[NSString stringWithFormat:@"%@%@",strTime,waitTittle] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
                
            });
            timeOut--;
            
        }
    });
    dispatch_resume(_timer);
    
}
+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)color buttonFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.backgroundColor = [UIColor clearColor];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
    [button.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [button setTitle:title forState:UIControlStateNormal];
    button.frame = frame;
    if (backgroundColor) {
        button.backgroundColor = backgroundColor;
    }
    
    return button;
}

- (void) buttonLayerRadius:(float)cornerRadius borderColor:(UIColor *)borderColor borderWidth:(float)borderWidth
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
 
}
-(void)addActionHandler:(TouchedBlock)touchHandler{
    objc_setAssociatedObject(self, UIButtonBlockKey, touchHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(actionTouched:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)actionTouched:(UIButton *)btn{
    TouchedBlock block = objc_getAssociatedObject(self, UIButtonBlockKey);
    if (block) {
        block(btn.tag);
    }
}
@end
