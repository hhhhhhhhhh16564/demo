//
//  RedView.m
//  绘图(基本知识)
//
//  Created by 周磊 on 16/8/9.
//  Copyright © 2016年 zhl. All rights reserved.
//

#import "RedView.h"

@implementation RedView




- (void)drawRect:(CGRect)rect {

    [self ruleText1];
}

#pragma mark 法则


// C 语言的填充法则

//奇偶填充法则
-(void)ruleText{
   
    // 1. 获取"图形上下文"
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIBezierPath* path = [UIBezierPath bezierPathWithRect:CGRectMake(100, 100, 200, 100)];
    
    UIBezierPath* path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(200, 150) radius:80 startAngle:0 endAngle:M_PI * 2 clockwise:1];
    
    UIBezierPath* path2 = [UIBezierPath bezierPathWithRect:CGRectMake(250, 30, 20, 200)];
    
    CGContextAddPath(ctx, path2.CGPath);
    CGContextAddPath(ctx, path1.CGPath);
    CGContextAddPath(ctx, path.CGPath);
    
    // 说明: 被覆盖过奇数次的点填充, 被覆盖过偶数次的点不填充
    
    // 奇填偶不填  填充样式是  kCGPathEOFill
    
    CGContextDrawPath(ctx, kCGPathEOFill);
    
}

//奇偶填充法则
// oc的填充法则，只要设置属性
-(void)ruleText1{
    
    UIBezierPath* path = [UIBezierPath bezierPathWithRect:CGRectMake(50, 50, 200, 200)];
    
    [path addArcWithCenter:CGPointMake(150, 150) radius:130 startAngle:0 endAngle:2 * M_PI clockwise:1];
   
    path.usesEvenOddFillRule = YES;
    [path fill];
    
}


// 非零环绕数规则
-(void)ruleText2{
    
    // 1. 获取"图形上下文"
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150) radius:100 startAngle:0 endAngle:M_PI * 2 clockwise:1];
    
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150) radius:50 startAngle:0 endAngle:M_PI * 2 clockwise:0];
    
    CGContextAddPath(ctx, path1.CGPath);
    CGContextAddPath(ctx, path.CGPath);
    
    // 默认填充模式: nonzero winding number rule(非零绕数规则)从左到右跨过, +1。从右到左跨过, -1。最后如果为0, 那么不填充, 否则填充
    CGContextDrawPath(ctx, kCGPathFill);
}

#pragma mark 不同图形的绘制方法
// 矩形
-(void)text1{
    
    //矩形
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(50, 50, 100, 100)];
    
    [path stroke];
    
    
}


//圆角矩形
-(void)text2{
    
    //圆角矩形
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(70, 70, 50, 150) cornerRadius:20];
    
    [path stroke];
    
}



-(void)text3{
    // 椭圆
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 10, 100, 100)];
//    
//    [path stroke];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextAddEllipseInRect(ctx, CGRectMake(50, 50, 150, 250));
    
    //边框填充
    CGContextStrokePath(ctx);
    
    
    //实心填充
//    CGContextFillPath(ctx);
    
    
}



-(void)text4{
    
    
   //画圆弧
    /**
 
     *  @param 150 圆形x
     *  @param 150 圆心y

       radius   半径
     startAngle 开始位置0
     endAngle   结束位置
     clockwise 是否顺时针
     
     *  @return 路径
     */
//    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150) radius:100 startAngle:0 endAngle:M_PI clockwise:YES];
//    
//    [path stroke];
    
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextAddArc(ctx, 150, 150, 100, 0, M_PI*1.5, YES);
    
//  CGContextAddLineToPoint(ctx, 150, 150);
    
    CGContextStrokePath(ctx);
    
    
    
}
















-(void)text5{
    
    
    
}





























@end
