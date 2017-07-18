//
//  NSObject+encoding.m
//  runtime_1.0
//
//  Created by 周磊 on 16/7/27.
//  Copyright © 2016年 zhl. All rights reserved.
//

#import "NSObject+encoding.h"
#import <objc/message.h>

@implementation NSObject (encoding)
//-(instancetype)initWithCoder:(NSCoder *)aDecoder{
//    
// unsigned int count = 0;
//    
// Ivar *ivar = class_copyIvarList([self class], &count);
//    
//    for (int i = 0; i < count; i++) {
//        
//        NSString *varname = [NSString stringWithUTF8String:ivar_getName(ivar[i])];
//    
//        id value = [aDecoder decodeObjectForKey:varname];
//        
//        [self setValue:value forKey:value];
//        
//    }
//    
//    
//    free(ivar);
//    
//    return self;
//    
//}
//
//-(void)encodeWithCoder:(NSCoder *)aCoder{
//    
//    unsigned int count = 0;
//    
//    Ivar *ivar = class_copyIvarList([self class], &count);
//    
//    for (int i = 0; i < count; i++) {
//        NSString *varname = [NSString stringWithUTF8String:ivar_getName(ivar[i])];
//        
//        id value = [self valueForKey:varname];
//        
//        [aCoder encodeObject:value forKey:varname];
//
//        
//    }
//    
//    free(ivar);
//    
//}



-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [self init];

    if (self) {
        
        unsigned int count = 0;
        Ivar *ivar = class_copyIvarList([self class], &count);
        
        for (int i = 0; i < count; i++) {
            NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar[0])];
            id value = [aDecoder decodeObjectForKey:ivarName];
            [self setValue:value forKey:ivarName];
            
        }
        
        free(ivar);
    }

    return self;
}


-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    unsigned int count = 0;
    Ivar *ivar = class_copyIvarList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        
        
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar[0])];
        
        id value = [self valueForKey:ivarName];
        
        [aCoder encodeObject:value forKey:ivarName];
        
        
    }
    

    
    
}












































@end
