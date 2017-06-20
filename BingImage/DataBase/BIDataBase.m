//
//  BIDataBase.m
//  BingImage
//
//  Created by 张声扬 on 2017/5/5.
//  Copyright © 2017年 张声扬. All rights reserved.
//

#import "BIDataBase.h"
#import <FMDatabase.h>
#import <MJExtension.h>
#import "BIImageModel.h"

static FMDatabase *_db;

/*
 title;
 attribute;
 imgDescription;
 copyright;
 copyrightlink;
 startdate;
 enddate;
 fullstartdate;
 url;
 urlbase;
 hsh;
 qiniu_url;
 longitude;
 latitude;
 city;
 country;
 thumbnail_pic;
 bmiddle_pic;
 original_pic;
 weibo;
 likes;
 views;
 downloads;
 */

@implementation BIDataBase

+(void)initialize {
    NSString *dbPath = [NSString stringWithFormat:@"%@/Library/Caches/Data.db",NSHomeDirectory()];
    _db = [FMDatabase databaseWithPath:dbPath];
    if ([_db open]) {
        BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_item (id integer PRIMARY KEY, title text NOT NULL, attribute text NOT NULL,description text NOT NULL,copyright text NOT NULL,copyrightlink text NOT NULL,startdate text NOT NULL,enddate text NOT NULL,fullstartdate text NOT NULL,url text NOT NULL,urlbase text NOT NULL,hsh text NOT NULL,qiniu_url text NOT NULL,longitude text NOT NULL,latitude text NOT NULL,city text NOT NULL,country text NOT NULL,thumbnail_pic text NOT NULL,bmiddle_pic text NOT NULL,original_pic text NOT NULL,weibo integer NOT NULL,likes integer NOT NULL,views integer NOT NULL,downloads integer NOT NULL)"];
        if (result) {
            NSLog(@"成功创表");
        } else {
            NSLog(@"创表失败");
        }
    }
}

+(void)saveItemDict:(NSDictionary *)itemDict  {
    
    //%ld,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%ld,%ld,%ld,%ld
    //(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
    
    
    BOOL isSuccess = [_db executeUpdate:@"INSERT INTO t_item (id, title,attribute,description,copyright,copyrightlink,startdate,enddate,fullstartdate,url,urlbase,hsh,qiniu_url,longitude,latitude,city,country,thumbnail_pic,bmiddle_pic,original_pic,weibo,likes,views,downloads) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",(NSInteger)itemDict[@"id"],itemDict[@"title"],itemDict[@"attribute"],itemDict[@"description"],itemDict[@"copyright"],itemDict[@"copyrightlink"],itemDict[@"startdate"],itemDict[@"enddate"],itemDict[@"fullstartdate"],itemDict[@"url"],itemDict[@"urlbase"],itemDict[@"hsh"],itemDict[@"qiniu_url"],itemDict[@"longitude"],itemDict[@"latitude"],itemDict[@"city"],itemDict[@"country"],itemDict[@"thumbnail_pic"],itemDict[@"bmiddle_pic"],itemDict[@"original_pic"],(NSInteger)itemDict[@"weibo"],(NSInteger)itemDict[@"likes"],(NSInteger)itemDict[@"views"],(NSInteger)itemDict[@"downloads"]];
    
    if (isSuccess) {
        NSLog(@"插入数据成功");
    }else {
        NSLog(@"插入数据失败");
    }
    
//    [_db executeQueryWithFormat:@"INSERT INTO t_item (id, title,attribute,description,copyright,copyrightlink,startdate,enddate,fullstartdate,url,urlbase,hsh,qiniu_url,longitude,latitude,city,country,thumbnail_pic,bmiddle_pic,original_pic,weibo,likes,views,downloads) VALUES (%ld,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%ld,%ld,%ld,%ld)",(NSInteger)itemDict[@"id"],itemDict[@"title"],itemDict[@"attribute"],itemDict[@"description"],itemDict[@"copyright"],itemDict[@"copyrightlink"],itemDict[@"startdate"],itemDict[@"enddate"],itemDict[@"fullstartdate"],itemDict[@"url"],itemDict[@"urlbase"],itemDict[@"hsh"],itemDict[@"qiniu_url"],itemDict[@"longitude"],itemDict[@"latitude"],itemDict[@"city"],itemDict[@"country"],itemDict[@"thumbnail_pic"],itemDict[@"bmiddle_pic"],itemDict[@"original_pic"],(NSInteger)itemDict[@"weibo"],(NSInteger)itemDict[@"likes"],(NSInteger)itemDict[@"views"],(NSInteger)itemDict[@"downloads"]];
}

+ (NSArray *)list {
    
    FMResultSet *set = [_db executeQuery:@"SELECT * FROM t_item"];
    NSMutableArray *list = [NSMutableArray array];
    
    while (set.next) {
        // 获得当前所指向的数据
        
        NSData *dictData = [set objectForColumnName:@"itemDict"];
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:dictData];
        [list addObject:[BIImageModel mj_objectWithKeyValues:dict]];
    }
    return list;
}

+ (NSArray *)listWithRange:(NSRange)range {
    
    NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM t_item LIMIT %lu, %lu",range.location, range.length];
    FMResultSet *set = [_db executeQuery:SQL];
    NSMutableArray *list = [NSMutableArray array];
    
    while (set.next) {
        // 获得当前所指向的数据
        
        NSData *dictData = [set objectForColumnName:@"itemDict"];
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:dictData];
        [list addObject:[BIImageModel mj_objectWithKeyValues:dict]];
    }
    return list;
}

+ (BOOL)isExistWithId:(NSString *)idStr
{
    BOOL isExist = NO;
    
    FMResultSet *resultSet= [_db executeQuery:@"SELECT * FROM t_item where id = ?",idStr];
    while ([resultSet next]) {
        if([resultSet stringForColumn:@"id"]) {
            isExist = YES;
        }else{
            isExist = NO;
        }
    }
    return isExist;
}


@end
