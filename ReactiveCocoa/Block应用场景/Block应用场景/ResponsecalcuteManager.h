//
//  ResponsecalcuteManager.h
//  Block应用场景
//
//  Created by 周磊 on 16/7/29.
//  Copyright © 2016年 zhl. All rights reserved.


//   响应式编程思想

#import <Foundation/Foundation.h>

@interface ResponsecalcuteManager : NSObject
@property (nonatomic,assign) int result;

-(int)yb_MakeCalcute:(int (^)(int)) block;






















@end
