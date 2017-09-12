//
//  YBTitleClickView.h
//  按钮点击页面切换
//
//  Created by yanbo on 17/9/12.
//  Copyright © 2017年 zhl. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "YBTitleStytle.h"

#define RandomColor [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1]

@class YBTitleClickView;
@class YBContentView;
@protocol YBTitleClickViewDelegate <NSObject>

-(void)titleView:(YBTitleClickView *)titleView didSelectedIndex:(NSInteger)index;

@end

@interface YBTitleClickView : UIView
@property (nonatomic,weak) id<YBTitleClickViewDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame
                       style:(YBTitleStytle *)titleStyle
                      titles:(NSArray *)titleArray;



-(void)contetnView:(YBContentView *)contentView scrollProgress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex;

@end
