//
//  Person.m
//  Block应用场景
//
//  Created by 周磊 on 16/7/29.
//  Copyright © 2016年 zhl. All rights reserved.
//

#import "Person.h"

@implementation Person

-(void)eat:(void (^)())block{
    
    
    block();
    
}


-(void (^)(int))run{

    return ^(int meter){
        
        NSLog(@"跑了%d米",meter);
    };

}



@end
