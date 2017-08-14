//
//  CALayer+Animate.m
//  12-弹幕框架
//
//  Created by yanbo on 17/8/14.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "CALayer+Animate.h"

@implementation CALayer (Animate)

-(void)pauseAnimate{
    CFTimeInterval pauseTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    
    self.speed = 0.0;
    self.timeOffset = pauseTime;
    
    
    
}

-(void)resumeAnimate{
    
    CFTimeInterval pauseTime = self.timeOffset;
    self.speed = 1.0;
    self.timeOffset = 0.0;
    self.beginTime = 0.0;
    

    CFTimeInterval timeSincePause = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pauseTime;
    self.beginTime = timeSincePause;
}

@end
