//
//  BlueView.m
//  绘图(基本知识)
//
//  Created by 周磊 on 16/8/9.
//  Copyright © 2016年 zhl. All rights reserved.
//

#import "BlueView.h"

@implementation BlueView

-(void)drawRect:(CGRect)rect{
    
    
    [self text6];
    
}

#pragma mark 旋转、缩放、平移
-(void)text1{
    //1.获取当前图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //    CTM
    // Current graphics state's Transformation Matrix
    // 5.矩阵操作
    // 缩放
    //    CGFloat sx, x轴的缩放比例
    //    CGFloat sy  y轴的缩放比例
    
       CGContextScaleCTM(ctx, 0.5, 0.5);
    // 平移
    //    CGFloat tx,  x轴的偏移量
    //    CGFloat ty  y轴的偏移量
      CGContextTranslateCTM(ctx, 150, 150);
    
    // 旋转
    
    //旋转
    CGContextRotateCTM(ctx, 0);
    
    CGContextAddArc(ctx, 150, 150, 100, 0, M_PI, 1);
    
    CGContextAddLineToPoint(ctx, 300, 300);
    
    //设置线宽
    CGContextSetLineWidth(ctx, 20);
    
    //渲染
    CGContextStrokePath(ctx);
    
}

#pragma mark 图形上下文栈

//先进后出，后进先出
//     CGContextSaveGState(ctx) 入栈
//        CGContextRestoreGState(ctx); 出栈
//    绘制后，绘制前的信息还保存在当前的图形上下文中，并没有清除，下次绘制就会用到这个信息


-(void)text2{
    //获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //备份 （也就是让当前的上文入栈)
    CGContextSaveGState(ctx);
    
    //缩放
    CGContextScaleCTM(ctx, 0.5, 0.5);
    
    //备份 （此时，栈中有两个上下文
    CGContextSaveGState(ctx);
    
    //2. 拼接路径  同时  把路径添加到上下文中
    
    CGContextAddArc(ctx, 150, 150, 100, 0, 2*M_PI, 1);
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, 300, 300);
    
    // 3.设置线宽
    CGContextSetLineWidth(ctx, 20);
    
    //4、设置颜色
    [[UIColor redColor] set];
    
    //5、渲染
    CGContextStrokePath(ctx);
    
    CGContextRestoreGState(ctx);
    CGContextRestoreGState(ctx);
    
    
    //想用最原始的状态进行划线
    CGContextMoveToPoint(ctx, 300, 0);
    CGContextAddLineToPoint(ctx, 0, 300);
    
    
    CGContextStrokePath(ctx);
    
    
    
    
    
}

#pragma mark 内存管理

-(void)text3{
    
    // Drawing code
    
    // 1.获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2.拼接路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 50, 50);
    CGPathAddLineToPoint(path, NULL, 100, 100);
    
    // 3.把路径添加到上下文当中
    CGContextAddPath(ctx, path);
    
    // 4渲染
    CGContextStrokePath(ctx);
    
    // 释放
  
  //  CGPathRelease(path);
    
     CFRelease(path);
    
}


#pragma mark 绘制文字
-(void)text4{
    
    NSString *myString = @"北京欢迎你";
    
    NSShadow * s = [[NSShadow alloc]init];
    s.shadowBlurRadius = 0; //阴影模糊程度，越小越清晰
    s.shadowOffset = CGSizeMake(100, 100); //阴影偏移量
    s.shadowColor = [UIColor greenColor];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:30];
    dict[NSForegroundColorAttributeName] = [UIColor blueColor];
    dict[NSShadowAttributeName] = s;
    
    //设个属性必须设置，否则阴影就没有效果
    dict[NSUnderlineStyleAttributeName] = @1;

    
    [myString drawAtPoint:CGPointZero withAttributes:dict];
    
    //划到指定的区域
//    [myString drawInRect:self.bounds withAttributes:dict];
    

}

#pragma mark 绘制图片
-(void)text5{
    
    //绘制图片
    UIImage *image = [UIImage imageNamed:@"2.jpg"];
    
    
    //从指定的地点开始绘制
    //封装了获取图形上下文的操作
    [image drawAtPoint:CGPointMake(0, 0)];
    
    //  绘制到某一个区域
//    [image drawInRect:self.bounds];
    
    
    //平铺
//    [image drawAsPatternInRect:self.bounds];
    
    
    
}


#pragma mark 裁剪图片显示的区域
-(void)text6{
    // 获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextAddRect(ctx, CGRectMake(0, 0, 150, 150));
    CGContextAddRect(ctx, CGRectMake(150, 150, 150, 150));
    
    
    //填充  可以用这句话判断将来心事的区域
    CGContextFillPath(ctx);
    
    //裁剪
//    CGContextClip(ctx);
    
    UIImage *image = [UIImage imageNamed:@"2.jpg"];
    //绘制图片
    [image drawInRect:self.bounds];
    
}


-(void)text7{
 //之前的上下文都是layer的上下文
    
    //开启图片类型的上下文，并不需要在drawrect上获得
    UIGraphicsBeginImageContext(self.bounds.size);
    
    //获得当前的图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(ctx, 50, 50);
    CGContextAddLineToPoint(ctx, 100, 100);
    
    //渲染在图片类型的上下文中，所以view上不显示
    CGContextStrokePath(ctx);
    

    UIGraphicsEndImageContext();
//    NSLog(@"%@", ctx);

    
}

























@end
