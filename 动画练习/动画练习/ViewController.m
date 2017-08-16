//
//  ViewController.m
//  Text
//
//  Created by yanbo on 17/8/15.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@property(nonatomic, strong) UIView *contentV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contentV = [[UIView alloc]init];
    self.contentV.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-30);
    self.contentV.backgroundColor = [UIColor grayColor];
    self.contentV.layer.contentsRect = CGRectMake(0, 0, 0.51, 0.51);

 
    [self.view addSubview:self.contentV];


    
//    self.contentV.frame = CGRectMake(10, 10, 50, 50);
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)start:(id)sender {
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self text4];
}

// text1
-(void)text1{

    
    
    //    添加音量震动条
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, self.contentV.bounds.size.height - 150, 30,       150);
    layer.backgroundColor = [[UIColor colorWithRed:255.0/255 green:0.1 blue:0.1 alpha:1] CGColor];
    
    layer.position = CGPointMake(0, self.contentV.bounds.size.height);
    layer.anchorPoint = CGPointMake(0, 1);

    //    添加动画.(缩放,只缩放y方向).
    //    创建动画对象
    CABasicAnimation *anim = [CABasicAnimation animation];
    //    设置属性值.
    anim.keyPath = @"transform.scale.y";
    anim.toValue = @0;
    anim.repeatCount = MAXFLOAT;
    
    anim.duration = 0.5;
    //    结束后执行逆动画
    anim.autoreverses = YES;
    
    
   
    
    CAReplicatorLayer *repL = [CAReplicatorLayer layer];
    [repL addSublayer:layer];
    repL.frame = self.contentV.bounds;
    //    复制9份出来.
    repL.instanceCount = 10;
    //    每一个形变,都是相对于它上一个复制出来的子层开始的.
    repL.instanceTransform = CATransform3DMakeTranslation(40, -20, 0);
    //    动画延时执行.
    repL.instanceDelay = 0.5;
    repL.instanceRedOffset = -0.1;
    repL.instanceBlueOffset = 0.1;
    repL.instanceGreenOffset = 0.1;
    
    //    要设置复制层的颜色,原始层的颜色要设为白色.
    repL.instanceColor = [UIColor whiteColor].CGColor;
    [self.contentV.layer addSublayer:repL];
    
    [layer addAnimation:anim forKey:nil];
}


-(void)text2{
 
    /*
     CAReplicatorLayer可以将自己的子图层复制指定的次数,并且复制体会保持被复制图层的各种基础属性以及动画
     基本属性
     
     instanceCount
     var instanceCount: Int
     拷贝图层的次数,包括其所有的子图层,默认值是1,也就是没有任何子图层被复制
     instanceDelay
     var instanceDelay: CFTimeInterval
     在短时间内的复制延时,一般用在动画上(支持动画的延时)
     instanceTransform
     var instanceTransform: CATransform3D
     复制图层在被创建时产生的和上一个复制图层的位移(位移的锚点时CAReplicatorlayer的中心点)
     preservesDepth
     var preservesDepth: Bool
     如果设置为YES,图层将保持于CATransformLayer类似的性质和相同的限制
     
     instanceColor
     var instanceColor: CGColor?
     设置多个复制图层的颜色,默认位白色
     instanceRedOffset
     var instanceRedOffset: Float
     设置每个复制图层相对上一个复制图层的红色偏移量
     instanceGreenOffset
     var instanceGreenOffset: Float
     设置每个复制图层相对上一个复制图层的绿色偏移量
     instanceBlueOffset
     var instanceBlueOffset: Float
     设置每个复制图层相对上一个复制图层的蓝色偏移量
     instanceAlphaOffset
     var instanceAlphaOffset: Float
     设置每个复制图层相对上一个复制图层的透明度偏移量
     
     
     
     速度控制函数(CAMediaTimingFunction)
     kCAMediaTimingFunctionLinear（线性）：匀速，给你一个相对静态的感觉
     kCAMediaTimingFunctionEaseIn（渐进）：动画缓慢进入，然后加速离开
     kCAMediaTimingFunctionEaseOut（渐出）：动画全速进入，然后减速的到达目的地
     kCAMediaTimingFunctionEaseInEaseOut（渐进渐出）：动画缓慢的进入，中间加速，然后减速的到达目的地。这个是默认的动画行为。
  */
    
    //图层
    CALayer *shapLayer = [CALayer layer];
    shapLayer.backgroundColor = [[UIColor redColor] CGColor];
    
    shapLayer.bounds = CGRectMake(0, 0, 20, 20);
    shapLayer.cornerRadius = 10;
    shapLayer.position = CGPointMake(self.view.frame.size.width/2, 300);
    
    //放大的动画
    
    CABasicAnimation *transformAnim = [CABasicAnimation animationWithKeyPath:@"transform"];

    CATransform3D form3d = CATransform3DMakeScale(10, 10, 1);
    NSValue *toVAlue = [NSValue valueWithCATransform3D:form3d];
    transformAnim.toValue = toVAlue;
    transformAnim.duration = 2;
    transformAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    // 透明度动画(其实也可以直接设置CAReplicatorLayer的instanceAlphaOffset来实现)
    
    CABasicAnimation *alphaAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnim.toValue = @0 ;
    alphaAnim.duration = 2;
    alphaAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
 
    CAAnimationGroup *goupAnim = [CAAnimationGroup animation];
    goupAnim.animations = @[transformAnim, alphaAnim];
    goupAnim.duration = 2;
    goupAnim.repeatCount = HUGE;
    [shapLayer addAnimation:goupAnim forKey:nil];
    
 
    
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    [replicatorLayer addSublayer:shapLayer];
    replicatorLayer.instanceCount = 3;
    replicatorLayer.instanceDelay = 0.3;
    
    [self.contentV.layer addSublayer:replicatorLayer];

}

