//
//  Flag.h
//  ReactiveCocoaf
//
//  Created by 周磊 on 16/8/2.
//  Copyright © 2016年 zhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Flag : NSObject
@property(nonatomic, strong) NSString *name;

@property(nonatomic, strong) NSString *icon;

+(instancetype)flagWithDic:(NSDictionary *)dict;


@end
