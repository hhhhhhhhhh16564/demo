//
//  XMGSqliteModelToolTest.m
//  sqlite封装
//
//  Created by 王顺子 on 17/2/4.
//  Copyright © 2017年 xmg. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XMGSqliteModelTool.h"
#import "XMGStu.h"

@interface XMGSqliteModelToolTest : XCTestCase

@end

@implementation XMGSqliteModelToolTest


/**
 测试创建表格
 */
- (void)testCreateTable {
    BOOL result = [XMGSqliteModelTool createTable:[XMGStu class] uid:nil];
    XCTAssertTrue(result);
}

/**
 测试是否需要更新
 */
- (void)testRequiredUpdate {
    BOOL isUpdate = [XMGSqliteModelTool isTableRequiredUpdate:[XMGStu class] uid:nil];
    XCTAssertFalse(isUpdate);
}



- (void)testUpdateTable {
    BOOL update = [XMGSqliteModelTool updateTable:[XMGStu class] uid:nil];
    XCTAssertTrue(update);
}


- (void)testSaveModel {
    
    XMGStu *stu = [[XMGStu alloc] init];
    stu.stuNum = 1;
    stu.age2 = 99;
    stu.name = @"王二小2";
    stu.score = 999;
    
    [XMGSqliteModelTool saveOrUpdateModel:stu uid:nil];
    
}
- (void)testDeleteModel {
    
    XMGStu *stu = [[XMGStu alloc] init];
    stu.stuNum = 1;
    stu.age2 = 99;
    stu.name = @"王二小2";
    stu.score = 999;
    
    [XMGSqliteModelTool deleteModel:stu uid:nil];
    
}

- (void)testDeleteModelWhere {
    
    [XMGSqliteModelTool deleteModel:[XMGStu class] whereStr:@"score <= 4" uid:nil];
    
}

- (void)testDeleteModelWhere2 {
    
    [XMGSqliteModelTool deleteModel:[XMGStu class] columnName:@"name" relation:ColumnNameToValueRelationTypeEqual value:@444 uid:nil];
    
}

- (void)testQueryAllModels {
    
//    NSArray *array = [XMGSqliteModelTool queryAllModels:[XMGStu class] uid:nil];
//    NSLog(@"%@", array);
    
    NSArray *results = [XMGSqliteModelTool queryModels:[XMGStu class] columnName:@"name" relation:ColumnNameToValueRelationTypeEqual value:@"666" uid:nil];
    NSLog(@"%@", results);
    
    
}


@end
