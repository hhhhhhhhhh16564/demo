//
//  ViewController.m
//  runtime_1.0
//
//  Created by 周磊 on 16/7/26.
//  Copyright © 2016年 zhl. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "NSObject+Objc.h"

// 使用运行时的第一步:导入<objc/message.h>
// 第二步:Build Setting -> 搜索msg -> 设置属性为No
#import <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Person *p = [[Person alloc]init];
    
    //可以加_ ，也可以不加
    [p setValue:@"哈哈哈哈" forKey:@"_name"];
    
//等于
    [p setValue:@"哈哈哈哈" forKey:@"name"];
    
    NSLog(@"%@",p.name);
    
    
   unsigned int count = 0;
    
 Ivar *ivar = class_copyIvarList([p class], &count);
   
    for (int i = 0; i < count; i++) {
        NSString *str = [NSString stringWithUTF8String:ivar_getName(ivar[i])];
        
        NSLog(@"%@", str);
        
        
    }
    
//拓展和私有的属性仍然可以访问到
    /**
     2016-08-01 09:42:37.590 runtime_1.0[9932:501719] _idCard
     2016-08-01 09:42:37.590 runtime_1.0[9932:501719] _name
     2016-08-01 09:42:37.591 runtime_1.0[9932:501719] _sex
     2016-08-01 09:42:37.591 runtime_1.0[9932:501719] _age
     2016-08-01 09:42:37.591 runtime_1.0[9932:501719] _weight
     2016-08-01 09:42:37.592 runtime_1.0[9932:501719] _height
     */
 
    [p eat];
    
   //打印结果:  对象方法-吃东西
    
    // OC:运行时机制,消息机制是运行时机制最重要的机制
    // 消息机制:任何方法调用,本质都是发送消息
    // SEL:方法编号,根据方法编号就可以找到对应方法实现
   [p performSelector:@selector(eat)];
    /**
     *  打印结果: 对象方法-吃东西
     */
    
   [p performSelector:@selector(eat:) withObject:@"哈哈哈"];
    //打印结果: 对象方法-带参数吃东西   参数是:哈哈哈
    
    
    // 运行时,发送消息,谁做事情就那谁
    // xcode5之后,苹果不建议使用底层方法
    // xcode5之后,使用运行时.
    
   objc_msgSend(p, @selector(eat));
    //打印结果:   对象方法-吃东西
    
    //发送消息  带参数
    objc_msgSend(p, @selector(run:), 100);
    // 打印结果:    100
    
    
    
    // 类名调用类方法,本质类名转换成类对象
    [Person eat];
    // 类方法-吃东西
    

    
    //类对象调用类方法 person是一个类，[person class] 创建一个类对象
    //和下面结果类似
    objc_msgSend([Person class], @selector(eat));
    //类方法-吃东西
    objc_msgSend([p class], @selector(eat));
    
    //类方法-吃东西
    


    
    
    
    
    
    
    

    NSString *str = NSStringFromClass([p class]);
    NSLog(@"%@", str);
//    打印结果  Person
    
    
     [UIImage imageNamed:@""];
    //打印结果:    加载image为空
    
    

    [p performSelector:@selector(study:) withObject:@"好好学习"];
    //    打印结果  <Person: 0x7fd74160bde0> study:  好好学习 好好学习
  

   [p performSelector:@selector(study:) withObject:@"好好学习" withObject:@"天天向上"];
    //    打印结果  <Person: 0x7fd250f97390> study:  好好学习 天天向上


    [Person performSelector:@selector(study:) withObject:@"好好学习" withObject:@"天天向上"];
    //    打印结果  Person study:  好好学习 天天向上  哈哈哈哈哈哈哈哈
    
 
     NSLog(@"\n\n\n\n\n\n\n\n\n\\n\n\n\n");
    
    NSObject *exo = [[NSObject alloc]init];
    exo.name = @"哈哈哈";
    exo.color = @"红色的";
    
    
    //打印结果都是  哈哈哈 哈哈哈，
    //而不是 哈哈哈 红色的
//    因为在对象的内部都是根据key去取值, 而在内部实现中，getter方法都是取name的值
    NSLog(@"%@ %@", exo.name, exo.color);

}



@end
