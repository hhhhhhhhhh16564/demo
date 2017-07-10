//
//  ViewController.m
//  绘图(基本知识)
//
//  Created by 周磊 on 16/8/9.
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
    
//    BlueView *chidlrenView = [[BlueView alloc]init];
//    chidlrenView.frame = CGRectMake(50, 50, 300, 300);
//    chidlrenView.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:chidlrenView];
//    
//    self.chidlrenView = chidlrenView;
//
//  
    
    
    RedView *chidlrenView = [[RedView alloc]init];
    chidlrenView.frame = CGRectMake(50, 150, 300, 300);
    chidlrenView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:chidlrenView];
    
    self.chidlrenView = chidlrenView;
    

    
    
    
//    
//    BlackVeiw *chidlrenView = [[BlackVeiw alloc]init];
//    chidlrenView.frame = CGRectMake(50, 150, 300, 300);
//    chidlrenView.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:chidlrenView];
//    
//    self.chidlrenView = chidlrenView;
//

    
    
}
- (IBAction)slider:(UISlider *)sender {
    
    BlackVeiw *view = (BlackVeiw *)self.chidlrenView;
    view.progressvalue = sender.value;
    
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}















@end
