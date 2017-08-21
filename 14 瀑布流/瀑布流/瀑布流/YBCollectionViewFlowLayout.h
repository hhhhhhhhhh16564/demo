//
//  YBCollectionViewFlowLayout.h
//  瀑布流
//
//  Created by yanbo on 17/8/18.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YBCollectionViewFlowLayout;



@protocol YBCollectionViewFlowLayoutDelegate <NSObject>
@required

-(CGFloat)itemHeightInWaterFlowLayout:(YBCollectionViewFlowLayout *)flowLayout atIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth;




@optional
// 共有多少列
-(NSInteger)columnCountInWaterFlowLayout:(YBCollectionViewFlowLayout *)flowLayout;

//行间距
-(CGFloat)rowMarginInWaterFlowLayout:(YBCollectionViewFlowLayout *)flowLayout;

//列间距
-(CGFloat)columnMarginInWaterFlowLayout:(YBCollectionViewFlowLayout *)flowLayout;

// 上下左右距离
-(UIEdgeInsets)edgeInWaterFlowLayout:(YBCollectionViewFlowLayout *)flowLayout;



@end

@interface YBCollectionViewFlowLayout : UICollectionViewLayout

@property(nonatomic, weak) id<YBCollectionViewFlowLayoutDelegate> flowoutDelegate;


@end
