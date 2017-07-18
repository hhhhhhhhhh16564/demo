//
//  ViewController.m
//  按钮点击页面切换
//
//  Created by 周磊 on 17/7/13.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "ViewController.h"
#import "YBTitleStytle.h"
#import "YBPageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    YBTitleStytle  *style = [[YBTitleStytle alloc]init];
    style.isScrollEndble = NO;
    NSArray *titleArray = @[@"语文", @"数学个地方官的双方各", @"化学生物", @"鹦鹉十多个电饭锅电饭锅", @"孙悟空发送分散", @"语文", @"数学", @"化学生物", @"鹦鹉", @"孙悟发顺丰萨达是否空"];
    titleArray = @[@"语文", @"数学", @"英语"];
    NSMutableArray *childVcArray = [NSMutableArray array];

    for (int i = 0; i < titleArray.count; i++) {
        UIViewController *Vc = [[UIViewController alloc]init];
        
        [childVcArray addObject:Vc];
    }
    
    CGRect rect = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20);
    
    YBPageView *pageView = [[YBPageView alloc]initWithFrame:rect stytle:style titles:titleArray childVcs:childVcArray parentVc:self];
    
    [self.view addSubview:pageView];
    
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
