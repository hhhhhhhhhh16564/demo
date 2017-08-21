//
//  ViewController.m
//  粒子效果
//
//  Created by yanbo on 17/8/16.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "ViewController.h"
#import "DraWView.h"
@interface ViewController ()
@property(nonatomic, strong) DraWView *drawView;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.drawView = [[DraWView alloc]init];
    self.drawView.frame = self.view.bounds;
    self.drawView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.drawView];


    [self.view sendSubviewToBack:self.drawView];
}

- (IBAction)start:(id)sender {
    [self.drawView start];
}
- (IBAction)Clear:(id)sender {
    
    
    [self.drawView clear];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
