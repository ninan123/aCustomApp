//
//  LeftSliderCell.h
//  ACustomApp
//
//  Created by Apple on 16/3/30.
//  Copyright © 2016年 Apple. All rights reserved.
//
#define kCellIdentifier_LeftSliderCell @"LeftSliderCell"

#import <UIKit/UIKit.h>

@interface LeftSliderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *SmTitle;


-(void)setImage:(UIImage *)image andTitle:(NSString *)title EnTitle:(NSString *)entitle;

@end
