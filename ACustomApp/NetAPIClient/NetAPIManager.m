//
//  NetAPIManager.m
//  Mantle
//
//  Created by 袁乐 on 15/10/13.
//  Copyright © 2015年 袁乐. All rights reserved.
//

#import "NetAPIManager.h"
#import "NSString+Common.h"
//#import "SXTVBanner.h"
@implementation NetAPIManager

+ (instancetype)sharedManager {
    static NetAPIManager *shared_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
    });
    return shared_manager;
}
//获取首页所有数据
-(void)getBannerImageWithJson:(NSDictionary *)json andBlock:(BaseResultBlock)block
{
    NSString *path = @"phone&name=snrtv&path=node_71966";
    
    [[NetAPIClient sharedJsonClient] requestJsonDataWithPath:path withParams:nil withMethodType:Get autoShowError:NO andBlock:^(id data, NSError *error) {
        if (data) {
            
            block(data, nil);
            
        }else{
            block(nil, error);
        }
    }];
    
}

-(void)getShannxiDataListAndBlock:(BaseResultBlock)block
{
    NSString *path = @"phone&name=snrtv&path=node_72490";
    
    [[NetAPIClient sharedJsonClient] requestJsonDataWithPath:path withParams:nil withMethodType:Get autoShowError:NO andBlock:^(id data, NSError *error) {
        if (data) {
            
            block(data, nil);
            
        }else{
            block(nil, error);
        }
    }];
    
}
-(void)getQinQiangDataListWithPageIndex:(NSString *)pageIndex AndBlock:(BaseResultBlock)block
{
    NSString *path;
    if ([pageIndex isEqualToString:@"0"]) {
        path = @"phone&name=snrtv&path=node_72487";
    }else{
        path = [NSString stringWithFormat:@"phone&name=snrtv&path=node_72487&p=%@",pageIndex];
    }
    [[NetAPIClient sharedJsonClient] requestJsonDataWithPath:path withParams:nil withMethodType:Get autoShowError:NO andBlock:^(id data, NSError *error) {
        if (data) {
            
            block(data, nil);
            
        }else{
            block(nil, error);
        }
    }];
    
}
-(void)getSuixiDataListWithPageIndex:(NSString *)pageIndex AndBlock:(BaseResultBlock)block
{
    NSString *path;
    if ([pageIndex isEqualToString:@"0"]) {
        path = @"phone&name=snrtv&path=node_72488";
    }else{
        path = [NSString stringWithFormat:@"phone&name=snrtv&path=node_72488&p=%@",pageIndex];
    }
    
    [[NetAPIClient sharedJsonClient] requestJsonDataWithPath:path withParams:nil withMethodType:Get autoShowError:NO andBlock:^(id data, NSError *error) {
        if (data) {
            
            block(data, nil);
            
        }else{
            block(nil, error);
        }
    }];
    
}
//获取广播
-(void)getRedioClassWithtchannal:(NSString *)channel ButBlock:(BaseResultBlock)block
{
    NSString *path = channel;
    
    [[NetAPIClient sharedJsonClient] requestJsonDataWithPath:path withParams:nil withMethodType:Android autoShowError:NO andBlock:^(id data, NSError *error) {
        if (data) {
            
            block(data, nil);
            
        }else{
            block(nil, error);
        }
    }];
    
}
//获取电视
-(void)getOnlineClassWithtchannal:(NSString *)urlpath ButBlock:(BaseResultBlock)block
{
    NSString *path = urlpath;
    
    [[NetAPIClient sharedJsonClient] requestJsonDataWithPath:path withParams:nil withMethodType:Online autoShowError:NO andBlock:^(id data, NSError *error) {
        if (data) {
            
            block(data, nil);
            
        }else{
            block(nil, error);
        }
    }];
    
}
//获取相关推荐
-(void)getXiangGuanTuijianDataListAndBlock:(BaseResultBlock)block
{
    NSString *path = @"phone&name=snrtv&path=node_10000";
    
    [[NetAPIClient sharedJsonClient] requestJsonDataWithPath:path withParams:nil withMethodType:Get autoShowError:NO andBlock:^(id data, NSError *error) {
        if (data) {
            
            block(data, nil);
            
        }else{
            block(nil, error);
        }
    }];
    
}
-(void)getHotDataListWithPageIndex:(NSString *)pageIndex AndBlock:(BaseResultBlock)block
{
    NSString *path;
    if ([pageIndex isEqualToString:@"0"]) {
        path = @"phone&name=snrtv&path=node_72489";
    }else{
        path = [NSString stringWithFormat:@"phone&name=snrtv&path=node_72489&p=%@",pageIndex];
    }
    
    [[NetAPIClient sharedJsonClient] requestJsonDataWithPath:path withParams:nil withMethodType:Get autoShowError:NO andBlock:^(id data, NSError *error) {
        if (data) {
            
            block(data, nil);
            
        }else{
            block(nil, error);
        }
    }];
    
}
//获取navagation右上角按钮数据
-(void)getUnderListWithClassId:(NSString *)classId AndPageIndex:(NSString *)pageIndex AndBlock:(void (^)(id, NSError *))block
{
    NSString *path;
    
    if (!classId) {
        block(nil, nil);
        return;
        
    }else{
        path = [NSString stringWithFormat:@"phone&name=snrtv&path=node_%@&p=%@", classId,pageIndex];
        
    }
    
    [[NetAPIClient sharedJsonClient] requestJsonDataWithPath:path withParams:nil withMethodType:Get autoShowError:NO andBlock:^(id data, NSError *error) {
        if (data) {
            
            block(data, nil);
            
        }else{
            block(nil, error);
        }
    }];
}
- (void)registerServiceWithParamsDic:(NSDictionary *)params AndBlock:(BaseResultBlock)block
{
    NSString *path = @"WXSXService/RegisterService";
    NSString *jsonStr = [NSString JSONWithDictionary:params];
    NSString *strrr = [@"?json=" stringByAppendingString:jsonStr];
    NSString *urlPath = [path stringByAppendingString:strrr];
    
    [[NetAPIClient sharedJsonClient] requestJsonDataWithPath:urlPath withParams:nil withMethodType:WXSH autoShowError:NO andBlock:^(id data, NSError *error) {
        if (data) {
            
            block(data, nil);
            
        }else{
            block(nil, error);
        }
    }];
    
}
- (void)loginServiceWithParamsDic:(NSDictionary *)params AndBlock:(BaseResultBlock)block
{
    NSString *path = @"WXSXService/LoginService";
    
    NSString *jsonStr = [NSString JSONWithDictionary:params];
    NSString *strrr = [@"?json=" stringByAppendingString:jsonStr];
    NSString *urlPath = [path stringByAppendingString:strrr];
    [[NetAPIClient sharedJsonClient] requestJsonDataWithPath:urlPath withParams:nil withMethodType:WXSH autoShowError:NO andBlock:^(id data, NSError *error) {
        if (data) {
            
            block(data, nil);
            
        }else{
            block(nil, error);
        }
    }];
    
}
//修改用户信息
- (void)changeUserInfoWithParamsDic:(NSDictionary *)params AndBlock:(BaseResultBlock)block
{
    
    NSString *path = @"WXSXService/UpdateUserInfoService";
    NSString *jsonStr = [NSString JSONWithDictionary:params];
    NSString *strrr = [@"?json=" stringByAppendingString:jsonStr];
    NSString *urlPath = [path stringByAppendingString:strrr];
    
    [[NetAPIClient sharedJsonClient] requestJsonDataWithPath:urlPath withParams:nil withMethodType:WXSH autoShowError:NO andBlock:^(id data, NSError *error) {
        if (data) {
            
            block(data, nil);
            
        }else{
            block(nil, error);
        }
    }];
}
//找回密码
- (void)findPasswordWithParamsDic:(NSDictionary *)params AndBlock:(BaseResultBlock)block
{
    NSString *path = @"WXSXService/GetUserPasswordService";
    NSString *jsonStr = [NSString JSONWithDictionary:params];
    NSString *strrr = [@"?json=" stringByAppendingString:jsonStr];
    NSString *urlPath = [path stringByAppendingString:strrr];
    
    [[NetAPIClient sharedJsonClient] requestJsonDataWithPath:urlPath withParams:nil withMethodType:WXSH autoShowError:NO andBlock:^(id data, NSError *error) {
        if (data) {
            
            block(data, nil);
            
        }else{
            block(nil, error);
        }
    }];
    
}
- (void)request_UpdateUserIconImage:(UIImage *)image
                          andParams:(NSDictionary *)params
                       successBlock:(void (^)(id responseObj))success
                       failureBlock:(void (^)(NSError *error))failure
                      progerssBlock:(void (^)(CGFloat progressValue))progress
{
  
    NSString *path = @"http://cnwest.snbw.cn/WXSXService/UpdateUserInfoService";
    NSDictionary *param = @{@"json":params};
    
    [[NetAPIClient sharedJsonClient] requestUploadImageDataWithPath:path withParams:param autoShowError:YES andBlock:^(id data, NSError *error) {
        
        if (data) {
            success(data);
        }else{
            failure(error);
        }
        
       
    }];

}
//添加用户反馈信息
- (void)addReplyServiceWithParamsDic:(NSDictionary *)params AndBlock:(BaseResultBlock)block
{
    NSString *path = @"WXSXService/AddReplyService";
    NSString *jsonStr = [NSString JSONWithDictionary:params];
    NSString *strrr = [@"?json=" stringByAppendingString:jsonStr];
    NSString *urlPath = [path stringByAppendingString:strrr];
    
    [[NetAPIClient sharedJsonClient] requestJsonDataWithPath:urlPath withParams:nil withMethodType:WXSH autoShowError:NO andBlock:^(id data, NSError *error) {
        if (data) {
            
            block(data, nil);
            
        }else{
            block(nil, error);
        }
    }];
    
}

- (void)getDetailVCImageWithBackBlock:(BaseResultBlock)block
{
    
    NSString *urlPath = @"adpic";
    
    [[NetAPIClient sharedJsonClient] requestJsonDataWithPath:urlPath withParams:nil withMethodType:Get autoShowError:NO andBlock:^(id data, NSError *error) {
        if (data) {
            block(data, nil);
            
        }else{
            block(nil, error);
        }
    }];


}

@end
