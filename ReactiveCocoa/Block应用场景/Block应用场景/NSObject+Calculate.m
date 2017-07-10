//
//  NSObject+Calculate.m
//  Block应用场景
//
//  Created by 周磊 on 16/7/29.
//  Copyright © 2016年 zhl. All rights reserved.
//

#import "NSObject+Calculate.h"

@implementation NSObject (Calculate)

+(int)yb_makeCalculate:(void (^)(CalculteManager *))block{
    
    CalculteManager *manager = [[CalculteManager alloc]init];
    
    block(manager);
    
    
  
    
    return manager.result;
    
    
}

@end
