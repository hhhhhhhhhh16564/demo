//
//  ResponsecalcuteManager.m
//  Block应用场景
//
//  Created by 周磊 on 16/7/29.
//  Copyright © 2016年 zhl. All rights reserved.
//

#import "ResponsecalcuteManager.h"

@implementation ResponsecalcuteManager





-(int)yb_MakeCalcute:(int (^)(int)) block{
    
    
  int aaa = block(_result);

//    
//    NSLog(@"计算结果是: %d", aaa);
    return aaa;
    
}

























@end
