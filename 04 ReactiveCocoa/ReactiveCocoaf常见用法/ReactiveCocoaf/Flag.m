//
//  Flag.m
//  ReactiveCocoaf
//
//  Created by 周磊 on 16/8/2.
//  Copyright © 2016年 zhl. All rights reserved.
//

#import "Flag.h"

@implementation Flag

+(instancetype)flagWithDic:(NSDictionary *)dict{
    
    Flag *flag = [[Flag alloc]init];
    
    [flag setValuesForKeysWithDictionary:dict];
    
    
    return flag;
    
}

@end
