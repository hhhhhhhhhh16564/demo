//
//  BlueView.m
//  ReactiveCocoaf
//
//  Created by pro on 16/8/1.
//  Copyright © 2016年 zhl. All rights reserved.
//

#import "BlueView.h"

@implementation BlueView

-(RACSubject *)subject{
    if (_subject == nil) {
        _subject = [RACSubject subject];
    }
    
    return _subject;
    
}


-(IBAction)btnClik:(id)sender{
    
    //通知控制器处理，并且可以传递数据

    [_subject sendNext:@"12345"];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
