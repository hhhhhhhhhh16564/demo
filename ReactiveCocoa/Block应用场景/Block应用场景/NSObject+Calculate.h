//
//  NSObject+Calculate.h
//  Block应用场景
//
//  Created by 周磊 on 16/7/29.
//  Copyright © 2016年 zhl. All rights reserved.

//  

#import <Foundation/Foundation.h>
#import "CalculteManager.h"

@interface NSObject (Calculate)
/*
 方法设计:自己框架,最好添加一个方法前缀
 */

// 把所有的计算代码放在这里
+(int)yb_makeCalculate:(void (^)(CalculteManager *)) block;




@end
