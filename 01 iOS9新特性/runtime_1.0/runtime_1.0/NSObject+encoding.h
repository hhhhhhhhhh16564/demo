//
//  NSObject+encoding.h
//  runtime_1.0
//
//  Created by 周磊 on 16/7/27.
//  Copyright © 2016年 zhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (encoding)<NSCoding>

-(void)encodeWithCoder:(NSCoder *)aCoder;

-(instancetype)initWithCoder:(NSCoder *)aDecoder;

@end
