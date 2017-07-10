//
//  Person.m
//  runtime_1.0
//
//  Created by 周磊 on 16/7/26.
//  Copyright © 2016年 zhl. All rights reserved.
//

#import "Person.h"
#import <objc/message.h>

@interface Person ()

@property(nonatomic, strong) NSString *height;

@end

@implementation Person


- (void)eat
{
    NSLog(@"对象方法-吃东西");
}

+ (void)eat
{
    NSLog(@"类方法-吃东西");
}

- (void)run:(int)age
{
    NSLog(@"%d",age);
}

- (void)eat:(NSString *)str{
    
    NSLog(@"对象方法-带参数吃东西   参数是:%@",str);
    
    
}












// 默认一个方法都有两个参数,self,_cmd,隐式参数
// self:方法调用者
// _cmd:调用方法的编号

// 动态添加方法,首先实现这个resolveInstanceMethod
// resolveInstanceMethod调用:当调用了没有实现的方法没有实现就会调用resolveInstanceMethod
// resolveInstanceMethod作用:就知道哪些方法没有实现,从而动态添加方法
// sel:没有实现方法
//添加实例方法
+(BOOL)resolveInstanceMethod:(SEL)sel{
    
    if (sel == @selector(study:)) {
        // 动态添加eat方法
        // 第一个参数：给哪个类添加方法
        // 第二个参数：添加方法的方法编号
        // 第三个参数：添加方法的函数实现（函数地址）
        // 第四个参数：函数的类型，(返回值+参数类型)
        /**
         v:void
         @:对象->self 
         :表示SEL->_cmd
         如果后面有多个对象就用多个@
        
         其它编码类型
         c	A char
         i	An int
         s	A short
         l	A long
         l        is treated as a 32-bit quantity on 64-bit programs
         q	A long long
         C	An unsigned char
         I	An unsigned int
         S	An unsigned short
         L	An unsigned long
         Q	An unsigned long long
         f	A float
         d	A double
         B	A C++ bool or a C99 _Bool
         v	A void
         
         *	A character string (char *)
         @	An object (whether statically typed or typed id)
         #	A class object (Class)
         :	A method selector (SEL)
         [array type]  	An array 
         {name=type...} 	A structure 
         (name=type...) 	A union
           */

        //第四个参数参考下边的方法  返回值类型+ 参数类型
       class_addMethod([self class], sel, (IMP)aaaa, "v@:@@");
          //  下面的也可以，在类的方法中  self 等同于 [self class]
//        class_addMethod(self , sel, (IMP)aaaa, "v@:@@");

        return YES;
        
    }
    
    return [super resolveInstanceMethod:sel];
    
    
}



// 定义函数
// 没有返回值,参数(id,SEL)
// void(id,SEL)

void aaaa(id self, SEL _cmd, id param1, id parm2){
    
      NSLog(@"%@ %@  %@ %@", self, NSStringFromSelector(_cmd), param1, parm2);
    
}



//添加类方法
+(BOOL)resolveClassMethod:(SEL)sel{
    
    if (sel == @selector(study:)) {
        
        class_addMethod(object_getClass([self class]), sel, (IMP)bbbb, "v@:@@");
        //  下面的也可以，在类的方法中  self 等同于 [self class]
     //   class_addMethod(object_getClass(self), sel, (IMP)bbbb, "v@:@@");
        return YES;
        
    }
    
    return [super resolveClassMethod:sel];
    
}


//前两个是隐式参数

// 编码格式: 返回值类型+ 参数类型
//编码格式   void   编码  v
//            id   编码  @
//            SEL  编码  ：
//            id   编码  @
//            id   编码  @

void bbbb(id self, SEL _cmd, id param1, id parm2){
    
    NSLog(@"%@ %@  %@ %@", self, NSStringFromSelector(_cmd), param1, parm2);
    NSLog(@"哈哈哈哈哈哈哈哈");
    
}














@end
