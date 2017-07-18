//
//  ViewController.m
//  ReactiveCocoaf
//
//  Created by 周磊 on 16/8/1.
//  Copyright © 2016年 zhl. All rights reserved.
//

#import "ViewController.h"
#import "Global.h"
#import "MinorViewController.h"
#import "RedView.h"

@interface ViewController ()

@property(nonatomic, strong) UIView *redVeiw;
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation ViewController

//- (void)viewDidLoad {
//    
//    [super viewDidLoad];
//    // Do any additional setup after loading the view, typically from a nib.
//    self.view.backgroundColor = [UIColor blueColor];
//    
//
//
//   
//    
//    
//}

-(void)commandCompleted{
   //当前命令内部发送数据完成，一定要主动发送完成
      RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            //input :执行命令输入参数
        //Block调用：执行命令的时候就会调用
        NSLog(@"%@", input);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
               //发送数据
            [subscriber sendNext:@"执行命令产生的数据"];
            // 发送完成, 要自动调用发送完成，否则便不知道是否已经执行完成
            [subscriber sendCompleted];
            return nil;
         }];
    }];
    
    //监听事件有没有完成
    [command.executing subscribeNext:^(id x) {
        if ([x boolValue] == YES) {  //当前任务正在执行
             NSLog(@"当前任务正在执行");
        }else{
             //执行完成/没有执行
            NSLog(@"执行完成/没有执行");
        }
     
    }];

    //2.执行命令
    [command execute:@"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈"];
}
-(void)text1{
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"%@", input);
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"执行命令产生的数据"];
            //发送完成， 要自动调用发送完成，否则便不知道是否已经执行完成
            [subscriber sendCompleted];
            return nil;
            
        }];
        
    }];
    //监听事件有没有完成
    [command.executing subscribeNext:^(id x) {
        if ([x boolValue] == YES) {
            NSLog(@"当前任务正在执行");
        }else{
            //执行完成/没有执行
            NSLog(@"执行完成/没有执行");
            
        }

    }];
  
    [command execute:@"哈哈哈哈哈哈哈哈哈"];
    
    
    
    
}
-(void)switchTolasest{
    
    //创建信号中信号
    RACSubject *siganlOfSignals = [RACSubject subject];
    RACSubject *signalA = [RACSubject subject];
    RACSubject *siganlB = [RACSubject subject];
 
    //订阅信号：
    
//    [siganlOfSignals subscribeNext:^(id x) {
//        
//       [x subscribeNext:^(id x) {
//           
//           NSLog(@"%@", x);
//       }];
//        
//    }];
    //订阅信号
    //siwthcToLastest: 获取信号中信号发送的最新信号
    [siganlOfSignals.switchToLatest subscribeNext:^(id x) {
        
        NSLog(@"%@", x);
        
    }];
    [siganlOfSignals sendNext:signalA];
    
    [signalA sendNext:@"1111"];
    
    [siganlB sendNext:@"BBBBB"];
    [signalA sendNext:@"22222"];

    
}



-(void)executionSignals{
    
    //1.创建命令
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
       //intput : 执行命令传入参数
        // Blcok调用: 执行命令的时候就会调用
        NSLog(@"%@", input);
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            //发送数据
            [subscriber sendNext:@"执行命令产生的数据"];
            
            return nil;
            
        }];
        
        
        
    }];
    
    //订阅信号
    //方式二
    //注意； 必须要在执行命令前，订阅
    //executionSignals: 信号源，信号中信号，signalOfSignals:
    
//    [command.executionSignals subscribeNext:^(id x) {
//       // x是一个信号，需要重新订阅一次
//        [x subscribeNext:^(id x) {
//            NSLog(@"%@", x);
//            
//        }];
//        
//        
//        
//    }];
    
    //swithchTolastest 获取最新发送的信号，只能用于信号中的信号
    [command.executionSignals.switchToLatest subscribeNext:^(id x) {
       
        NSLog(@"%@",x);
        
    }];
//    2.执行命令
    [command execute:@1];
    
}








-(void)command{
    
    //RACCommand: 处理事件
    //RACCommand: 不能返回一个空的信号
    //创建命令
    
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
       // input:执行命令传入参数
        // Block调用: 执行命令执行该blcok
        
        NSLog(@"%@", input);
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [subscriber sendNext:@"执行命令产生的数据"];
            
            return nil;
        }];
        
    }];
    
    //如何拿到执行命令中产生的数据
    //订阅命令内部的信号
    //1. 方式一： 直接订阅执行命令返回的信号
