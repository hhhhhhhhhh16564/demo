//
//  XMGStu.m
//  sqlite封装
//
//  Created by 小码哥 on 2017/1/15.
//  Copyright © 2017年 xmg. All rights reserved.
//

#import "XMGStu.h"

@implementation XMGStu

+ (NSString *)primaryKey {
    return @"stuNum";
}


+ (NSArray *)ignoreColumnNames {
    return @[@"score2", @"b"];
}

+ (NSDictionary *)newNameToOldNameDic {
    return @{@"age2": @"age"};
}

@end
