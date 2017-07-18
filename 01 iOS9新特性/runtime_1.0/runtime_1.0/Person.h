//
//  Person.h
//  runtime_1.0
//
//  Created by 周磊 on 16/7/26.
//  Copyright © 2016年 zhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    
    @private
    
    NSString * _idCard;
    
}
+ (void)eat;

- (void)run:(int)age;

- (void)eat;

- (void)eat:(NSString *)str;

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *sex;
@property(nonatomic, strong) NSString *age;
@property (nonatomic,assign) NSInteger weight;

@end
