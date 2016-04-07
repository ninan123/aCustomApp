//
//  GeneralViewCell.h
//  ACustomApp
//
//  Created by Apple on 16/3/30.
//  Copyright © 2016年 Apple. All rights reserved.
//
#define kCellIdentifier_GeneralViewCell @"GeneralViewCell"

#import <UIKit/UIKit.h>

@interface GeneralViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;

-(void)setUpAvatar:(NSString *)avatar title:(NSString *)title content:(NSString *)content;
@end
