//
//  BINetWorkRequest.m
//  BingImage
//
//  Created by 张声扬 on 2017/5/5.
//  Copyright © 2017年 张声扬. All rights reserved.
//

#import "BINetWorkRequest.h"
#import <AFNetworking.h>

@implementation BINetWorkRequest

+(void)getRequest:(NSString *)urlString params:(NSDictionary *)params success:(requestSeccessBlock)successHandle failure:(requestFailureBlock)failureHandle {
    
    AFHTTPSessionManager *sessionManager = [self getSessionManager];
    [sessionManager GET:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandle(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureHandle(error);
    }];
    
}

+(void)postRequest:(NSString *)urlString params:(NSDictionary *)params success:(requestSeccessBlock)successHandle failure:(requestFailureBlock)failureHandle {
    AFHTTPSessionManager *sessionManager = [self getSessionManager];
    [sessionManager POST:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandle(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureHandle(error);
    }];
}


+(AFHTTPSessionManager *)getSessionManager {
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] init];
    [sessionManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    sessionManager.requestSerializer.timeoutInterval = 12.0;
    [sessionManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    return sessionManager;
}

@end
