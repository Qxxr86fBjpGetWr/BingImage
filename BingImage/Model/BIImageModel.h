//
//  BIImageModel.h
//  BingImage
//
//  Created by 张声扬 on 2017/5/5.
//  Copyright © 2017年 张声扬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BIImageModel : NSObject
/**
 图片ID
 */
@property (nonatomic, strong) NSNumber *ID;
/**
 标题
 */
@property (nonatomic, copy) NSString *title;
/**
 图片属性 （中国，成都）
 */
@property (nonatomic, copy) NSString *attribute;
/**
 图片简介
 */
@property (nonatomic, copy) NSString *descrip;
@property (nonatomic, copy) NSString *copyright;
@property (nonatomic, copy) NSString *copyrightlink;

/**
 开始时间
 */
@property (nonatomic, copy) NSString *startdate;

/**
 结束时间
 */
@property (nonatomic, copy) NSString *enddate;

/**
 完整时间
 */
@property (nonatomic, copy) NSString *fullstartdate;

/**
 基本URL
 */
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *urlbase;
@property (nonatomic, copy) NSString *hsh;
@property (nonatomic, copy) NSString *qiniu_url;

/**
 经纬度
 */
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *latitude;

/**
 城市
 */
@property (nonatomic, copy) NSString *city;

/**
 国家
 */
@property (nonatomic, copy) NSString *country;

/**
 缩略图URL
 */
@property (nonatomic, copy) NSString *thumbnail_pic;

/**
 中图URL
 */
@property (nonatomic, copy) NSString *bmiddle_pic;

/**
 原图URL
 */
@property (nonatomic, copy) NSString *original_pic;

/**
 微博数？
 */
@property (nonatomic, copy) NSNumber *weibo;

/**
 喜欢的数量
 */
@property (nonatomic, copy) NSNumber *likes;

/**
 看过的数量
 */
@property (nonatomic, copy) NSNumber *views;

/**
 下载的数量
 */
@property (nonatomic, copy) NSNumber *downloads;

@end
