//
//  BIDataServer.h
//  BingImage
//
//  Created by 张声扬 on 2017/5/5.
//  Copyright © 2017年 张声扬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BINetWorkRequest.h"

@interface BIDataServer : NSObject

+(void)getWithUrl:(NSString *)url params:(NSDictionary *)params modelClass:(Class)modelClass responseBlock:(responseBlock)responseHandle;

+(void)postWithUrl:(NSString *)url params:(NSDictionary *)params modelClass:(Class)modelClass responseBlock:(responseBlock)responseHandle;

+ (id)modelTransformationWithResponseObj:(id)responseObj modelClass:(Class)modelClass;

@end
