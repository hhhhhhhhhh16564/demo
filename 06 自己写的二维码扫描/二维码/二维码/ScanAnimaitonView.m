//
//  ScanAnimaitonView.m
//  二维码
//
//  Created by yanbo on 17/9/5.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "ScanAnimaitonView.h"
@interface ScanAnimaitonView ()

{
    
 BOOL _isAnimate;
}
@property(nonatomic, strong) UIView *shapView;



@end


@implementation ScanAnimaitonView

-(UIView *)shapView{
    if (!_shapView) {
        _shapView = [[UIView alloc]init];
        _shapView.backgroundColor = [UIColor greenColor];
        [self addSubview:_shapView];
    }
    return _shapView;
}



-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    self.layer.contents = (id)[[UIImage imageNamed:@"pick_bg"] CGImage];
    self.layer.borderWidth = 0;
    
    return self;
    
}

//二维码扫描区域周边黑暗可以运用 奇偶填充法则

-(void)startAnimation{
    
    _isAnimate = YES;
    self.shapView.frame = CGRectMake(0, 0, self.bounds.size.width, 2);
    self.shapView.hidden = NO;
    [UIView animateWithDuration:4 animations:^{
        
        CGRect rect  = self.shapView.frame;
        rect.origin.y = self.bounds.size.height-self.shapView.bounds.size.height;
        self.shapView.frame = rect;
        
    } completion:^(BOOL finished) {
        
        if (_isAnimate) {
            [self startAnimation];
        }
        
    }];
    
}

-(void)stopAnimation{
    
    _isAnimate = NO;
    self.shapView.hidden = YES;
}

@end
