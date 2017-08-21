//
//  YBPageCollectionView.m
//  按钮点击页面切换
//
//  Created by yanbo on 17/8/21.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "YBPageCollectionView.h"
#import "YBTitleView.h"
@interface YBPageCollectionView()
@property(nonatomic, strong) YBTitleStytle *style;
@property(nonatomic, strong) NSArray *titles;
@property(nonatomic, assign) BOOL  isTop;
@property(nonatomic, strong) UICollectionViewLayout *layout;


@property(nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic, strong) YBTitleView *titleView;

@property(nonatomic, strong) UIPageControl *pageControl;

@end


@implementation YBPageCollectionView

-(instancetype)initWithFrame:(CGRect)frame titleStyle:(YBTitleStytle *)style titles:(NSArray *)titles isTitleTop:(BOOL)isTop layout:(__kindof UICollectionViewLayout *)layout{
    
    self = [super initWithFrame:frame];
    self.style = style;
    self.titles = titles;
    self.isTop = isTop;
    self.layout = layout;
    
    [self setupUI];
    
    return self;
}



-(void)setupUI{
    
    self.isTop = NO;
    //1. titleView
    
    CGFloat titleY = self.isTop ? 0 : (self.bounds.size.height-self.style.titleHeight);
    
    CGRect titleFrame = CGRectMake(0, titleY, self.bounds.size.width, self.style.titleHeight);

    YBTitleView *titleView = [[YBTitleView alloc]initWithFrame:titleFrame style:self.style titles:self.titles];
    [self addSubview:titleView];
    self.titleView = titleView;
    
    NSLog(@"%f", titleY);
    
    
    //2. pageControl
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    CGFloat pageControlHeight = 20;
    CGFloat pageY = self.isTop ? self.bounds.size.height - pageControlHeight : self.bounds.size.height - self.style.titleHeight-pageControlHeight;
    pageControl.frame = CGRectMake(0, pageY, self.bounds.size.width, pageControlHeight);
    pageControl.enabled = NO;
    pageControl.numberOfPages = self.titles.count;
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    
  
    //3. collectionView
    CGFloat collectionY = self.isTop ? self.style.titleHeight : 0;
    CGRect collectionFrame = CGRectMake(0, collectionY, self.bounds.size.width, self.bounds.size.height-pageControlHeight-self.style.titleHeight);
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:collectionFrame collectionViewLayout:self.layout];
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    
    
    
    

    self.backgroundColor = [UIColor grayColor];
    
    self.titleView.backgroundColor = [UIColor yellowColor];
    self.collectionView.backgroundColor = [UIColor greenColor];
    self.pageControl.backgroundColor = [UIColor blueColor];
    
}




























@end
