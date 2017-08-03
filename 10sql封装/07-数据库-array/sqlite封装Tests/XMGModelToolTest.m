//
//  XMGModelToolTest.m
//  sqlite封装
//
//  Created by 小码哥 on 2017/1/15.
//  Copyright © 2017年 xmg. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XMGModelTool.h"
#import "XMGStu.h"

@interface XMGModelToolTest : XCTestCase

@end

@implementation XMGModelToolTest

- (void)testIvarNames {
    
    NSArray *ivarNames = [XMGModelTool allTableSortedIvarNames:[XMGStu class]];
    NSLog(@"%@", ivarNames);
    
}


@end
