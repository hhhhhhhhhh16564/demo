//
//  YBDanmuView.m
//  12-弹幕框架
//
//  Created by yanbo on 17/8/8.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "YBDanmuView.h"
#import "CALayer+Animate.h"

@interface YBDanmuView()


@property(nonatomic, weak) NSTimer *timer;
@property(nonatomic, strong) NSMutableArray *laneWaitTimes;
@property(nonatomic, strong) NSMutableArray *laneLeftTimes;

//正在动画的 数组

@property (nonatomic, strong) NSMutableArray *danmuViews;

@property (nonatomic,assign) BOOL isAnimate;


@end



@implementation YBDanmuView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
    [self addGestureRecognizer:tap];
    
    self.layer.masksToBounds = YES;
    self.danDaoCount = 5;
    self.timerSes = 0.1;
    self.isAnimate = YES;
    
    return self;
}



#pragma mark -set get

-(NSMutableArray<id <YBDanmuModelProtocol>> *)models{
    
    if (!_models) {
        _models = [NSMutableArray array];
    }
        return _models;
}


-(NSTimer *)timer{
    if (!_timer) {
        NSTimer *timer = [NSTimer timerWithTimeInterval:self.timerSes target:self selector:@selector(checkAndBiu) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        
        _timer = timer;
    }
    return _timer;
}


- (NSMutableArray *)laneWaitTimes
{
    
    if (!_laneWaitTimes) {
        _laneWaitTimes = [NSMutableArray arrayWithCapacity:self.danDaoCount];
        for (int i = 0; i < self.danDaoCount; i++) {
            _laneWaitTimes[i] = @0.0;
        }
    }
    
    return _laneWaitTimes;
}




-(NSMutableArray *)laneLeftTimes{
    
    if (!_laneLeftTimes) {
        _laneLeftTimes = [NSMutableArray arrayWithCapacity:self.danDaoCount];
        
        for (int i = 0; i < self.danDaoCount; i++) {
            _laneLeftTimes[i] = @0.0;
        }
    }
    return _laneLeftTimes;
}

- (NSMutableArray *)danmuViews {
    if (!_danmuViews) {
        _danmuViews = [NSMutableArray array];
    }
    return _danmuViews;
}


#pragma makr -声明周期方法

-(void)didMoveToSuperview{
    [super didMoveToSuperview];
    [self timer];
    
    
}

-(void)click:(UITapGestureRecognizer *)tap{
    
    CGPoint point = [tap locationInView:self];
    
    for (UIView *danmuView in self.danmuViews) {
        
        CGRect frame = danmuView.layer.presentationLayer.frame;
        BOOL isContain = CGRectContainsPoint(frame, point);
        
        if (isContain) {
            if ([self.delegate respondsToSelector:@selector(danmuViewDidClick:at:)]) {
                [self.delegate danmuViewDidClick:danmuView at:point];
                break;
            }
            
            
        }
        
    }
    
    
    
}



-(void)checkAndBiu{
    
//    NSLog(@"%zd", self.models.count);

    
    // 每次检查前，需要修改 弹道的剩余时间和 等待时间
    
    for (int i = 0; i < self.danDaoCount; i++) {
        double waitTimeValue = [self.laneWaitTimes[i] doubleValue] - self.timerSes;
        
        if (waitTimeValue < 0.0) {
            waitTimeValue = 0;
        }
    
        self.laneWaitTimes[i] = @(waitTimeValue);
        
        
        double leftTimeValue = [self.laneWaitTimes[i]  doubleValue] - self.timerSes;
        if (leftTimeValue < 0.0) {
            leftTimeValue = 0.0;
        }
        self.laneLeftTimes[i] = @(leftTimeValue);
    }
    
    
    // 将弹幕模型按照开始时间时间排序
    [self.models sortUsingComparator:^NSComparisonResult(id<YBDanmuModelProtocol>  _Nonnull obj1, id<YBDanmuModelProtocol>  _Nonnull obj2) {
        //开始时间按照升序排列
        return [obj1 beginTime] > [obj2 beginTime];

    }];
    
    
 
// 检测数组里的所有模型，是否可以发射，如果可以，直接发射
    
    NSMutableArray *deleteModels = [NSMutableArray array];

    for (id<YBDanmuModelProtocol> model in self.models) {
        
        //1、检测是否已经到了发送时间

        // 如播放器的当前时间为5秒 ， 则开始时间是3秒的可以发射，开始时间是6秒的不能发射
        if ([model beginTime] > [self.delegate currentTime] ) {
            //如果前边的不满足条件，则后边也不满足
            
//            NSLog(@"%f", [self.delegate currentTime]);
            break;
        }
        
        
        
        //2、检测是否可以发送
        BOOL result = [self checkSend:model];
        
        if (result) {
            [deleteModels addObject:model];
        }
        

        
    }
    
    [self.models removeObjectsInArray:deleteModels];

}




-(BOOL)checkSend:(id<YBDanmuModelProtocol>)model{
    

    //弹道的宽度
    CGFloat danDaoHeight = self.frame.size.height/self.danDaoCount;

    // 遍历所有的弹道, 在每个弹道里面, 进行检测 (检测开始碰撞, 检测, 结束碰撞)

    for (int i = 0; i < self.danDaoCount; i++) {
        //1. 检测该弹道等待时间 是否到达
        NSTimeInterval waitTime = [self.laneWaitTimes[i] doubleValue];
        if (waitTime > 0) {
            continue;
        }

        //2.  绝对等待时间没有, 可以发射, 如果你发射了, 会不会, 与前面一个弹幕视图,产生碰撞
        NSTimeInterval leftTime = [self.laneLeftTimes[i] doubleValue];
        // 获取model对应的view
        UIView *modelView = [self.delegate danmuViewModle:model];
        //获取该View的速度
        double speed = (self.frame.size.width+modelView.frame.size.width)/[model liveTime];
        
        //计算在剩余时间内该View可以移动的距离，如果移动的距离小于 弹幕视图容器 的的宽度就可以发射
        
        double distance = speed * leftTime;
        
        if (distance > self.frame.size.width) {
            continue;
        }

        
        [self.danmuViews addObject:modelView];
        //3 到了这一步弹幕就可以发射了
   
        
        // 重置数据：修改该弹道的剩余时间 和 等待时间
        self.laneLeftTimes[i] = @([model liveTime]);
        self.laneWaitTimes[i] = @(modelView.frame.size.width/speed);
        
        
        CGRect frame = modelView.frame;
        //弹幕在该弹道高度居中
        CGPoint point = CGPointMake(self.frame.size.width, danDaoHeight * i+(danDaoHeight-modelView.frame.size.height)*0.5);
        frame.origin = point;
        modelView.frame = frame;
        
        [self addSubview:modelView];
        
        

        //动画
//        NSLog(@"%f", [model liveTime]);
        
        [UIView animateWithDuration:[model liveTime]  delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            CGRect frame = modelView.frame;
            frame.origin.x = -modelView.frame.size.width;
            modelView.frame = frame;
            
            
        } completion:^(BOOL finished) {
            
            [modelView removeFromSuperview];
            [self.danmuViews removeObject:modelView];
            
        }];
        
        return YES;

    }
    
    return NO;
}




-(void)pauseDanmuAnimate{
   
    if (self.isAnimate) {
        [self.timer setFireDate:[NSDate distantFuture]];
        [[self.danmuViews valueForKeyPath:@"layer"] makeObjectsPerformSelector:@selector(pauseAnimate)];
        self.isAnimate = !self.isAnimate;
        
    }
    

    
    
}

-(void)resumeDanmuAnimate{

    if (!self.isAnimate) {
        [self.timer setFireDate:[NSDate distantPast]];
        [[self.danmuViews valueForKeyPath:@"layer"] makeObjectsPerformSelector:@selector(resumeAnimate)];
        self.isAnimate = !self.isAnimate;

    }
  
}






















@end
