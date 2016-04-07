//
//  LeftSliderCell.m
//  ACustomApp
//
//  Created by Apple on 16/3/30.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "LeftSliderCell.h"

@implementation LeftSliderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setImage:(UIImage *)image andTitle:(NSString *)title EnTitle:(NSString *)entitle
{
    _img.image = image;
    _title.text = title;
    _SmTitle.text = entitle;
}


@end
