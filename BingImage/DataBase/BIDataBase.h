//
//  BIDataBase.h
//  BingImage
//
//  Created by 张声扬 on 2017/5/5.
//  Copyright © 2017年 张声扬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BIDataBase : NSObject

+ (void)saveItemDict:(NSDictionary *)itemDict;
+ (NSArray *)list;
+ (NSArray *)listWithRange:(NSRange)range;
+ (BOOL)isExistWithId:(NSString *)idStr;

@end
