//
//  YBCollectionViewFlowLayout.m
//  瀑布流
//
//  Created by yanbo on 17/8/18.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "YBCollectionViewFlowLayout.h"

@interface YBCollectionViewFlowLayout ()
{
    NSInteger _columnCount;
    CGFloat  _columnMargin;
    CGFloat  _rowMargin;
    UIEdgeInsets _inset;
    CGFloat   _minHeight;
    
}



@property(nonatomic, strong) NSMutableArray *layoutAttributesArray;


@property(nonatomic, strong) NSMutableArray *heightsArray;

// 最短的一列
@property (nonatomic,assign) NSInteger minColoumnIndex;


//最长一列的高度
@property (nonatomic,assign) CGFloat maxColumnHeight;


@end


@implementation YBCollectionViewFlowLayout


-(NSMutableArray *)layoutAttributesArray{
    if (!_layoutAttributesArray) {
        _layoutAttributesArray = [NSMutableArray array];
    }
    return _layoutAttributesArray;
}
-(NSMutableArray *)heightsArray{
    if (!_heightsArray) {
        _heightsArray = [NSMutableArray array];
        for (int i = 0; i < _columnCount; i++) {
            [_heightsArray addObject:@0];
        }
        
        
    }
    return _heightsArray;
}

-(NSInteger)minColoumnIndex{
    
    _minColoumnIndex = 0;
    _minHeight = MAXFLOAT;
    [self.heightsArray enumerateObjectsUsingBlock:^(NSNumber *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (_minHeight > [obj floatValue]) {
            _minHeight = [obj floatValue];
            _minColoumnIndex = idx;
        }
    }];
    return _minColoumnIndex;
}




-(void)prepareLayout{

    [super prepareLayout];
    
    NSLog(@"初始化\n\n\n\n\n\n\n");
 
    [self setConfigDefaultValue];

    
    [self minColoumnIndex];

    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    //i 从self.layoutAttributesArray.count的个数开始算起, 可以避免当下拉刷新时重头开始计算
    for (NSInteger i = self.layoutAttributesArray.count; i < itemCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *layoutAttributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.layoutAttributesArray addObject:layoutAttributes];
    }
}


// 设置参数的配置值

-(void)setConfigDefaultValue{
    //1. 设置默认值
    
    //列的个数
    _columnCount = 3;
    
    //行间距
    _rowMargin = 10;
    
    // 列间距
    _columnMargin = 10;
    
    //边距
    _inset = UIEdgeInsetsMake(10, 10, 10, 10);

    // 通过参数修改值

    if ([self.flowoutDelegate respondsToSelector:@selector(columnCountInWaterFlowLayout:)]) {
        
        _columnCount = [self.flowoutDelegate columnCountInWaterFlowLayout:self];
    }

    if ([self.flowoutDelegate respondsToSelector:@selector(rowMarginInWaterFlowLayout:)]) {
        _rowMargin = [self.flowoutDelegate rowMarginInWaterFlowLayout:self];
    }
    
    if ([self.flowoutDelegate respondsToSelector:@selector(columnMarginInWaterFlowLayout:)]) {
        _columnMargin = [self.flowoutDelegate columnMarginInWaterFlowLayout:self];
    }
    
    if ([self.flowoutDelegate respondsToSelector:@selector(edgeInWaterFlowLayout:)]) {
        _inset = [self.flowoutDelegate edgeInWaterFlowLayout:self];
    }
    
    
}







-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"构建frame方法");
    
    UICollectionViewLayoutAttributes *layoutAttribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    
    [self minColoumnIndex];
    
    CGFloat collectionWidth = self.collectionView.bounds.size.width;
    
    
    CGFloat w = (collectionWidth-_inset.left-_inset.right-_columnMargin*(_columnCount-1))/_columnCount;
    CGFloat x = _inset.left + (w+_columnMargin)*_minColoumnIndex;
    CGFloat y = 0;
    
    //该列的第一个不需要加Margin
    if (_minHeight == 0) {
        y = _inset.top;
    }else{
        y = _minHeight + _rowMargin;
    }
    
    CGFloat h = 0;
    //设置itme的高度
    if ([self.flowoutDelegate respondsToSelector:@selector(itemHeightInWaterFlowLayout:atIndexPath:itemWidth:)]){
        h = [self.flowoutDelegate itemHeightInWaterFlowLayout:self atIndexPath:indexPath itemWidth:w];
    }else{
        NSAssert(0, @"请实现代理方法: itemHeightInWaterFlowLayout:atIndexPath:itemWidth");
    }
    
    CGRect rect  = CGRectMake(x, y, w, h);
    layoutAttribute.frame = rect;
    CGFloat changedColumnHeight = y+h;
    self.heightsArray[_minColoumnIndex] = @(changedColumnHeight);
    
    if (self.maxColumnHeight < changedColumnHeight) {
        self.maxColumnHeight = changedColumnHeight;
    }
    
    return layoutAttribute;
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    
    return self.layoutAttributesArray;
}


-(CGSize)collectionViewContentSize{
    
    
    return CGSizeMake(self.collectionView.frame.size.width, self.maxColumnHeight+_inset.bottom);
}






@end
