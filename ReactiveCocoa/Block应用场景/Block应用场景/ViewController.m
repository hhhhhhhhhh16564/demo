//
//  ViewController.m
//  Block应用场景
//
//  Created by 周磊 on 16/7/29.
//  Copyright © 2016年 zhl. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Calculate.h"
#import "ResponsecalcuteManager.h"
#import "Person.h"

@interface ViewController ()

@property(nonatomic, strong) UIView *redView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // block开发中使用场景
    
}

//block
-(void)block{
    
    // 1.把block保存到对象中,恰当时机的时候才去调用
    
    // 2.把block当做方法的参数使用,外界不调用,都是方法内部去调用,Block实现交给外界决定.
    
    // 3.把block当做方法的返回值,目的就是为了代替方法.,block交给内部实现,外界不需要知道Block怎么实现,只管调用
    
    
    Person *p = [[Person alloc]init];
    
    [p eat:^{
        NSLog(@"吃东西");
    }];
    p.run(6);
}

//链式变成思想
-(void)calculte{
    
 int b =  [NSObject yb_makeCalculate:^(CalculteManager * manager) {
     
     manager.add(6).add(16).add(4).add(14).add(18).add(87);
     
    }];
    NSLog(@"结果是 %d", b);
}


//响应式编程思想
-(void)responseCalcute{
    
    ResponsecalcuteManager *mannager = [[ResponsecalcuteManager alloc]init];
    
int result = [mannager yb_MakeCalcute: ^ int (int result) {
        
        result += 10;
        result += 20;
        result += 30;
 
    return result;
    
    }];
    
    
    NSLog(@"计算结果是________________: %d", result);

    
}




//响应式编程思想
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self responseCalcute];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
// Dispose of any resources that can be recreated.
}
@end
