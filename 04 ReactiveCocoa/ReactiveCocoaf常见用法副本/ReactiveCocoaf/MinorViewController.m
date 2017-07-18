//
//  MinorViewController.m
//  ReactiveCocoaf
//
//  Created by 周磊 on 16/8/5.
//  Copyright © 2016年 zhl. All rights reserved.
//

#import "MinorViewController.h"
#import "Global.h"
#import "RACReturnSignal.h"


@class RACTuple;
@class RACSubject;
@interface MinorViewController ()

@end

@implementation MinorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    [self bindSignal];
}

-(void)bindSignal{
    
    //1. 创建信号
    RACSubject *subject = [RACSubject subject];
    
    // 2.绑定信号
    RACSignal *bindSignal = [subject bind:^RACStreamBindBlock{
       // block调用时刻：只要绑定信号就会被调用
        
        return ^RACSignal *(id value, BOOL *stop){
            
            //block调用: 只要源信号发送数据，就会调用block
            // block作用： 处理源信号内容
            // value:  源信号发送的内容
            
            NSLog(@"接收到原信号的内容：    %@", value);
            value = [NSString stringWithFormat:@"包装信号:  %@", value];
            return [RACReturnSignal return:value];
            
        };

    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
