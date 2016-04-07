//
//  ProjectHearderView.h
//  ACustomApp
//
//  Created by Apple on 16/3/31.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectHearderView : UIView


@property (copy, nonatomic) void(^Button1itemDidSelected)(UIButton *button);
@property (copy, nonatomic) void(^Button2itemDidSelected)(UIButton *button);
@property (copy, nonatomic) void(^searchButtonitemDidSelected)(NSString *str);
@property (copy, nonatomic) void(^textFieldBeginEdit)(UITextField *textField);

-(void)configFirstSre:(NSString *)str button1:(NSString *)str1 label2:(NSString *)str2 button2:(NSString *)str3;

@end
