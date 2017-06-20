//
//  BICollectionViewCell.m
//  BingImage
//
//  Created by 张声扬 on 2017/5/5.
//  Copyright © 2017年 张声扬. All rights reserved.
//

#import "BICollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface BICollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation BICollectionViewCell

-(void)setImageData:(BIImageModel *)imageData {
    
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageData.bmiddle_pic] placeholderImage:[UIImage imageNamed:@"loading"]];
    
}

-(void)layoutSubviews {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    imageView.backgroundColor = [UIColor grayColor];
    imageView.layer.cornerRadius = 5;
    imageView.layer.masksToBounds = YES;
    self.imageView = imageView;
    [self.contentView addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 20)];
    [self.contentView addSubview:label];

}

@end
