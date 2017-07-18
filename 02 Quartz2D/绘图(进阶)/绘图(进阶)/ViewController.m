//
//  ViewController.m
//  绘图(进阶)
//
//  Created by 周磊 on 16/8/10.
//  Copyright © 2016年 zhl. All rights reserved.
//

#import "ViewController.h"
#import "BlueView.h"
#import "RedView.h"
#import "BlackVeiw.h"

@interface ViewController ()

@property(nonatomic, strong) UIView *chidlrenView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidLoad];
    
    //不能获得图形上下文
//     NSLog(@"%@", UIGraphicsGetCurrentContext());
    
//        BlueView *chidlrenView = [[BlueView alloc]init];
//        chidlrenView.frame = CGRectMake(50, 50, 300, 300);
//        chidlrenView.backgroundColor = [UIColor yellowColor];
//        [self.view addSubview:chidlrenView];
//    
//        self.chidlrenView = chidlrenView;

//        RedView *chidlrenView = [[RedView alloc]init];
//        chidlrenView.frame = CGRectMake(50, 150, 300, 300);
//        chidlrenView.backgroundColor = [UIColor yellowColor];
//        [self.view addSubview:chidlrenView];
//    
//        self.chidlrenView = chidlrenView;
    
    

//    BlackVeiw *chidlrenView = [[BlackVeiw alloc]init];
//    chidlrenView.frame = CGRectMake(50, 150, 300, 300);
//    chidlrenView.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:chidlrenView];
//    
//    self.chidlrenView = chidlrenView;
    
    
//    UIStepper 计步器//创建一个计步器
//    1.初始化
    //ValueChanged  点击是要用这种模式

    
    
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
  UIImage *iamge =  [self tex2];
    
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 170, 375, 500);
    [self.view addSubview:view];
    view.backgroundColor = [UIColor greenColor];
    
    
    
    
    
    
     view.backgroundColor = [UIColor colorWithPatternImage:iamge];
    return;
    
    
    
    
    //开启图片类型的图形上下文
    UIGraphicsBeginImageContext(CGSizeMake(200, 200));
    
    NSLog(@"%@", UIGraphicsGetCurrentContext());
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(ctx, 50, 50);
    CGContextAddLineToPoint(ctx, 100, 100);
    
    CGContextAddLineToPoint(ctx, 100, 150);
    CGContextSetLineWidth(ctx, 0.1);

    
    [[UIColor redColor] setFill];
//    [[UIColor greenColor] setStroke];
    
    
    //渲染
    CGContextDrawPath(ctx, kCGPathFillStroke);

    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    NSData *data = UIImagePNGRepresentation(image);
    
    [data writeToFile:@"/Users/julyonline/Desktop/study_YY.png" atomically:YES];
    
    //关闭
    UIGraphicsEndImageContext();
//
    
    NSLog(@"%@", UIGraphicsGetCurrentContext());

    
    
    
}

#pragma mark 屏幕截屏

-(void)text1{
    
    //开启图片上下文
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
    
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //控制器的view
    [self.view.layer renderInContext:ctx];
    
    //取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    //保存到相册
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    

}



-(UIImage *)tex2{
    
    //高  45+9
    //宽  20+18
    
    //开启图片类型的图形上下文
    UIGraphicsBeginImageContext(CGSizeMake(19, 27));

    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(ctx, 0, 4.5);
    CGContextAddLineToPoint(ctx, 10, 4.5);
    
    CGContextAddArc(ctx,14.5, 4.5, 4.5, -M_PI, 0, 0);
    
    CGContextAddLineToPoint(ctx, 19, 27);
    CGContextAddLineToPoint(ctx, 0, 27);
    CGContextSetLineWidth(ctx, 0.1);

    
    [[UIColor redColor] setFill];
    
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    NSData *data = UIImagePNGRepresentation(image);
    
    [data writeToFile:@"/Users/julyonline/Desktop/study_YY.png" atomically:YES];
    
    //关闭
    UIGraphicsEndImageContext();

    return image;
    
    
}


@end
