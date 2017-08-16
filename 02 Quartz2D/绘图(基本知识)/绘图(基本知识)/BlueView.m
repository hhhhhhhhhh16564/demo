//
//  BlueView.m
//  绘图(基本知识)
//
//  Created by 周磊 on 16/8/9.
//  Copyright © 2016年 zhl. All rights reserved.
//

#import "BlueView.h"

@implementation BlueView



// 1.为什么代码要写在drawrect里面
// 因为只有在这个方法当中才能获取正确的上下文

// 2.drawrect方法中rect参数的含义是什么
// rect是当前view的bounds

// 3.drawrect什么时候调用
// 系统自动调用
// (1)当这个view第一次显示的时候调用
// (2)当重绘的时候调用

// 4.如何重绘
// view的setNeedsDisplay方法
// view的setNeedsDisplayInRect方法  rect参数是刷新指定的区域

// 5.为什么drawRect不要手动调用
// 因为系统调的时候是会确保创建view的上下文
// 手动调用的时候可能获取不到
- (void)drawRect:(CGRect)rect {
    
    
    [self patternText3];
    
    
}

#pragma mark 绘图方式

-(void)patternText1{
   
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 路径
    [path moveToPoint:CGPointMake(50, 50)];
    [path addLineToPoint:CGPointMake(150, 150)];
    [path addLineToPoint:CGPointMake(150, 50)];
//    [path closePath];

 
    // 线宽
    [path setLineWidth:20];
    
    [[UIColor redColor] setFill];  //设置填充颜色
    [[UIColor blueColor] setStroke];//设置边框颜色
    
    // 渲染
    [path stroke]; //边框渲染
    [path fill];  //实体填充

}



-(void)patternText2{
    
    UIBezierPath* path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(50, 50)];
    [path addLineToPoint:CGPointMake(100, 100)];
    [path addLineToPoint:CGPointMake(150, 50)];
    
    // 线宽
    [path setLineWidth:20];
    
    // 设置连接处的样式
    [path setLineJoinStyle:kCGLineJoinRound];
    
    // 设置头尾的样式
    [path setLineCapStyle:kCGLineCapRound];
    
    // 颜色
    [[UIColor redColor] setStroke];
    
    // 渲染
    [path stroke];

  
    
    
}



-(void)patternText3{
    
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //画三角形
    CGContextMoveToPoint(ctx, 50, 50);
    CGContextAddLineToPoint(ctx, 150, 150);
    CGContextAddLineToPoint(ctx, 150, 50);
    
    //从当前点连接到起始点
    CGContextClosePath(ctx);
    
    CGContextSetLineWidth(ctx, 20);
    
    [[UIColor blueColor] setStroke];
    [[UIColor redColor] setFill];
    
    
    // 渲染
    //    CGContextStrokePath(ctx); // 描边
    //    CGContextFillPath(ctx); // 填充
    
    //    CGContextDrawPath(ctx, kCGPathStroke); <=> CGContextStrokePath(ctx);
    //    CGContextDrawPath(ctx, kCGPathFill); <=> CGContextFillPath(ctx);
    
    // 既描边，又填充
    CGContextDrawPath(ctx, kCGPathFillStroke);
    

    
    
    
    
    
    
    
    
    
    
}

#pragma mark 画图的样式
-(void)stytleText1{
    //圆环
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150) radius:100 startAngle:0 endAngle:(2*M_PI) clockwise:YES];
    
    //线宽
    [path setLineWidth:20];
    
    [path stroke];
    
}

-(void)stytleText2{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    
    [path moveToPoint:CGPointMake(10, 10)];
    [path addLineToPoint:CGPointMake(250, 250)];
    [path addLineToPoint:CGPointMake(300, 0)];
   
    
    //线宽
    [path setLineWidth:20];
    
    //线连接处的样式
    [path setLineJoinStyle:(kCGLineJoinBevel)];
    
    //设置头尾的样式
    [path setLineCapStyle:kCGLineCapRound];
    
    //颜色
    [[UIColor redColor] setStroke];
    

    
    //渲染
    //表示关闭路径
     [path closePath];

    [path stroke];
    
    
    
    
    
}

