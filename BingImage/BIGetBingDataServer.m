//
//  BIGetBingDataServer.m
//  BingImage
//
//  Created by 张声扬 on 2017/5/5.
//  Copyright © 2017年 张声扬. All rights reserved.
//

#import "BIGetBingDataServer.h"
#import <MJExtension.h>
#import "BIDataBase.h"

@implementation BIGetBingDataServer

+(id)modelTransformationWithResponseObj:(id)responseObj modelClass:(Class)modelClass {
    NSArray *lists = responseObj[@"data"];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in lists) {
        
        [modelClass mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{ @"ID" : @"id",@"descrip" : @"description"};
        }];
        [array addObject:[modelClass mj_objectWithKeyValues:dict]];
        
        //先判断数据是否存储过，如果没有，网络请求新数据存入数据库
        if (![BIDataBase isExistWithId:dict[@"id"]]) {
            //存数据库
            NSLog(@"存入数据库");
            [BIDataBase saveItemDict:dict];
        }
    }
    return array;
}

@end
