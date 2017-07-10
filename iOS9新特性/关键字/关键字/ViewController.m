//
//  ViewController.m
//  关键字
//
//  Created by 周磊 on 16/7/26.
//  Copyright © 2016年 zhl. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

// nullable作用:表示可以为空
@property(nonatomic,strong, nullable)NSString *name1;
@property(nonatomic, strong)NSString * __nullable name2;
@property(nonatomic, strong) NSString *_Nullable name3;

// 在NS_ASSUME_NONNULL_BEGIN和NS_ASSUME_NONNULL_END之间,定义的所有对象属性和方法默认都是nonnull

NS_ASSUME_NONNULL_BEGIN

@property(nonatomic, strong) NSString *sex;

NS_ASSUME_NONNULL_END



// null_resettable: get:不能返回为空, set可以为空
// 注意;如果使用null_resettable,必须 重写get方法或者set方法,处理传递的值为空的情况
// 书写方式:
@property(nonatomic, strong, null_resettable) NSString *name4;

@property(nonatomic, strong, null_resettable) NSString *name5;




// name4 name5 使用点语法时会提示 _Null_unspecified: 表示不确定是否为空
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
//重写getter方法 null_resettable
-(NSString *)name4{
    
    if (_name4 == nil) {
        _name4 = [NSString stringWithFormat:@"jjj"];
    }
    
    return _name4;
}
//重写setter方法 null_resettable
-(void)setName5:(NSString *)name5{
    _name5 = name5;
    
    if (_name5 == nil) {
        _name5 = @"jjjjj";
    }
}
//控制器的view的修饰方法null_resettable
//- (UIView *)view
//{
//    if (_view == nil) {
//        [self loadView];
//        [self viewDidLoad];
//    }
//
//    return _view;
//}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end


