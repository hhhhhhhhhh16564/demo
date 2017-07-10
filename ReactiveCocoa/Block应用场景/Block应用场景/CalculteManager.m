//
//  CalculteManager.m
//  Block应用场景
//
//  Created by 周磊 on 16/7/29.
//  Copyright © 2016年 zhl. All rights reserved.

//

#import "CalculteManager.h"

@implementation CalculteManager
-(CalculteManager * (^)(int))add{
    

    return ^ CalculteManager * (int b){
        
        _result = _result+b;
        
        return self;
        
    };

}

@end
