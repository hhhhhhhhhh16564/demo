//
//  Person.h
//  泛型
//
//  Created by 周磊 on 16/7/26.
//  Copyright © 2016年 zhl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Language.h"

//创建对象时，会将方法中所有的 objetType 改为指定的类型

@interface Person<__covariant ObjectType> : NSObject


@property(nonatomic, strong) ObjectType language;


/*
 id:任何对象都能传进来
 Language:在外面调用的时候,没有提示
 IOS* 以后只能传对象
 */
- (ObjectType)language;
- (void)setLanguage:(ObjectType)language;



@end
