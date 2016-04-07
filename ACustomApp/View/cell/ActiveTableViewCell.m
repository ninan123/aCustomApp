//
//  ActiveTableViewCell.m
//  ACustomApp
//
//  Created by Apple on 16/3/30.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ActiveTableViewCell.h"
#import "CustomImageView.h"
@interface ActiveTableViewCell ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *timeLabel,*contentLabel;
@property (strong, nonatomic) UILabel *ownerNameLabel;
@property (strong, nonatomic) UIImageView *ownerImgView,*timeImgView;
@property (strong, nonatomic) CustomImageView *contentImgView;

@end

@implementation ActiveTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        //头像
        if (!self.ownerImgView) {
            self.ownerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 8, 25, 25)];
            self.ownerImgView.image = [UIImage imageNamed:@"news"];
            [self.contentView addSubview:self.ownerImgView];
        }
        //类别
        if (!self.ownerNameLabel) {
            self.ownerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.ownerImgView.right+5, self.ownerImgView.top+5, 200, 25)];
            self.ownerNameLabel.font = [UIFont boldSystemFontOfSize:15];
            self.ownerNameLabel.textColor = RGBColor(0, 104, 179);
            [self.contentView addSubview:self.ownerNameLabel];
            self.ownerNameLabel.centerY = self.ownerImgView.centerY;
        }
        //时间image
        if (!self.timeImgView) {
            self.timeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-110, 10, 22, 22)];
            self.timeImgView.image = [UIImage imageNamed:@"time"];
            [self.contentView addSubview:self.timeImgView];
            self.timeImgView.centerY = self.ownerImgView.centerY;
        }
        //时间label
        if (!self.timeLabel) {
            self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.timeImgView.right, self.ownerImgView.top+2, 200, 25)];
            self.timeLabel.font = [UIFont systemFontOfSize:13];
            self.timeLabel.textColor = [UIColor grayColor];
            [self.contentView addSubview:self.timeLabel];
            self.timeLabel.centerY = self.ownerImgView.centerY;

        }
        
        //内容图片
        if (!self.contentImgView) {
            self.contentImgView = [[CustomImageView alloc] initWithFrame:CGRectMake(10, _ownerImgView.bottom+5, SCREEN_WIDTH-20, 25)];
            self.contentImgView.backgroundColor = [UIColor grayColor];
            [self.contentView addSubview:self.contentImgView];
        }
        
        //新闻标题
        if (!self.titleLabel) {
            self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.contentImgView.bottom+10, SCREEN_WIDTH-30, 0)];
            self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
            self.titleLabel.numberOfLines = 0;
            [self.contentView addSubview:self.titleLabel];
            self.titleLabel.textColor = RGBColor(51, 51, 51);
        }
        
        //新闻内容
        if (!self.contentLabel) {
            self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.titleLabel.bottom+10, SCREEN_WIDTH-30, 0)];
            self.contentLabel.font = [UIFont systemFontOfSize:15];
            self.contentLabel.numberOfLines = 0;
            [self.contentView addSubview:self.contentLabel];
            self.contentLabel.textColor = RGBColor(102, 102, 102);
        }

        
    }
    return self;
    
}
-(void)setActType:(NSString *)actType
{
    if (!actType) {
        return;
    }
    self.ownerImgView.image = [UIImage imageNamed:actType];
}
-(void)setCurModel:(ActionModel *)curModel
{
    _curModel = curModel;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    _ownerNameLabel.text = _curModel.classTyle;
    _timeLabel.text = _curModel.time;
    _titleLabel.text = _curModel.title;
    _titleLabel.height = [ActiveTableViewCell contentTitleHeightWithTweet:_curModel];
    _contentLabel.text = _curModel.content;
    _contentLabel.height = [ActiveTableViewCell contentLabelHeightWithTweet:_curModel];
    _contentImgView.height = [ActiveTableViewCell contentImageHeightWithTweet:_curModel];
    _titleLabel.top = _contentImgView.bottom+5;
    _contentLabel.top = _titleLabel.bottom+7;
    [self.contentImgView configureImageViwWithImageURL:[NSURL URLWithString:_curModel.image] animated:YES];


}
+(CGFloat)cellHeightWithObj:(id)obj
{
    ActionModel *tweet = (ActionModel *)obj;
    CGFloat cellHeight = 0;
    cellHeight += [self contentLabelHeightWithTweet:tweet];
    cellHeight += [self contentTitleHeightWithTweet:tweet];
    cellHeight += [self contentImageHeightWithTweet:tweet];

    cellHeight +=  67;
    return ceilf(cellHeight);

}
+(CGFloat)contentImageHeightWithTweet:(ActionModel *)tweet{
    
    if ([NSString isNotNull:tweet.image]) {
        
        return 180;
    }else{
        return 0;
        
    }
    
}
+ (CGFloat)contentTitleHeightWithTweet:(ActionModel *)tweet{
    CGFloat height = 0;
    if (tweet.title.length > 0) {
        height += MIN(120, [tweet.title getHeightWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(SCREEN_WIDTH-30, CGFLOAT_MAX)]);
        height += 10;
    }
    return height;
}
+ (CGFloat)contentLabelHeightWithTweet:(ActionModel *)tweet{
    CGFloat height = 0;
    if (tweet.content.length > 0) {
        height += MIN(55, [tweet.content getHeightWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(SCREEN_WIDTH-30, CGFLOAT_MAX)]);
        height += 10;
    }
    return height;
}
@end
