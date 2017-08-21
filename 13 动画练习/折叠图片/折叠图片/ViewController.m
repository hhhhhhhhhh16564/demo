//
//  ViewController.m
//  折叠图片
//
//  Created by yanbo on 17/8/16.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic, strong) UIImageView *topView;
@property(nonatomic, strong) UIImageView *bootomView;

@property(nonatomic, strong) UIView *dragView;

@property (nonatomic, weak) CAGradientLayer *gradientL;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor greenColor];
    [self setUI];
}


-(void)setUI{
    
    
    self.dragView = [[UIView alloc]init];
    self.dragView.frame = CGRectMake(100, 100, 200, 200);
//    self.dragView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.dragView];
     // 添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.dragView addGestureRecognizer:pan];
    
    
//    搞两个控件，一个显示上半部分，一个显示下半部分，需要用到Layer(图层)的一个属性contentsRect,这个属性是可以控制图片显示的尺寸，可以让图片只显示上部分或者下部分，注意:取值范围是0~1.
    
    
   
    self.topView = [[UIImageView alloc]init];
    self.topView.backgroundColor = [UIColor whiteColor];
    self.topView.bounds = CGRectMake(0, 0, 200, 100);
    self.topView.layer.position = CGPointMake(100, 100);
    self.topView.image = [UIImage imageNamed:@"小新"];
    self.topView.layer.contentsRect = CGRectMake(0, 0, 1, 0.5);
    self.topView.layer.anchorPoint = CGPointMake(0.5, 1);

    
    self.bootomView = [[UIImageView alloc]init];
    self.bootomView.backgroundColor = [UIColor whiteColor];
    self.bootomView.bounds =CGRectMake(0, 0, 200, 100);
    self.bootomView.layer.position = CGPointMake(100, 100);
    self.bootomView.image = [UIImage imageNamed:@"小新"];
    self.bootomView.layer.anchorPoint = CGPointMake(0.5, 0);
    self.bootomView.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);
    
     //先添加下部图片,再添加上部图片，否则如果topView会在图层的更下边，翻转过来后会被bootomView遮盖
    [self.dragView addSubview:self.bootomView];
    [self.dragView addSubview:self.topView];
    
    //渐变图层
    CAGradientLayer *gradientL = [CAGradientLayer layer];
    
    //注意图层需要设置尺寸
    gradientL.frame = self.bootomView.bounds;
    
    gradientL.opacity = 0;
    
    gradientL.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor blackColor].CGColor];
  
    self.gradientL = gradientL;
    
    [self.bootomView.layer addSublayer:gradientL];
}
- (IBAction)clear:(id)sender {
}


// 拖动的时候旋转上部分内容，200 M_PI
- (void)pan:(UIPanGestureRecognizer *)pan{
    
    //获取偏移量
    CGPoint transP = [pan translationInView:_dragView];
    NSLog(@"%@", NSStringFromCGPoint(transP));

    //旋转角度
    CGFloat angle = - transP.y / 200.0 * M_PI;
    
    
//    self.topView.layer.transform = CATransform3DIdentity;
    
    CATransform3D transfrom = CATransform3DIdentity;
      // 增加旋转的立体感，近大远小,d：距离图层的距离
    transfrom.m34 = -1 / 200.0;
    transfrom = CATransform3DRotate(transfrom, angle, 1, 0, 0);
  

    
    self.topView.layer.transform = transfrom;
    
    self.gradientL.opacity = transP.y * 1 /200.0;
    
    if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled) {
        
        [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            
        } completion:^(BOOL finished) {
            
            self.topView.layer.transform = CATransform3DIdentity;

        }];
        
        
    }


}
































@end
