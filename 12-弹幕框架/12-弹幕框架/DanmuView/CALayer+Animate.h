//
//  CALayer+Animate.h
//  12-弹幕框架
//
//  Created by yanbo on 17/8/14.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (Animate)
//暂停动画
-(void)pauseAnimate;


// 恢复动画
-(void)resumeAnimate;
@end
