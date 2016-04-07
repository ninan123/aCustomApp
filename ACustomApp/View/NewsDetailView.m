//
//  NewsDetailView.m
//  ACustomApp
//
//  Created by Apple on 16/4/1.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "NewsDetailView.h"
#import "CustomImageView.h"

@interface NewsDetailView ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *timeLabel,*contentLabel;
@property (strong, nonatomic) UILabel *ownerNameLabel;
@property (strong, nonatomic) UIImageView *ownerImgView,*timeImgView;
@property (strong, nonatomic) CustomImageView *contentImgView;
@property (strong, nonatomic) UIScrollView *rootScrollView;
@property (strong, nonatomic) UIView *lineView;

@end

@implementation NewsDetailView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configViews];
    }
    return self;
}
-(void)configViews
{
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 570)];
    _rootScrollView.backgroundColor = [UIColor clearColor];
    _rootScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 570);
    [self addSubview:_rootScrollView];

    //新闻标题
    if (!self.titleLabel) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH-30, 0)];
        self.titleLabel.font = BoldSystemFont(19);
        self.titleLabel.numberOfLines = 0;
        [_rootScrollView addSubview:self.titleLabel];
        self.titleLabel.textColor = RGBColor(51, 51, 51);
    }
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(10, self.titleLabel.bottom+10, SCREEN_WIDTH-20, 0.6)];
    _lineView.backgroundColor = [UIColor lightGrayColor];
    [_rootScrollView addSubview:_lineView];

    
    //头像
    if (!self.ownerImgView) {
        self.ownerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, _lineView.bottom+7, 25, 25)];
        self.ownerImgView.image = [UIImage imageNamed:@"cnwest"];
        [_rootScrollView addSubview:self.ownerImgView];
    }
    //类别
    if (!self.ownerNameLabel) {
        self.ownerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.ownerImgView.right+2, self.ownerImgView.top+5, 200, 25)];
        self.ownerNameLabel.font = [UIFont systemFontOfSize:14];
        self.ownerNameLabel.textColor = [UIColor grayColor];
        [_rootScrollView addSubview:self.ownerNameLabel];
        self.ownerNameLabel.centerY = self.ownerImgView.centerY;
    }
    //时间image
    if (!self.timeImgView) {
        self.timeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-110, 10, 22, 22)];
        self.timeImgView.image = [UIImage imageNamed:@"time"];
        [_rootScrollView addSubview:self.timeImgView];
        self.timeImgView.centerY = self.ownerImgView.centerY;
    }
    //时间label
    if (!self.timeLabel) {
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.timeImgView.right+3, self.ownerImgView.top+2, 200, 25)];
        self.timeLabel.font = [UIFont systemFontOfSize:13];
        self.timeLabel.textColor = [UIColor grayColor];
        [_rootScrollView addSubview:self.timeLabel];
        self.timeLabel.centerY = self.ownerImgView.centerY;
        
    }
    
    //内容图片
    if (!self.contentImgView) {
        self.contentImgView = [[CustomImageView alloc] initWithFrame:CGRectMake(10, _ownerImgView.bottom+5, SCREEN_WIDTH-20, 0)];
        self.contentImgView.backgroundColor = [UIColor grayColor];
        [_rootScrollView addSubview:self.contentImgView];
    }
    
    
    //新闻内容
    if (!self.contentLabel) {
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.titleLabel.bottom+10, SCREEN_WIDTH-30, 0)];
        self.contentLabel.font = [UIFont systemFontOfSize:16.5];
        self.contentLabel.numberOfLines = 0;
        [_rootScrollView addSubview:self.contentLabel];
        self.contentLabel.textColor = RGBColor(70, 70, 70);
    }

}
-(void)setCurModel:(ActionModel *)curModel
{
    CGFloat hei = [self heightForTitle:curModel];
    _titleLabel.height = hei;
    _lineView.top = _titleLabel.bottom+5;
    _ownerImgView.top = _lineView.bottom+5;
    _ownerNameLabel.centerY = _ownerImgView.centerY;
    _timeImgView.centerY = _ownerImgView.centerY;
    _timeLabel.centerY = _ownerImgView.centerY;
    CGFloat heii = [self heightForImage:curModel];
    _contentImgView.top = _ownerImgView.bottom+10;
    _contentImgView.height = heii;
    CGFloat heiii = [self heightForContent:curModel];
    _contentLabel.height = heiii;
    _contentLabel.top = _contentImgView.bottom+10;
    if (heii == 0) {
        _contentLabel.top = _contentImgView.bottom;
    }
    
    
    _titleLabel.text = curModel.title;
    _ownerNameLabel.text = curModel.classTyle;
    _timeLabel.text = curModel.time;
    [_contentImgView configureImageViwWithImageURL:[NSURL URLWithString:curModel.image] animated:YES];
    _contentLabel.text = curModel.content;
    
    
//    DLog(@"%f",_contentLabel.bottom);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_contentLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:4];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_contentLabel.text length])];
    _contentLabel.attributedText = attributedString;
    [_contentLabel sizeToFit];
//    DLog(@"哈哈%f",_contentLabel.bottom);

    _rootScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, _contentLabel.bottom+140);

}
-(CGFloat)heightForTitle:(ActionModel *)model
{
    CGFloat height = 0;
    if (model.title.length > 0) {
        height += MIN(120, [model.title getHeightWithFont:BoldSystemFont(19) constrainedToSize:CGSizeMake(SCREEN_WIDTH-30, CGFLOAT_MAX)]);
        height += 10;
    }
    return height;
    
}
-(CGFloat)heightForContent:(ActionModel *)model
{
    CGFloat height = 0;
    if (model.content.length > 0) {
        height += MIN(10000, [model.content getHeightWithFont:systemFont(16.5) constrainedToSize:CGSizeMake(SCREEN_WIDTH-30, CGFLOAT_MAX)]);
        height += 10;
    }
    return height;

}
-(CGFloat)heightForImage:(ActionModel *)model
{
    CGFloat height = 0;
    if (model.image.length > 3) {
       
        height = 180;
    }
    return height;
}
@end