-(void)stytleText3{
   
    //获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //画三角形
    CGContextMoveToPoint(ctx, 50, 50);
    
    CGContextAddLineToPoint(ctx, 150, 150);
    
    CGContextAddLineToPoint(ctx, 150, 50);
    
    //从当前点连接到起始点 关闭
    CGContextClosePath(ctx);
    
    //线宽
    CGContextSetLineWidth(ctx, 30);
    
    // 线宽
    CGContextSetLineWidth(ctx, 20);
    
    //    kCGLineJoinMiter, // 默认
    //    kCGLineJoinRound, // 圆角
    //    kCGLineJoinBevel // 切角
    // 设置连接处的样式
    CGContextSetLineJoin(ctx, kCGLineJoinBevel);
    
    
    
    
    
    //    kCGLineCapButt, // 默认
    //    kCGLineCapRound, // 圆角
    //    kCGLineCapSquare
    // 设置头尾的样式
    CGContextSetLineCap(ctx, kCGLineCapSquare);

    
    
    
    //设置颜色
//    CGContextSetRGBFillColor(ctx, 1, 0, 1, 1);
//    CGContextSetRGBStrokeColor(ctx, 1, 1, 0, 1);
    
    
    
    
    [[UIColor redColor] setStroke]; //设置边框颜色 ，对应边框填充
    
   [[UIColor greenColor] setFill];  //内部颜色  实习填充
    
    
//    [[UIColor blueColor] set];//既指实心填充，也值边框填充
    
    
    CGContextStrokePath(ctx); //边框填充 实心填充
    CGContextFillPath(ctx);
    
  
    
    
    
}

#pragma mark画图的步骤不同的方法

//画图的步骤
-(void)text{
    
    //获取图形上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    // 2.拼接路径   同时  把路径添加到上下文中
    
    
    
    //悬浮在图形的上下文的正上方，没落下
    CGContextMoveToPoint(ref, 0, 0);
    
    //落地开始划线
    CGContextAddLineToPoint(ref, 150, 150);
    CGContextAddLineToPoint(ref, 150, 300);
    
    
    //开始划线第二段(move to表示抬笔）
    CGContextMoveToPoint(ref, 300, 200);
    CGContextAddLineToPoint(ref, 100, 50);
    
    
    
    // 3.渲染
    CGContextStrokePath(ref);
  
    
    
}

#pragma mark 绘图的方式


//1. c语言的方式
-(void)text1{
    //1.获取图形上下文
    CGContextRef ctxx = UIGraphicsGetCurrentContext();
    
    
    //2.拼接路径 同时  把路径添加到上下文当中
    CGContextMoveToPoint(ctxx, 50, 50);
    CGContextAddLineToPoint(ctxx, 300, 300);
    
    //3. 渲染
    CGContextStrokePath(ctxx);
    
    
}

//2. c语言拼接的路径

-(void)text2{
//1. 获取图形上下文
    CGContextRef ctxx = UIGraphicsGetCurrentContext();
    
    //2.拼接路径
    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathMoveToPoint(path, NULL, 100, 100);
//    CGPathAddLineToPoint(path, NULL, 200, 200);
//    
    
    CGAffineTransform trans = CGAffineTransformMakeScale(1, 1);

    // path &tfans  x   y  半径  开始位置  结束位置 是否顺时针
    CGPathAddArc(path, &trans, 150, 150, 100, 0, M_PI, NO);
    
    
    
    //3.把路径添加到上下文当中
    CGContextAddPath(ctxx, path);
    
    //4. 渲染
    CGContextStrokePath(ctxx);
    
    

    
    
}

// 3. C+OC
-(void)text3{
    //获取图形上下文
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //拼接路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(50, 50)];
    [path addLineToPoint:CGPointMake(166, 233)];
     
     //把路径添加到图形上下文中
     CGContextAddPath(ctx, path.CGPath);
     
     //4. 渲染
    
    CGContextStrokePath(ctx);
    
    
    
    
    
}

//4. c+oc

-(void)text4{
   
    // 1. 获取图形上下文
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //2. 拼接路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 50, 50);
    CGPathAddLineToPoint(path, NULL, 100, 100);
    
    UIBezierPath *paht1 = [UIBezierPath bezierPath];
    [paht1 moveToPoint:CGPointMake(0, 0)];
    [paht1 addLineToPoint:CGPointMake(111, 273)];
    
    
    // 3.把路径添加到上下文当中
    CGContextAddPath(ctx, paht1.CGPath);
    CGContextAddPath(ctx, path);
    
    //4.渲染
    CGContextStrokePath(ctx);
    
}


// 5. oc
-(void)text5{
    
//     创建路径对象
        UIBezierPath* path = [[UIBezierPath alloc] init];
    // 拼接路径
    [path moveToPoint:CGPointMake(50, 50)];
    
    [path addLineToPoint:CGPointMake(100, 100)];
    
    //渲染
    [path stroke];
    
}


@end
