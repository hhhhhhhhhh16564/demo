//
//  YBCollectionViewCell.h
//  瀑布流
//
//  Created by yanbo on 17/8/18.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBShop.h"
@interface YBCollectionViewCell : UICollectionViewCell


@property (weak, nonatomic) IBOutlet UIImageView *imv;
 
@property(nonatomic, strong) YBShop *shop;

@end