//    2. 方式二:
    
    //2.执行命令
    RACSignal *signal = [command execute:@111];
    
    //3.订阅信号
    [signal subscribeNext:^(id x) {
       
        NSLog(@"%@", x);
        
    }];
    
}







- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    
    [self text1];
}





-(void)connect1{
    // RACMulticastConnection使用步骤:
    // 1.创建信号 + (RACSignal *)createSignal:(RACDisposable * (^)(id<RACSubscriber> subscriber))didSubscribe
    // 2.创建连接 RACMulticastConnection *connect = [signal publish];
    // 3.订阅信号,注意：订阅的不在是之前的信号，而是连接的信号。 [connect.signal subscribeNext:nextBlock]
    // 4.连接 [connect connect]
    
    // RACMulticastConnection底层原理:
    // 1.创建connect，connect.sourceSignal -> RACSignal(原始信号)  connect.signal -> RACSubject
    // 2.订阅connect.signal，会调用RACSubject的subscribeNext，创建订阅者，而且把订阅者保存起来，不会执行block。
    // 3.[connect connect]内部会订阅RACSignal(原始信号)，并且订阅者是RACSubject
    // 3.1.订阅原始信号，就会调用原始信号中的didSubscribe
    // 3.2 didSubscribe，拿到订阅者调用sendNext，其实是调用RACSubject的sendNext
    // 4.RACSubject的sendNext,会遍历RACSubject所有订阅者发送信号。
    // 4.1 因为刚刚第二步，都是在订阅RACSubject，因此会拿到第二步所有的订阅者，调用他们的nextBlock
    
    
    // 需求：假设在一个信号中发送请求，每次订阅一次都会发送请求，这样就会导致多次请求。
    // 解决：使用RACMulticastConnection就能解决.
    
    //1. 创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       //didsubscribe 什么时候来：  链接类连接的时候
        
        NSLog(@"发送热门模块的请求");
        [subscriber sendNext:@"热门模块的数据"];
        
        return nil;
        
    }];
    
    //2. 把信号转换为连接类
    //确定源信号的订阅者RACSubject
//    RACMulticastConnection *connetion = [signal publish];
    
    //RACReplaySubject可以先发送信号再订阅信号
    RACMulticastConnection *connetion = [signal multicast:[RACReplaySubject subject]];
    
    
    //2. 订阅链接类信号，
    // 注意： 订阅信号，也不能激活信号，只能保存订阅者到数组，必须通过连接，当调用链接，就会一次性调用所有订阅者的sendNext;
    [connetion.signal subscribeNext:^(id x) {
            NSLog(@"订阅者一信号:  %@", x);

        
        }];
    [connetion.signal subscribeNext:^(id x) {
        NSLog(@"订阅者二信号: %@", x);
        
    }];
    
    
    //4.连接,激活信号
    [connetion connect];
    
    [connetion.signal subscribeNext:^(id x) {
        NSLog(@"订阅者三信号: %@", x);
        
    }];
    
    // 打印结果
    
//    2016-08-02 14:47:17.312 ReactiveCocoaf[58215:282777] 发送热门模块的请求
//    2016-08-02 14:47:17.313 ReactiveCocoaf[58215:282777] 订阅者一信号:  热门模块的数据
//    2016-08-02 14:47:17.313 ReactiveCocoaf[58215:282777] 订阅者二信号: 热门模块的数据
//    2016-08-02 14:47:17.314 ReactiveCocoaf[58215:282777] 订阅者三信号: 热门模块的数据

    
}





// 包装元组的宏

-(void)cuplepack{
   
    RACTuple *tuple =  RACTuplePack(@1, @2);
    
    NSLog(@"%@", tuple);
    
}
//观察者宏

-(void)observe{
    
    //只要这个对象的某一个属性改变就会产生这一信号
    
    
    //通过键盘 输入改变文字，并不会触发方法，但是通过代码赋值输入会改变方法
    [RACObserve(self.textField, text) subscribeNext:^(id x) {
        
        NSLog(@"%@", x);
        
    }];
    
    
    
}

-(void)RAC{
    
    //监听文本框内容
//  [[self.textField rac_textSignal]subscribeNext:^(id x) {
//      
//      self.label.text = x;
//      
//  }];
    
   //用来给某个对象的某个属性绑定信号，只要产生信号内容，就会把内容属性赋值
    RAC(self.label, text) = _textField.rac_textSignal;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.textField.backgroundColor = [UIColor greenColor];
    
    static int a = 0;
    a++;
    NSString *str = [NSString stringWithFormat:@"%d%d", a,a];
    self.textField.text = str;
    
    MinorViewController *minorVC = [[MinorViewController alloc]init];
    
    [self presentViewController:minorVC animated:NO completion:nil];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
