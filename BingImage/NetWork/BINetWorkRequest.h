//
//  BINetWorkRequest.h
//  BingImage
//
//  Created by 张声扬 on 2017/5/5.
//  Copyright © 2017年 张声扬. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^requestSeccessBlock)(id response);

typedef void (^requestFailureBlock)(NSError *error);

typedef void (^responseBlock)(id dataObj, NSError *error);

#ifdef DEBUG
#define BILog(...) NSLog(__VA_ARGS__)
#else
#define BILog(...)
#endif

@interface BINetWorkRequest : NSObject

+(void)getRequest:(NSString *)urlString params:(NSDictionary *)params success:(requestSeccessBlock)successHandle failure:(requestFailureBlock)failureHandle;

+(void)postRequest:(NSString *)urlString params:(NSDictionary *)params success:(requestSeccessBlock)successHandle failure:(requestFailureBlock)failureHandle;



@end