-(void)text3{
//    如果fillMode=kCAFillModeForwards同时removedOnComletion=NO，那么在动画执行完毕后，图层会保持显示动画执行后的状态。但在实质上，图层的属性值还是动画执行前的初始值，并没有真正被改变。
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];;
    
    //动画在指定的路径里
    anim.keyPath = @"position";
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.duration = 2.0;
    anim.repeatCount = HUGE;
    
//    创建一个路径
    CGMutablePathRef path = CGPathCreateMutable();
//    路径的范围
    CGPathAddEllipseInRect(path, NULL, CGRectMake(100, 100, 200, 200));
//    添加路径
    anim.path = path;
//    释放路径(带Create的函数创建的对象都需要手动释放,否则会内存泄露)
    CGPathRelease(path);
//    添加到View的layer

    [self.contentV.layer addAnimation:anim forKey:nil];
    
  
    
}

-(void)text4{
    
    
    CALayer *shapeLayer = [CALayer layer];
    shapeLayer.backgroundColor = [[UIColor redColor] CGColor];
    shapeLayer.bounds = CGRectMake(0, 0, 20, 20);
    shapeLayer.cornerRadius = 10;
    shapeLayer.position = CGPointMake(self.view.frame.size.width/2, 300);
    
    
    
    
    
    //    创建一个路径
    CGMutablePathRef path = CGPathCreateMutable();
    //    路径的范围
    CGPathAddEllipseInRect(path, nil, CGRectMake(100, 0, 200, 200));
    
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
    keyAnimation.keyPath = @"position";
    keyAnimation.path = path;
    keyAnimation.repeatCount = HUGE;
    CGPathRelease(path);
    [shapeLayer addAnimation:keyAnimation forKey:nil];
    
 
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    [replicatorLayer addSublayer:shapeLayer];
    replicatorLayer.instanceColor = [UIColor whiteColor].CGColor;
    replicatorLayer.frame = CGRectMake(0, 100, self.view.bounds.size.width, 200);
    replicatorLayer.backgroundColor = [UIColor yellowColor].CGColor;
    replicatorLayer.instanceCount = 20;
    replicatorLayer.instanceDelay = 0.2;
    //透明度递减
//   replicatorLayer.instanceRedOffset = -(1.0/replicatorLayer.instanceCount);
    replicatorLayer.repeatCount = HUGE;
        [self.contentV.layer addSublayer:replicatorLayer];
    
    
}


-(void)text5{
    CALayer *shapLayer = [CALayer layer];
    shapLayer.backgroundColor = [[UIColor redColor] CGColor];
    
    shapLayer.bounds = CGRectMake(0, 0, 20, 20);
    shapLayer.cornerRadius = 2;
    shapLayer.position = CGPointMake(self.view.frame.size.width/2, 100);
    shapLayer.borderWidth = 1;
    shapLayer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1);
    
    
    CABasicAnimation *transformAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D form3d = CATransform3DMakeScale(1, 1, 1);
    NSValue *fromVAlue = [NSValue valueWithCATransform3D:form3d];
    NSValue *toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 0.1)];
    transformAnim.fromValue = fromVAlue;
    transformAnim.toValue = toValue;
    transformAnim.duration = 2;
    transformAnim.repeatCount = HUGE;

    [shapLayer addAnimation:transformAnim forKey:nil];
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(0, 100, self.view.bounds.size.width, 400);
    [replicatorLayer addSublayer:shapLayer];
    replicatorLayer.instanceCount = 20;
    replicatorLayer.instanceDelay = 0.1;
    // 旋转中心为replicatorLayer的中心点
    // 所以说旋转半径为：|400*0.5-100|
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(2 * M_PI / 20, 0, 0, 1.0);
    replicatorLayer.backgroundColor = [[UIColor greenColor] CGColor];

    [self.contentV.layer addSublayer:replicatorLayer];
    
    
//    UIView *yellView = [[UIView alloc]init];
//    yellView.backgroundColor = [UIColor yellowColor];
//    yellView.frame = CGRectMake(0, 0, 20, 20);
//    yellView.center = CGPointMake(self.view.frame.size.width/2, 300);
//    [self.view addSubview:yellView];
    
//    

 
    
    
}


-(void)text6{
    
    /*
     转场动画的类型（NSString *type）
     fade : 交叉淡化过渡
     push : 新视图把旧视图推出去
     moveIn: 新视图移到旧视图上面
     reveal: 将旧视图移开,显示下面的新视图
     cube : 立方体翻滚效果
     oglFlip : 上下左右翻转效果
     suckEffect : 收缩效果，如一块布被抽走
     rippleEffect: 水滴效果
     pageCurl : 向上翻页效果
     pageUnCurl : 向下翻页效果
     cameraIrisHollowOpen : 相机镜头打开效果
     cameraIrisHollowClos : 相机镜头关闭效果
     */
    
    CATransition *anim = [CATransition animation];
//    转场类型
    anim.type = @"cube";
//    动画执行时间
    anim.duration = 2;
    
          anim.startProgress = 0.5;
//    动画执行方向
    anim.subtype = kCATransitionFromLeft;
          anim.endProgress  =0.8;
    
//    添加到View的layer
    [self.contentV.layer addAnimation:anim forKey: nil];
    
    
}
//图片折叠
-(void)text7{
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
