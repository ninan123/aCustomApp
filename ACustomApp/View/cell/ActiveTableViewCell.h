//
//  ActiveTableViewCell.h
//  ACustomApp
//
//  Created by Apple on 16/3/30.
//  Copyright © 2016年 Apple. All rights reserved.
//
#define kCellIdentifier_ActiveTableViewCell @"ActiveTableViewCell"

#import <UIKit/UIKit.h>
#import "ActionModel.h"
@interface ActiveTableViewCell : UITableViewCell

@property (nonatomic, strong) ActionModel *curModel;
@property (nonatomic, strong) NSString *actType;

+(CGFloat)cellHeightWithObj:(id)obj;

@end
