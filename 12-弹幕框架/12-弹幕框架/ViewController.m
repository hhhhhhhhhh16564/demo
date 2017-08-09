//
//  ViewController.m
//   12-弹幕框架
//
//  Created by yanbo on 17/8/8.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "ViewController.h"

#import <ImageIO/ImageIO.h>
#import "YBDanmuView.h"
#import "YBDanmuModelProtocol.h"
#import "YBModel.h"
@interface ViewController ()<YBDanmuViewProtocol>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property(nonatomic, strong) YBDanmuView *danmuView;

@property (nonatomic,assign) NSTimeInterval currentPlayTime;

@property(nonatomic, strong) NSTimer *timer;

@end

@implementation ViewController

int a = 0;
- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    YBDanmuView *danmuView = [[YBDanmuView alloc]initWithFrame:CGRectMake(30, 100, 300, 200)];
    danmuView.backgroundColor = [UIColor orangeColor];
    danmuView.delegate = self;
    [self.view addSubview:danmuView];
    
    self.danmuView = danmuView;

    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(getCurrentTime) userInfo:nil repeats:YES];

    [[NSRunLoop currentRunLoop] addTimer:timer forMode:(NSRunLoopCommonModes)];
    
    self.timer = timer;
    
    [self second:nil];

}

-(NSTimeInterval)currentTime{
    
    
    return self.currentPlayTime;
}

-(UIView *)danmuViewModle:(id<YBDanmuModelProtocol>)model{
    
    UILabel *label = [[UILabel alloc]init];
    
    YBModel *m = model;
    label.text = m.content;
 
    label.backgroundColor = [UIColor grayColor];
    [label sizeToFit];
    
    return label;

}

-(void)getCurrentTime{
    
    a++;
    
    self.currentPlayTime = a;
    
//    NSLog(@"%.0f", self.currentPlayTime);
}


//开启
- (IBAction)first:(UIButton *)sender {
 
    self.timer.fireDate = [NSDate distantPast];
    
    YBModel *model = [[YBModel alloc]init];
    model.beginTime = self.currentPlayTime;
    model.liveTime = 3;
    model.content = @"好好学习";
    
    [self.danmuView.models addObject:model];
    
    
    
    YBModel *model2 = [[YBModel alloc]init];
    model2.beginTime = self.currentPlayTime;
    model2.liveTime = 3;
    model2.content = @"天天向上";
    
    [self.danmuView.models addObject:model2];
    
    
    NSLog(@"%@", self.danmuView.models);

}
- (IBAction)second:(id)sender {

    self.timer.fireDate = [NSDate distantFuture];
    
    
}


//暂停
- (IBAction)third:(id)sender {
    
    [self.danmuView.models enumerateObjectsUsingBlock:^(id<YBDanmuModelProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSLog(@"%.0f", [obj beginTime]);
        
    }];
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
