//
//  RedView.m
//  ReactiveCocoaf
//
//  Created by 周磊 on 16/8/2.
//  Copyright © 2016年 zhl. All rights reserved.
//

#import "RedView.h"

@implementation RedView


+(instancetype)redView{
    
    
    return [[[NSBundle mainBundle]loadNibNamed:@"RedView" owner:nil options:nil] lastObject];
    
}




- (IBAction)btnClick:(id)sender {
    
    NSLog(@"button已经被点击");
}




@end
