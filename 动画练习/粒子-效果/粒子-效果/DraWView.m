//
//  DraWView.m
//  粒子效果
//
//  Created by yanbo on 17/8/16.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "DraWView.h"


@interface DraWView ()

@property(nonatomic, strong) UIBezierPath *path;

@property(nonatomic, strong) CALayer *animitionLayer;

@property (nonatomic,assign) NSUInteger count;


@end

@implementation DraWView

-(UIBezierPath *)path{
    
    if (!_path) {
        _path = [UIBezierPath bezierPath];
    }
    return _path;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self];
    
    [self.path setLineWidth:5];
    [self.path moveToPoint:point];
    
}


-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self];
    [self.path addLineToPoint:point];
    self.count++;

    [self setNeedsDisplay];
 
}


-(void)drawRect:(CGRect)rect{
    
    [self.path stroke];
}

-(void)clear{
    self.path = nil;
    self.count = 0;
    [self.animitionLayer removeFromSuperlayer];
    [self setNeedsDisplay];
}



-(void)start{
    CALayer *animlayer = [CALayer layer];
    animlayer.bounds = CGRectMake(0, 0, 20, 20);
    animlayer.cornerRadius = 10;
    animlayer.backgroundColor = [UIColor yellowColor].CGColor;
    
    self.animitionLayer = animlayer;
    
    
    
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    anim.path = [self.path CGPath];
    anim.duration = 2;
    anim.repeatCount = HUGE;
    [animlayer addAnimation:anim forKey:nil];
 
    
    CAReplicatorLayer *replicaLayer = [CAReplicatorLayer layer];
    [replicaLayer addSublayer:animlayer];
    replicaLayer.instanceCount = self.count;
    replicaLayer.instanceDelay = 0.2;
    replicaLayer.repeatCount = HUGE;
    [self.layer addSublayer:replicaLayer];
    
    
    
    
    
    
    
}








@end
