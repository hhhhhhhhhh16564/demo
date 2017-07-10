//
//  CalculteManager.h
//  Block应用场景
//
//  Created by 周磊 on 16/7/29.
//  Copyright © 2016年 zhl. All rights reserved.
//  链式编程思想

#import <Foundation/Foundation.h>

@interface CalculteManager : NSObject

@property (nonatomic,assign) int result;

-(CalculteManager * (^)(int))add;

@end
