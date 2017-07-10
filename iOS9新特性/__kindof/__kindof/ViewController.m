//
//  ViewController.m
//  __kindof
//
//  Created by 周磊 on 16/7/26.
//  Copyright © 2016年 zhl. All rights reserved.
//

#import "ViewController.h"
#import "PerSon.h"
#import "SonPerson.h"

@interface ViewController ()

@end

@implementation ViewController

/*
 __kindof:表示当前类或者它子类
 
 __kindof书写格式:
 放在类型前面,表示修饰这个类型(__kindof Person *)
 
 __kindof  :在调用的时候,很清楚的知道返回类型
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // id坏处: 1.不能在编译的时候检查真实类型
    //         2.返回值,没有提示
    
    
    SonPerson *p1  =  [SonPerson person1];  //会出现警告
    
    SonPerson *p2 = [SonPerson person];  //不会出现警告
    
    NSLog(@"%@  %@", p1, p2);
 
    
    
    
    
    
    
   
    NSDictionary *dict = nil;
    
    
    [dict setValue:@"8" forKey:@"8"];
    
    
    NSMutableDictionary *dd = nil;
    

    
    
    
    
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
