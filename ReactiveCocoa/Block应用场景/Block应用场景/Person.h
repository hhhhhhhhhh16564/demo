//
//  Person.h
//  Block应用场景
//
//  Created by 周磊 on 16/7/29.
//  Copyright © 2016年 zhl. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^BlockName) ();

@interface Person : NSObject
// block:ARC使用strong,非ARC使用copy
// block类型:void(^)()

//参数block类型 void(^)()

@property (nonatomic, strong) void(^operation)();


// 参数类型 : block类型

-(void)eat:(void(^)()) block;

-(void(^)(int))run;

@end
