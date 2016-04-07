//
//  GeneralViewCell.m
//  ACustomApp
//
//  Created by Apple on 16/3/30.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "GeneralViewCell.h"

@implementation GeneralViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = BGCOLOR;
    _title.font = [UIFont boldSystemFontOfSize:17];

}
-(void)setUpAvatar:(NSString *)avatar title:(NSString *)title content:(NSString *)content
{
    _avatar.image = [UIImage imageNamed:avatar];
    _title.text = title;
    _content.text = content;
    _content.textColor = RGBColor(0, 102, 179);
}


@end
