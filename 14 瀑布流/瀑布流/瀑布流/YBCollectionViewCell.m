//
//  YBCollectionViewCell.m
//  瀑布流
//
//  Created by yanbo on 17/8/18.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "YBCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation YBCollectionViewCell

-(void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}
-(void)setShop:(YBShop *)shop{
    
   
    _shop = shop;
    
//    NSLog(@"--------%@", shop.img);
    
    
    self.imv.backgroundColor =  [UIColor yellowColor];
    [self.imv sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    
}


@end
