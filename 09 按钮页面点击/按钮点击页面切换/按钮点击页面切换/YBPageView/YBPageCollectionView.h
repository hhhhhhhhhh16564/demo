//
//  YBPageCollectionView.h
//  按钮点击页面切换
//
//  Created by yanbo on 17/8/21.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBTitleStytle.h"
@interface YBPageCollectionView : UIView

-(instancetype)initWithFrame:(CGRect)frame titleStyle:(YBTitleStytle *)style titles:(NSArray *)titles isTitleTop:(BOOL)isTop layout:(UICollectionViewLayout *)layout;

@end
