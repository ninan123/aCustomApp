//
//  ProjectHearderView.m
//  ACustomApp
//
//  Created by Apple on 16/3/31.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ProjectHearderView.h"

@interface ProjectHearderView ()<UITextFieldDelegate>
@property (strong, nonatomic) UILabel *label1, *label2;
@property (strong, nonatomic) UIButton *button1, *button2,*button3;
@property (strong, nonatomic) UITextField *textField;

@end

@implementation ProjectHearderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configViews];
    }
    return self;
    
}
-(void)configViews
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    bgView.backgroundColor = BGCOLOR;
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 115)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:whiteView];
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 35, 25)];
//    label.text = @"省份";
//    label.textColor = RGBColor(15, 104, 181);
//    label.font = [UIFont boldSystemFontOfSize:16];
//    [whiteView addSubview:label];
//    _label1 = label;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15, 20, SCREEN_WIDTH/2-20, 33);
    [button setTitle:@"全国" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:15.5];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 3;
//    button.layer.borderWidth = 1;
//    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [whiteView addSubview:button];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (_Button1itemDidSelected) {
            _Button1itemDidSelected(button);
        }
    }];
    _button1 = button;
    
//    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+10, 20, 35, 25)];
//    label1.text = @"企业";
//    label1.textColor = RGBColor(15, 104, 181);
//    label1.font = [UIFont boldSystemFontOfSize:16];
//    [whiteView addSubview:label1];
//    _label2 = label1;
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(SCREEN_WIDTH/2+10, 30, SCREEN_WIDTH/2-25, 33);
    [button1 setTitle:@"全部" forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:15.5];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button1.layer.cornerRadius = 3;
//    button1.layer.borderWidth = 1;
//    button1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [whiteView addSubview:button1];
    button1.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    button1.centerY = button.centerY;
    button1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [[button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (_Button2itemDidSelected) {
            _Button2itemDidSelected(button1);
        }
    }];
    _button2 = button1;
    button.backgroundColor = RGBColor(15, 104, 181);
    button1.backgroundColor = RGBColor(15, 104, 181);

    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(kPaddingLeftWidth, button.bottom+14, SCREEN_WIDTH-110, 33)];
    _textField.backgroundColor = [UIColor clearColor];
    _textField.borderStyle = UITextBorderStyleNone;
    _textField.font = [UIFont systemFontOfSize:15.5];
    _textField.layer.cornerRadius = 3;
    _textField.layer.borderWidth = 1;
    _textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.placeholder = @" 请输入关键字";
    [bgView addSubview:_textField];
    _textField.textColor = RGBColor(15, 104, 181);
    _textField.delegate = self;
    [[_textField rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(id x) {
        NSLog(@"button点击事件");
    }];

    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(_textField.right+7, 30, 70, 33);
    [button2 setTitle:@"搜索" forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:16];
    button2.backgroundColor = RGBColor(15, 104, 181);
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [whiteView addSubview:button2];
    button2.layer.cornerRadius = 3;
    button2.centerY = _textField.centerY;
    [[button2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (_searchButtonitemDidSelected) {
            _searchButtonitemDidSelected(_textField.text);
        }
    }];
    _button3 = button2;
    
    UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(button.width-24, 4, 22, 22)];
    img1.image = [UIImage imageNamed:@"triangle"];
    [button addSubview:img1];
    
    UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(button1.width-24, 4, 22, 22)];
    img2.image = [UIImage imageNamed:@"triangle"];
    [button1 addSubview:img2];
    
    
    [self addSubview:bgView];
}

-(void)configFirstSre:(NSString *)str button1:(NSString *)str1 label2:(NSString *)str2 button2:(NSString *)str3
{
    _label1.text = str;
    _label2.text = str2;
    [_button1 setTitle:str1 forState:UIControlStateNormal];
    [_button2 setTitle:str3 forState:UIControlStateNormal];
    
//    if (str2.length < 3) {
//        _label2.width = 40;
//        _button2.left = _label2.right;
//        _button2.width = 100;
//    }else{
//        _label2.left = _label2.left-10;
//        _label2.width = 65;
//        _button2.left = _label2.right;
//        _button2.width = 80;
//    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (_textFieldBeginEdit) {
        _textFieldBeginEdit(textField);
    }
}
@end
