//
//  ViewController.m
//  ReactiveCocoaf
//
//  Created by 周磊 on 16/8/1.
//  Copyright © 2016年 zhl. All rights reserved.
//

#import "ViewController.h"
#import "Global.h"

#import "BlueView.h"
@class BlueView;

@interface ViewController ()


@property(nonatomic, strong) id<RACSubscriber> subscriber;

@property (weak, nonatomic) IBOutlet BlueView *blueView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor redColor];
    
    
   [_blueView.subject subscribeNext:^(id x) {
       NSLog(@"%@", x);
       self.view.backgroundColor = [UIColor greenColor];
       
   }];

    
}

-(void)RACReplaySubject{
    // RACReplaySubject使用步骤:
    // 1.创建信号 [RACSubject subject]，跟RACSiganl不一样，创建信号时没有block。
    // 2.可以先订阅信号，也可以先发送信号。
    // 2.1 订阅信号 - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
    // 2.2 发送信号 sendNext:(id)value
    
    // RACReplaySubject:底层实现和RACSubject不一样。
    // 1.调用sendNext发送信号，把值保存起来，然后遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock。
    // 2.调用subscribeNext订阅信号，遍历保存的所有值，一个一个调用订阅者的nextBlock
    
    // 如果想当一个信号被订阅，就重复播放之前所有值，需要先发送信号，在订阅信号。
    // 也就是先保存值，在订阅值。

    
    
    // 1.创建信号
    RACReplaySubject *subject = [RACReplaySubject subject];
    //2. 订阅信号
    
    

    
    [subject subscribeNext:^(id x) {
        NSLog(@"订阅1： %@", x);
        
    }];
    

    [subject subscribeNext:^(id x) {
        NSLog(@"订阅2： %@", x);
        
    }];
    //遍历所有的值，拿到当前订阅者去发送悚惧
    
    // 3.发送信号
    [subject sendNext:@1];
    [subject sendNext:@1];
    [subject sendNext:@1];
//
//    2016-08-01 22:49:27.991 ReactiveCocoaf[2834:80756] 订阅1： 1
//    2016-08-01 22:49:27.992 ReactiveCocoaf[2834:80756] 订阅2： 1
//    2016-08-01 22:49:27.992 ReactiveCocoaf[2834:80756] 订阅1： 1
//    2016-08-01 22:49:27.992 ReactiveCocoaf[2834:80756] 订阅2： 1
//    2016-08-01 22:49:27.992 ReactiveCocoaf[2834:80756] 订阅1： 1
//    2016-08-01 22:49:27.992 ReactiveCocoaf[2834:80756] 订阅2： 1
    
//    RACReplaySubject发送数据：
//    1.保存值
//     2. 遍历所有的订阅者，发送数据
//    RACReplaySubject :可以先发送信号，再订阅信号
   
    
    
    
    
    
    
    
}


-(void)RAcSubject{
    // RACSubject使用步骤
    // 1.创建信号 [RACSubject subject]，跟RACSiganl不一样，创建信号时没有block。
    // 2.订阅信号 - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
    // 3.发送信号 sendNext:(id)value
    
    // RACSubject:底层实现和RACSignal不一样。
    // 1.调用subscribeNext订阅信号，只是把订阅者保存起来，并且订阅者的nextBlock已经赋值了。
    // 2.调用sendNext发送信号，遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock。

    
    
    
    //1、 创建订阅者

    RACSubject *subject = [RACSubject subject];
    
// 2.订阅信号
    //不同信号订阅的方式不一样
    //RASSubject 处理订阅，仅仅是保存订阅者
   [subject subscribeNext:^(id x) {
       NSLog(@"订阅者接受到数据:  %@", x );
       
   }];
    
    [subject subscribeNext:^(id x) {
        
        NSLog(@"订阅者2  接收到数据:%@ ", x);
    }];
    [subject subscribeNext:^(id x) {
        
        NSLog(@"订阅者3  接收到数据:%@ ", x);
    }];   [subject subscribeNext:^(id x) {
        
        NSLog(@"订阅者4  接收到数据:%@ ", x);
    }];

    [subject sendNext:@1];
    
    //2016-08-01 19:47:46.352 ReactiveCocoaf[19135:96842]  订阅者接受到数据:  1
    //2016-08-01 19:47:46.353 ReactiveCocoaf[19135:96842]  订阅者2  接收到数据:1
    //2016-08-01 19:47:46.353 ReactiveCocoaf[19135:96842]  订阅者3  接收到数据:1
    //2016-08-01 19:47:46.354 ReactiveCocoaf[19135:96842]  订阅者4  接收到数据:1

    

    
    //保存订阅者
    //底层实现，便利所有的订阅者，调用nextBlcok
    //执行流程
    
    //RACSubject 被订阅，仅仅是保存订阅者
    // RACsubject 发送数据，便利所有的订阅者，调用他们的nextBlcok
    
    
    
}


-(void)RACDisposable{
    

    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"信号被订阅");
        
        //发送信号
        [subscriber sendNext:@"1"];
        
      
        
        //只要信号被订阅，默认会自动取消
        
        //要想信号不被取消，则需要保存订阅者
        _subscriber = subscriber;
        
        return [RACDisposable disposableWithBlock:^{
            //只要信号被取消订阅就会来这儿
            //清空资源
            NSLog(@"信号被取消订阅了");
            
        }];
        
    }];
    
    //订阅信号
    RACDisposable *disposable = [signal subscribeNext:^(id x) {
        
        NSLog(@"%@", x);
        
    }];
    
    //1.创建订阅者，保存nextBlcok
    //2. 订阅信号
    //默认一个信号发送数据完毕后就会自耦东取消信号订阅
    // 只要订阅者在，就不会自动取消信号订阅
    //取消订阅信号
    
    
    //收懂取消，保存订阅者也没用
    [disposable dispose];
    
    
    
}

-(void)RACSignal{
    
    //    RACSignal: 有数据产生的时候，就用RacSingal
    //    RACSignal使用的步骤: 1、创建信号  2、 订阅信号  3、 发送信号
    
    
    RACDisposable *(^didSubScribe)(id<RACSubscriber> subscriber) = ^RACDisposable *(id<RACSubscriber>subscriber){
        
        //didSubscriber调用:只要一个信号被订阅就会调用
        //didSubscriber作用: 发送数据
        
        
        NSLog(@"信号被订阅");
        [subscriber sendNext:@1];
        
        
        return nil;
    };
    
    
    
    //1、 创建信号(冷信号)
    RACSignal *signal = [RACSignal createSignal:didSubScribe];
    
    // 2、订阅信号(热信号)
    [signal subscribeNext:^(id x) {
        
        //nextBlcok调用：只要订阅者发送数据就会调用
        //nextBlcok作用: 处理数据，展示到UI上面
        
        // x:信号发送的内容
        NSLog(@"%@",x);
        
    }];
    
    //只要订阅者调用sendNext,就会执行nextBlock
    //只要订阅RACDynamicSignal,就会执行didSubsciber
    //前提条件是RACDynamicSignal,不同类型的信号的订阅，处理订阅的事情不一样
  
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
