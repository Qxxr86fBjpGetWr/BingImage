//
//  BIDataServer.m
//  BingImage
//
//  Created by 张声扬 on 2017/5/5.
//  Copyright © 2017年 张声扬. All rights reserved.
//

#import "BIDataServer.h"

static id dataObj;

@implementation BIDataServer

+(void)getWithUrl:(NSString *)url params:(NSDictionary *)params modelClass:(Class)modelClass responseBlock:(responseBlock)responseHandle {
    [BINetWorkRequest getRequest:url params:params success:^(id response) {
        dataObj = [self modelTransformationWithResponseObj:response modelClass:modelClass];
        responseHandle(dataObj,nil);
        
    } failure:^(NSError *error) {
        responseHandle(nil,error);
    }];
}

+(void)postWithUrl:(NSString *)url params:(NSDictionary *)params modelClass:(Class)modelClass responseBlock:(responseBlock)responseHandle {
    [BINetWorkRequest postRequest:url params:params success:^(id response) {
        dataObj = [self modelTransformationWithResponseObj:response modelClass:modelClass];
        responseHandle(dataObj,nil);
    } failure:^(NSError *error) {
        responseHandle(nil,error);
    }];
}

+(id)modelTransformationWithResponseObj:(id)responseObj modelClass:(Class)modelClass {
    return nil;
}

@end
