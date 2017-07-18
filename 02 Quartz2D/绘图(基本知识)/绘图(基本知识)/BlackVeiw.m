//
//  BlackVeiw.m
//  绘图(基本知识)
//
//  Created by 周磊 on 16/8/9.
//  Copyright © 2016年 zhl. All rights reserved.
//

#import "BlackVeiw.h"

#import "Masonry.h"
#import "UIView+Extension.h"

@interface BlackVeiw ()

@property(nonatomic, strong) UILabel *label;

@end


@implementation BlackVeiw



- (void)drawRect:(CGRect)rect {
    
    [self text3];
    
}




#pragma mark 饼状图
-(void)text1{
    // Drawing code
    
    //    if(!(self.bounds.size.width == self.bounds.size.height)){
    //        // 报错
    ////        [NSException raise:@"你先看看你的宽高是不是一致再来用!!!!!!!" format:@"宽高不一致"];
    //
    //        NSException * ex = [NSException exceptionWithName:@"你先看看你的宽高是不是一致再来用!!!!!!!" reason:@"宽高不一致" userInfo:nil];
    //        [ex raise];
    //
    //    }
    
    NSArray* array = @[ @0.08,@0.12, @0.07,@0.01,@0.19,@0.13, @0.11,@0.19, @0.1 ];
    
    int bigaine = arc4random() % 314 +1 ;
    
    CGFloat start = 0;
    start = bigaine/100.0;
    
    
    CGFloat end = 0;
    
    for (int i = 0; i < array.count; i++) {
        
        end = 2 * M_PI * [array[i] floatValue] + start;
        // 画扇形
        UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:[self arcCenter] radius:MIN(self.bounds.size.height * 0.5, self.bounds.size.width * 0.5) - 20 startAngle:start endAngle:end clockwise:1];
        
        // 连接圆心
        [path addLineToPoint:[self arcCenter]];
        [[self randomColor] set];
        
        [path fill];
        
        start = end;
    }
    
}
- (CGPoint)arcCenter
{
    return CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
}

// 随机颜色
- (UIColor*)randomColor
{
    
    CGFloat r = arc4random() % 256 / 256.0;
    CGFloat g = arc4random() % 256 / 256.0;
    CGFloat b = arc4random() % 256 / 256.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

#pragma mark 饼状图
-(void)text2{
    
    
    
    // Drawing code
    
    //    if(!(self.bounds.size.width == self.bounds.size.height)){
    //        // 报错
    ////        [NSException raise:@"你先看看你的宽高是不是一致再来用!!!!!!!" format:@"宽高不一致"];
    //
    //        NSException * ex = [NSException exceptionWithName:@"你先看看你的宽高是不是一致再来用!!!!!!!" reason:@"宽高不一致" userInfo:nil];
    //        [ex raise];
    //
    //    }
    
    

    NSMutableArray *mutableArray = [NSMutableArray array];
    int result = 0;

    for (int i = 0; i < 300; i++) {
        
        int a = arc4random() % 100;
        
        result = result + a;
        
        [mutableArray addObject:[NSNumber numberWithInt:a]];
        
    }
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSNumber *number in mutableArray) {
        
        float a = [number intValue] / (result * 1.0);
        
        [array addObject:[NSNumber numberWithFloat:a]];
        
        
    }
  
    
//    NSArray *array = nil;
    
    
    int bigaine = arc4random() % 314 +1 ;
    
    CGFloat start = 0;
    start = bigaine/100.0;
    
    
    CGFloat end = 0;
    
    for (int i = 0; i < array.count; i++) {
        
        end = 2 * M_PI * [array[i] floatValue] + start;
        // 画扇形
        UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:[self arcCenter] radius:MIN(self.bounds.size.height * 0.5, self.bounds.size.width * 0.5) - 20 startAngle:start endAngle:end clockwise:1];
        
        // 连接圆心
        [path addLineToPoint:[self arcCenter]];
        [[self randomColor] set];
        
        [path fill];
        
        start = end;
    }

    
    
    
}

#pragma mark 柱状图
-(void)text3{
    
    NSArray *array = @[@4, @7, @9, @11, @15, @8, @8, @6];
    
    for (int i = 0; i < array.count; i++) {
        CGFloat w = 20;
        CGFloat h = self.bounds.size.height * [array[i] floatValue] / 15;
        CGFloat x = i * w * 2;
        CGFloat y = self.bounds.size.height - h;
        
        //创建路径对象
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(x, y, w, h)];
        
        //随机颜色
        [[self randomColor] set];
        
        //渲染
        [path fill];
        
    }
 
}


//进度条

-(void)text4{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150) radius:100 startAngle:-M_PI_2 endAngle:2*M_PI*_progressvalue-M_PI_2 clockwise:YES];
    
    [path addLineToPoint:CGPointMake(150, 150)];
    [path closePath];
    
    [[UIColor redColor] set];
    
    [path fill];
    
    
    
    
}

-(void)setFrame:(CGRect)frame{
    
    [super setFrame:frame];
    
    [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.mas_left).and.offset(self.width/2);
        make.centerY.mas_equalTo(self.mas_top).and.offset(self.height/2);
        
        
    }];

}

-(void)setProgressvalue:(float)progressvalue{
    
    _progressvalue = progressvalue;
    self.label.text = [NSString stringWithFormat:@"%.2f%%", self.progressvalue * 100];
    [self setNeedsDisplay];
    
    
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self setNeedsDisplay];
    
    
}




-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
  
    if (self) {
        
        UILabel *label = [[UILabel alloc]init];
        
       
        
        
        [self addSubview:label];
        
        self.label = label;
        
        
        
        
    }
    
    return self;
    
    
}















@end
