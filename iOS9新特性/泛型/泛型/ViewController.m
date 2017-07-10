//
//  ViewController.m
//  泛型
//
//  Created by 周磊 on 16/7/26.
//  Copyright © 2016年 zhl. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "IOS.h"
#import "Jave.h"

@interface ViewController ()

@property(nonatomic, strong) NSMutableArray<NSString *> *array;
@end
/*
 泛型:限制类型
 
 泛型使用场景:
 1.在集合(数组,字典,NSSet)中使用泛型比较常见.
 2.当声明一个类,类里面的某些属性的类型不确定,这时候我们才使用泛型.
 
 泛型书写规范
 在类型后面定义泛型,NSMutableArray<UITouch *> *datas
 
 泛型修饰:
 只能修饰方法的调用.
 
 泛型好处:
 1.提高开发规范,减少程序员之间交流
 2.通过集合取出来对象,直接当做泛型对象使用,可以直接使用点语法
 
 
     __covariant(协变):用于泛型数据强转类型,可以向上强转,子类 可以转成 父类
     __contravariant(逆变):用于泛型数据强转类型,可以向下强转, 父类 可以 转成子类

 */
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //p1之后会iOS ，定以后, 给p1点语法赋值，就会有自动提示
   Person<IOS *> *p1 = [[Person alloc]init];
    p1.language = [[IOS alloc]init];

    
    
    //p2之后会 jave ，定以后, 给p2点语法赋值，就会有自动提示

    Person<Jave *> *p2 = [[Person alloc]init];
    p2.language = [[Jave alloc]init];
    
     //pp什么语言都会, 如果不指定类型，默认为ID类型，可以参考 NSMutableArray
    Person<Language *> *pp = [[Person alloc]init];
    pp.language = [[Language alloc]init];
    
//    __covariant(协变):用于泛型数据强转类型,可以向上强转,子类 可以转成 父类
//    __contravariant(逆变):用于泛型数据强转类型,可以向下强转, 父类 可以 转成子类

    
    pp = p1; //警告 声明时前边可以加上  __covariant 已经加上
    
    p1 = pp; //警告 声明时前边可以加上  __contravariant
    
    
    
    
    
    
 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}



























@end
