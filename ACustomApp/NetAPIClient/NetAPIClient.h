//
//  NetAPIClient.h
//  Mantle
//
//  Created by 袁乐 on 15/10/13.
//  Copyright © 2015年 袁乐. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef enum {
    Get = 0,
    Post,
    Android,
    Online,
    WXSH
} NetworkMethod;

@interface NetAPIClient : AFHTTPRequestOperationManager

+ (id)sharedJsonClient;

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                       andBlock:(void (^)(id data, NSError *error))block;

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                  autoShowError:(BOOL)autoShowError
                       andBlock:(void (^)(id data, NSError *error))block;

- (void)requestUploadImageDataWithPath:(NSString *)aPath
                            withParams:(NSDictionary*)params
                         autoShowError:(BOOL)autoShowError
                              andBlock:(void (^)(id data, NSError *error))block;


@end
