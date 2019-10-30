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

    [self text2];
    
}

#pragma mark  UIGraphicsBeginImageContextWithOptions获得的图形上下文可以写在drawRect之外


#pragma mark 从btmap中获取图片
-(void)text1{
    
    CGSize size  =  CGSizeMake(300,400);
    
//    UIGraphicsBeginImageContext(size);
    // 开启图片上下文
    
    /**
     *  第一个参数 大小
        第二个参数 是否不透明
        第三个参数 一个点几个像素，传0回根据系统自己配置
     */
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    //获取当前上下文（图文类型）
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //向图片类型的图形上下文中中画画
    CGContextAddArc(ctx,150, 150, 130, 0, 2*M_PI, 1);
    CGContextSetLineWidth(ctx, 20);
    [[UIColor redColor] setFill];
    [[UIColor greenColor] setStroke];
    
    
    //渲染
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    //从图片类型的图形上下文中获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图片类型的上下文
    UIGraphicsEndImageContext();
    
    NSData *data = UIImagePNGRepresentation(image);
    
    
    // atomically 线程安全的， 先写入内存, 然后写入文件
    [data writeToFile:@"/Users/julyonline/Desktop/未命名文件夹 5/2.png" atomically:YES];
    
}

#pragma mark 对图片进行裁剪，获取圆形图片
-(void)text2{
    
    //1. 获取图片
    UIImage *image = [UIImage imageNamed:@"2.jpg"];
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    
    //获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //获取圆心
    CGPoint arcCenter = CGPointMake(image.size.width * 0.5,  image.size.height * 0.5);
    
    //画出裁剪的形状
    CGContextAddArc(ctx, arcCenter.x, arcCenter.y, image.size.width/2, 0, 2*M_PI, 1);
    
    
    //裁剪显示的区域
    CGContextClip(ctx);
    
   //画图像
    [image drawAtPoint:CGPointZero];
    
    //获取 图形  图片/Users/julyonline/Desktop/未命名文件夹 5
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    

    UIGraphicsEndImageContext();
   
    NSData *data = UIImagePNGRepresentation(newImage);
    [data writeToFile:@"/Users/poyan/Desktop/11/4.png" atomically:YES];
    
    
    //保存图片到相册
    
    // Adds a photo to the saved photos album.  The optional completionSelector should have the form:
    //  - (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
    
//
//    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image: didFinishSavingWithError: contextInfo:), @"111") ;

}




- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    //        NSLog(@"save ok !!!!");
    NSLog(@"%@", contextInfo);
}

#pragma mark获取环形图片
-(void)text3{
   
    // 1. 图形上下文的大小
    CGFloat margin = 10;
    //获取图片
    UIImage *image = [UIImage imageNamed:@"2.jpg"];
    //获取大小
    CGSize ctxSize = CGSizeMake(image.size.width+2*margin, image.size.height+2*margin);
    
    //2. 开启图形上下文
    UIGraphicsBeginImageContextWithOptions(ctxSize, NO, 0);
    //3. 获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.圆心
    CGPoint arccenter = CGPointMake(ctxSize.width*0.5, ctxSize.height*0.5);
    
    //半径
    
    CGFloat radius = (ctxSize.width-margin)*0.5;
    
    
    //画圆环
    CGContextAddArc(ctx, arccenter.x, arccenter.y, radius, 0, 2*M_PI, 1);
    
    //设置线宽
    CGContextSetLineWidth(ctx, margin);
    [[UIColor redColor] setStroke];
    
    //渲染
    CGContextStrokePath(ctx);
    
    // 裁剪区域
    CGContextAddArc(ctx, arccenter.x, arccenter.y, image.size.width*0.5, 0, 2*M_PI, 1);
    
    
    CGContextClip(ctx);
    
    //画图
    [image drawAtPoint:CGPointMake(margin, margin)];
    
    //取出图片
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    NSData *data = UIImagePNGRepresentation(image);

    
    
    [data writeToFile:@"/Users/julyonline/Desktop/未命名文件夹 5/11.png" atomically:YES];
    
    
}



#pragma mark 图片水印
-(void)text4{
    
    
    UIImage *image = [UIImage imageNamed:@"33"];
    
    //1 、开启图片上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    
    // 2、绘制图片
    [image drawAtPoint:CGPointZero];
    
    //3、文字内容
    NSString *myString = @"美女";
    
    //画文字
    [myString drawAtPoint:CGPointZero withAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:30],
                                                       NSForegroundColorAttributeName : [UIColor greenColor]
                                                       
                                                       }];
    //图片内容
    
    
    UIImage *logoImage = [UIImage imageNamed:@"22"];
    [logoImage drawAtPoint:CGPointMake(image.size.width-250, image.size.height-100)];
    
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    NSData *data = UIImagePNGRepresentation(newImage);
  
    [data writeToFile:@"/Users/julyonline/Desktop/未命名文件夹 5/55.png" atomically:YES];

}


-(void)text5{

    
}


-(void)text6{
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //直接在某个范围内渲染(边框）
    CGContextStrokeRect(ctx, CGRectMake(50, 50, 100, 100));
    
    // 第二次渲染
    
    //设置渲染边框颜色
    CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1);
    //    [[UIColor blueColor] setStroke];  上面那句话等同于这一句
    CGContextSetLineWidth(ctx, 5);
    CGContextAddRect(ctx, CGRectMake(30, 30, 100, 100));
    CGContextStrokePath(ctx);
}


-(void)text7{
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    
    [[UIColor redColor] setFill];
    
    CGContextFillRect(ctx, CGRectMake(50, 50, 200, 200));
    
    
    
    [[UIColor clearColor] setFill];
    CGContextFillRect(ctx, CGRectMake(80, 80, 140, 140));
    
    
}


-(void)text8{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIBezierPath* path = [UIBezierPath bezierPathWithRect:CGRectMake(50, 50, 200, 200)];
    
    //    UIBezierPath* path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(200, 150) radius:80 startAngle:0 endAngle:M_PI * 2 clockwise:1];
    
    UIBezierPath* path2 = [UIBezierPath bezierPathWithRect:CGRectMake(80, 80, 140, 140)];
    
    CGContextAddPath(ctx, path2.CGPath);
    //    CGContextAddPath(ctx, path1.CGPath);
    CGContextAddPath(ctx, path.CGPath);
    
    
    
    CGContextSetRGBFillColor(ctx, 0, 0, 0, 0.4);
    
    // 说明: 被覆盖过奇数次的点填充, 被覆盖过偶数次的点不填充
    
    // 奇填偶不填  填充样式是  kCGPathEOFill
    CGContextDrawPath(ctx, kCGPathEOFill);
    
}

-(void)text9{
    
    
    
}


-(void)text10{
    
    
    
}



@end
