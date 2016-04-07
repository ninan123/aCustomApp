//
//  NetAPIClient.m
//  Mantle
//
//  Created by 袁乐 on 15/10/13.
//  Copyright © 2015年 袁乐. All rights reserved.
//

#import "NetAPIClient.h"

#define kNetworkMethodName @[@"Get", @"Post", @"Android",@"Online",@"WXSH"]
#define DebugLog(s, ...) NSLog(@"%s(%d): %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])

#define BASEURL @"http://m.snrtv.com/v2015/api/index.php?m="

@implementation NetAPIClient

static  NetAPIClient *_sharedClient = nil;
static dispatch_once_t onceToken;

+ (NetAPIClient *)sharedJsonClient {
    dispatch_once(&onceToken, ^{
        _sharedClient = [[NetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
    });
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
    
    
    self.requestSerializer.stringEncoding = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingUTF8);
    self.requestSerializer.timeoutInterval = 15.f;
    [self.requestSerializer setHTTPShouldHandleCookies:NO];
    self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    [self.operationQueue setMaxConcurrentOperationCount:NSOperationQueueDefaultMaxConcurrentOperationCount];
    self.securityPolicy.allowInvalidCertificates = YES;
    
    return self;
}
- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                       andBlock:(void (^)(id data, NSError *error))block{
    [self requestJsonDataWithPath:aPath withParams:params withMethodType:method autoShowError:YES andBlock:block];
}
- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                  autoShowError:(BOOL)autoShowError
                       andBlock:(void (^)(id data, NSError *error))block{
    if (!aPath || aPath.length <= 0) {
        return;
    }
    //log请求数据
    NSLog(@"\n===========request===========\n%@\n%@:\n%@", kNetworkMethodName[method], aPath, params);
    aPath = [aPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //    发起请求
    switch (method) {
        case Get:{
            aPath = [NSString stringWithFormat:@"%@%@",BASEURL,aPath];
            self.responseSerializer = [AFJSONResponseSerializer serializer];

            [self GET:aPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);

                id error = [self handleResponse:responseObject autoShowError:autoShowError];
                if (error) {
                    block(responseObject, error);
                }else{
                    if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    }
                    block(responseObject, nil);
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                [NSObject showError:error];
                block(nil, error);


            }];
            
            break;}
        case Post:{
            self.responseSerializer = [AFJSONResponseSerializer serializer];

            aPath = [NSString stringWithFormat:@"%@%@",BASEURL,aPath];
            [self POST:aPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                id error = [self handleResponse:responseObject autoShowError:autoShowError];
                if (error) {
                    block(nil, error);
                }else{
                    block(responseObject, nil);
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                block(nil, error);
            }];
            break;}
        case Android:{
            self.responseSerializer = [AFHTTPResponseSerializer serializer];

            aPath = [NSString stringWithFormat:@"%@%@",@"http://m.snrtv.com/index.php?m=column&a=",aPath];
            
            [self GET:aPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];

                NSArray *array = [string componentsSeparatedByString:@"="]; //从字符A中分隔成2个元素的数组
                NSString *jsonString = [array[1] stringByReplacingOccurrencesOfString:@";" withString:@""];
                NSDictionary *dict = [NSDictionary DictionaryWithJSON:jsonString];
//                NSDictionary *idc = @{@"PlayList":dict};

                
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, dict);
//                id error = [self handleResponse:responseObject autoShowError:autoShowError];
//                if (error) {
//                    block(responseObject, error);
//                }else{
                block(dict, nil);

//                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                block(nil, error);

            }];
            break;
        }
        case Online:{
            self.responseSerializer = [AFHTTPResponseSerializer serializer];
            
            aPath = [NSString stringWithFormat:@"%@%@",@"http://app3.cnwest.com/api/snrtv/playlist/?channel=",aPath];
            
            [self GET:aPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];

                NSArray *array = [string componentsSeparatedByString:@"="]; //从字符A中分隔成2个元素的数组
                NSString *jsonString = [array[1] stringByReplacingOccurrencesOfString:@";" withString:@""];
                
                NSDictionary *dict;
                
                if ([jsonString rangeOfString:@"]"].location !=NSNotFound) {
                
                    NSString *jsonString1 = [jsonString stringByReplacingOccurrencesOfString:@"[" withString:@""];
                    NSString *jsonString2 = [jsonString1 stringByReplacingOccurrencesOfString:@"]" withString:@""];
                    NSString *jsonString3 = [jsonString2 substringToIndex:[jsonString2 length] - 1];
                    NSString *jsonString4 = [jsonString3 substringFromIndex:2];
                
                    NSArray *array111 = [jsonString4 componentsSeparatedByString:@"},{"]; //从字符A中分隔成2个元素的数组
                    dict = @{@"list":array111};
                    
                }else{
                    dict = [NSDictionary DictionaryWithJSON:jsonString];
      
                }
  
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, dict);
                //                id error = [self handleResponse:responseObject autoShowError:autoShowError];
                //                if (error) {
                //                    block(responseObject, error);
                //                }else{
                block(dict, nil);
                
                //                    }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, error);                block(nil, error);

            }];
            break;
            
            
        }
        case WXSH:{
            aPath = [NSString stringWithFormat:@"%@%@",@"http://cnwest.snbw.cn/",aPath];
            self.responseSerializer = [AFJSONResponseSerializer serializer];
            
            [self GET:aPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                
                id error = [self handleResponse:responseObject autoShowError:autoShowError];
                if (error) {
                    block(responseObject, error);
                }else{
                    if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    }
                    block(responseObject, nil);
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               DebugLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                [NSObject showError:error];
                block(nil, error);
                
            }];
            
            break;
        }

               default:
            break;
    }
    
}
- (void)requestUploadImageDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                  autoShowError:(BOOL)autoShowError
                       andBlock:(void (^)(id data, NSError *error))block{
    if (!aPath || aPath.length <= 0) {
        return;
    }
    [self POST:aPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
        id error = [self handleResponse:responseObject autoShowError:autoShowError];
        if (error) {
            block(nil, error);
        }else{
            block(responseObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //                DebugLog(@"\n===========response===========\n%@:\n%@", aPath, error);
        block(nil, error);
    }];
    
}
#pragma mark NetError
-(id)handleResponse:(id)responseJSON
{
    return [self handleResponse:responseJSON autoShowError:YES];
}
-(id)handleResponse:(id)responseJSON autoShowError:(BOOL)autoShowError
{
    NSError *error = nil;
    //code为非0值时，表示有错
    NSNumber *resultCode = [responseJSON valueForKeyPath:@"code"];
    
    if (resultCode.intValue != 0) {
        error = [NSError errorWithDomain:@"" code:resultCode.intValue userInfo:responseJSON];
        
        if (resultCode.intValue == 1000 || resultCode.intValue == 3207) {//用户未登录
          
        }else{
            if (autoShowError) {
                
            }
        }
    }
    return error;
}

//json解析


@end
