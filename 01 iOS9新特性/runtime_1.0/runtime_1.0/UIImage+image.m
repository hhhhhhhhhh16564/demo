//
//  UIImage+image.m
//  runtime_1.0
//
//  Created by 周磊 on 16/7/26.
//  Copyright © 2016年 zhl. All rights reserved.
//

#import "UIImage+image.h"

#import <objc/message.h>

@implementation UIImage (image)

+(void)load{
    Method methodA = class_getClassMethod([self class], @selector(yb_imageNamed:));
    Method methodB = class_getClassMethod([self class], @selector(imageNamed:));
    method_exchangeImplementations(methodA, methodB);
}
+(UIImage *)yb_imageNamed:(NSString *)imageName{
    // imageNamed:
    // 实现方法:底层调用xmg_imageNamed
    
    // 本质:交换两个方法的实现imageNamed和xmg_imageNamed方法
    // 调用imageNamed其实就是调用xmg_imageNamed
    // imageNamed加载图片,并不知道图片是否加载成功
    // 以后调用imageNamed的时候,就知道图片是否加载

    // Class:获取哪个类方法
    // SEL:获取方法编号,根据SEL就能去对应的类找方法
    UIImage *image = [UIImage yb_imageNamed:imageName];
    
    if (image == nil) {
        
        NSLog(@"加载image为空");
    }
    return image;
}














@end
