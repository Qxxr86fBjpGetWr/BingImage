//
//  ViewController.m
//  BingImage

//接口地址如下：
//https://github.com/xCss/bing

//
//  Created by 张声扬 on 2017/5/5.
//  Copyright © 2017年 张声扬. All rights reserved.
//

#import "ViewController.h"
#import "BIGetBingDataServer.h"
#import "BIImageModel.h"
#import "BIDataBase.h"
#import "BICollectionViewLayout.h"
#import "BICollectionViewCell.h"
#import "BIDetailViewController.h"
#import <MJRefresh.h>

static NSString * const BIShopId = @"BingImage";
static int pageIndex = 1;

@interface ViewController ()<BICollectionViewLayoutDelegate, UICollectionViewDataSource,UICollectionViewDelegate>

/** collectionView */
@property (nonatomic, weak) UICollectionView *collectionView;

/** 所有的图片数据  */
@property (nonatomic, strong)NSMutableArray *imageDataArray;

@end

@implementation ViewController

-(NSMutableArray *)imageDataArray {
    if (!_imageDataArray) {
        _imageDataArray = [NSMutableArray array];
    }
    return _imageDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigation];
    [self setupLayout];
    [self setupRefresh];

}

-(void)setupNavigation {
    
}

- (void)setupLayout {
    
    //创建布局
    BICollectionViewLayout *layout = [[BICollectionViewLayout alloc] init];
    layout.delegate = self;
    
    //创建collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    
    //注册
    [collectionView registerClass:[BICollectionViewCell class] forCellWithReuseIdentifier:BIShopId];
    
    self.collectionView = collectionView;
}

- (void)setupRefresh {
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.collectionView.mj_header beginRefreshing];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.collectionView.mj_footer.hidden = YES;
    
    
}

-(void)loadNewData {
    NSString *urlString = @"https://bing.ioliu.cn/v1?p=1&size=12";
    
    [BIGetBingDataServer postWithUrl:urlString params:nil modelClass:[BIImageModel class] responseBlock:^(id dataObj, NSError *error) {
        
        NSLog(@"%@",dataObj);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.imageDataArray removeAllObjects];
            [self.imageDataArray addObjectsFromArray:dataObj];
            
            //刷新数据
            [self.collectionView reloadData];
            [self.collectionView.mj_header endRefreshing];
            
        });
    }];
}

-(void)loadMoreData {
    
    pageIndex ++;
    
    NSString *urlString = [NSString stringWithFormat:@"https://bing.ioliu.cn/v1?p=%d&size=12",pageIndex];
    
    [BIGetBingDataServer postWithUrl:urlString params:nil modelClass:[BIImageModel class] responseBlock:^(id dataObj, NSError *error) {
        
        NSLog(@"%@",dataObj);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.imageDataArray addObjectsFromArray:dataObj];
            
            //刷新数据
            [self.collectionView reloadData];
            [self.collectionView.mj_footer endRefreshing];
            
        });
    }];
}

#pragma mark - <UICollectionViewDataSource> -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    self.collectionView.mj_footer.hidden = self.imageDataArray.count == 0;
    return self.imageDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BIShopId forIndexPath:indexPath];
    cell.contentView.layer.masksToBounds = YES;
    cell.imageData = self.imageDataArray[indexPath.item];
    
    return cell;
}

#pragma mark - <JGWaterflowLayoutDelegate> -
-(CGFloat)collectionLayout:(BICollectionViewLayout *)layout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth{
    
//    BIImageModel *shop = self.imageDataArray[index];
    return 350;
    
}

- (CGFloat)rowMarginInWaterflowLayout:(BICollectionViewLayout *)waterflowLayout {
    return 5;
}

- (CGFloat)columnCountInWaterflowLayout:(BICollectionViewLayout *)waterflowLayout {
    return 1;
}

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(BICollectionViewLayout *)waterflowLayout {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BIImageModel *imageData = self.imageDataArray[indexPath.row];
    BIDetailViewController *vc = [[BIDetailViewController alloc] init];
    vc.imageData = imageData;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
