//
//  BICollectionViewLayout.h
//  BingImage
//
//  Created by 张声扬 on 2017/5/5.
//  Copyright © 2017年 张声扬. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BICollectionViewLayout;

@protocol BICollectionViewLayoutDelegate <NSObject>

@required
-(CGFloat)collectionLayout:(BICollectionViewLayout *)layout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;

@optional
- (CGFloat)columnCountInWaterflowLayout:(BICollectionViewLayout *)waterflowLayout;
- (CGFloat)columnMarginInWaterflowLayout:(BICollectionViewLayout *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(BICollectionViewLayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(BICollectionViewLayout *)waterflowLayout;

@end

@interface BICollectionViewLayout : UICollectionViewLayout

@property (nonatomic, weak) id <BICollectionViewLayoutDelegate> delegate;

@end
