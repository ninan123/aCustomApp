//
//  NetAPIManager.h
//  Mantle
//
//  Created by 袁乐 on 15/10/13.
//  Copyright © 2015年 袁乐. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetAPIClient.h"
//#import "User.h"
@interface NetAPIManager : NSObject

typedef void (^ BaseResultBlock)(id data, NSError *error);

+ (instancetype)sharedManager;

//获取首页banner图
-(void)getBannerImageWithJson:(NSDictionary *)json andBlock:(BaseResultBlock)block;

//获取详情页相关推荐
-(void)getXiangGuanTuijianDataListAndBlock:(BaseResultBlock)block;
//获取广播
-(void)getRedioClassWithtchannal:(NSString *)channel ButBlock:(BaseResultBlock)block;
//获取电视
-(void)getOnlineClassWithtchannal:(NSString *)urlpath ButBlock:(BaseResultBlock)block;

//获取陕西模块数据
-(void)getShannxiDataListAndBlock:(BaseResultBlock)block;
-(void)getQinQiangDataListWithPageIndex:(NSString *)pageIndex AndBlock:(BaseResultBlock)block;
-(void)getSuixiDataListWithPageIndex:(NSString *)pageIndex AndBlock:(BaseResultBlock)block;
-(void)getHotDataListWithPageIndex:(NSString *)pageIndex AndBlock:(BaseResultBlock)block;
//获取navagation右上角按钮数据
-(void)getUnderListWithClassId:(NSString *)classId AndPageIndex:(NSString *)pageIndex AndBlock:(BaseResultBlock)block;

//注册接口
- (void)registerServiceWithParamsDic:(NSDictionary *)params AndBlock:(BaseResultBlock)block;
//登录
- (void)loginServiceWithParamsDic:(NSDictionary *)params AndBlock:(BaseResultBlock)block;

//修改用户信息
- (void)changeUserInfoWithParamsDic:(NSDictionary *)params AndBlock:(BaseResultBlock)block;

//获取播放页广告图片
- (void)getDetailVCImageWithBackBlock:(BaseResultBlock)block;


//找回密码
- (void)findPasswordWithParamsDic:(NSDictionary *)params AndBlock:(BaseResultBlock)block;

//修改图像
- (void)request_UpdateUserIconImage:(UIImage *)image
                          andParams:(NSDictionary *)params
                       successBlock:(void (^)(id responseObj))success
                       failureBlock:(void (^)(NSError *error))failure
                      progerssBlock:(void (^)(CGFloat progressValue))progress;
- (void)addReplyServiceWithParamsDic:(NSDictionary *)params AndBlock:(BaseResultBlock)block;
@end
