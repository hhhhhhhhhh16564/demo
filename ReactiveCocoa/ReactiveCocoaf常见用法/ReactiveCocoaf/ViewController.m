//
//  ViewController.m
//  ReactiveCocoaf
//
//  Created by 周磊 on 16/8/1.
//  Copyright © 2016年 zhl. All rights reserved.
//

#import "ViewController.h"
#import "Global.h"
#import "Flag.h"
#import "RedView.h"
@class Flag;
@interface ViewController ()

@property(nonatomic, strong) UIView *redVeiw;
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blueColor];
    


    
    
    [self request];
    
    
}

-(void)redViewDelegate{
    // 1.代替代理
    //需求： 自定义redv结尾,监听红色View中按钮被点击
    //之前都是需要通过代理监听，给红色view添加一个代理属性，点击按钮的时候，通知代理做事情
    //rac_signalForSelector ：把调用某个对象的方法的信息转化为信号，调用这个方法，就会发送信号

    
    self.view.backgroundColor = [UIColor blueColor];
    
    RedView *redView = [RedView redView];
    redView.frame = CGRectMake(100, 100, 200, 300);
    
    [self.view addSubview:redView];
    self.redVeiw = redView;
    
    [[redView rac_signalForSelector:@selector(btnClick:)] subscribeNext:^(id x) {
        //先执行按钮内部的方法，然后执行监听点击的方法
        NSLog(@"监听到红色按钮被点击  %@",x);
        
        //主线程中调用
        NSLog(@"  %@", [NSThread currentThread]);
        //    <NSThread: 0x7fe802604db0>{number = 1, name = main}
        

    }];
}






//2. KVO
-(void)KVO{
   //把监听redView的center属性改变转化为信号，只要值改变就会发送信号
    //observer: 可以传入nil

    
    [[self.redVeiw rac_valuesAndChangesForKeyPath:@"center" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(id x) {
        
        
        NSLog(@" %@", [NSThread currentThread]);
        //    <NSThread: 0x7fe802604db0>{number = 1, name = main}

        NSLog(@"%@", x);
        
    }];

}


//3.  监听按钮点击

- (void)buttonClicked{
    
    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        NSLog(@"按钮被点击了");
        

        
    }];
    
    
    
}


//4. 代替通知

-(void)notification{
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillChangeFrameNotification object:nil] subscribeNext:^(id x) {
        
       NSLog(@"键盘已经改变frame  %@",x);
        
    }];
    
    
}





// 5 监听文本框文字改变

-(void)textfiledChanged{
    
    __weak typeof(self) weakSelf = self;
    [[self.textField rac_textSignal] subscribeNext:^(id x) {
       
//        NSLog(@"文字改变了: %@",x);
        
        
        weakSelf.label.text = x;
    
        
    }];
    
    
}
//6.0 处理多个请求，都返回结果的时候，同意做处理
-(void)request{
    RACSignal *request1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"%@", [NSThread currentThread]);
        //在主线程中执行
        // <NSThread: 0x7fdd11502ee0>{number = 1, name = main}
        //发送请求1
        [subscriber sendNext:@"发送请求1"];
        return nil;
        
    }];
    
    RACSignal *request2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    
        
        //发送请求2
        [subscriber sendNext:@"发送请求2"];
        
        return nil;
        
    }];
    // 数组:存放信号
    // 当数组中的所有信号都发送数据的时候,才会执行Selector
    // 方法的参数:必须跟数组的信号一一对应
    // 方法的参数;就是每一个信号发送的数据
    [self rac_liftSelector:@selector(updateUIWithR1:r2:) withSignalsFromArray:@[request1, request2]];
    
    

    
}
-(void)updateUIWithR1:(id)data r2:(id)data1{
    
        NSLog(@"更新UI  %@ %@", data, data1);
    
    
}

-(void)flagWithPlist{
    
    //解析plist文件
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"flags" ofType:@"plist"];
    
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:filePath];

    
    //初级用法
    
    //先执行下边的内容，然后再执行Block内部的内容
//    
//    NSMutableArray *arr = [NSMutableArray array];
//    
//    [dictArray.rac_sequence.signal subscribeNext:^(NSDictionary *x) {
//       // value:集合中元素
//        // id: 返回对象就是映射的值
//        
//        NSLog(@"%@", [NSThread currentThread]);
//        
////        这儿另外开辟了一条线程
//        //<NSThread: 0x7fe219c745c0>{number = 2, name = (null)}
//        Flag *flag = [Flag flagWithDic:x];
//        [arr addObject:flag];

//    }];
//    
    
    //高级用法
    //会把集合中所有的元素都映射成一个新的对象
    NSArray *arr = [[dictArray.rac_sequence map:^id(NSDictionary *value) {
        
        NSLog(@"%@", [NSThread currentThread]);
        //2016-08-02 10:08:54.373 ReactiveCocoaf[11778:60254] <NSThread: 0x7f8f91f00760>{number = 1, name = main}
        //主线程 没有创建线程
        
        return [Flag flagWithDic:value];
        
    }] array];
    
    NSLog(@"%@", arr);
    
 
    
}
-(void)arr{
    
    // 这里其实是三步
    // 第一步: 把数组转换成集合RACSequence numbers.rac_sequence
    // 第二步: 把集合RACSequence转换RACSignal信号类,numbers.rac_sequence.signal
    // 第三步: 订阅信号，激活信号，会自动把集合中的所有值，遍历出来。
    
    
   //数组
    NSArray *arr = @[@"231", @"333", @78];
    
    /*
    //RAC集合
    RACSequence *sequence = arr.rac_sequence;
    //把集合转化为信号
    RACSignal *signal = sequence.signal;
    //订阅集合信号，内部会自动遍历所有的元素发出来
    [signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    */
    
    
    [arr.rac_sequence.signal subscribeNext:^(id x) {
        
        NSLog(@"%@", arr);
        
    }];
  
}
-(void)tuple{
    //元组
    RACTuple *tuple = [RACTuple tupleWithObjectsFromArray:@[@"78", @"22", @8888]];
    
    NSString *str = tuple[0];
    
    NSLog(@"%@", str);
    
}


//遍历字典

-(void)dictionary{
    //遍历字典，遍历出来的键值对会包装成RACTuple(元祖对象)
    
    NSDictionary *dict = @{@"name":@"yanbo", @"age":@"@24"};
    
    [dict.rac_sequence.signal subscribeNext:^(RACTuple *x) {
        
        //解包元组，会把元组的值，按顺序给里边的参数的变量赋值
        
       RACTupleUnpack(NSString *key, NSString *value) = x;
        //相当于之下的写法
        
//        NSString *key = x[0];
//        NSString *value = x[1];
//        
        NSLog(@"key: %@    value : %@", key,value);
        
    }];
    
}
-(void)text1{
    NSDictionary *dict = @{@"name":@"yanbo", @"age":@"@24"};

    [dict.rac_sequence.signal subscribeNext:^(RACTuple* x) {
        
    
        
        
    }];
    
    
    
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    self.redVeiw.center = self.view.center;
    
    [self.view endEditing:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
