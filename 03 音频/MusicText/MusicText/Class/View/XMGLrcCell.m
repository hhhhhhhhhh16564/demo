//
//  XMGLrcCell.m
//  04-QQMusic
//
//  Created by xiaomage on 15/12/18.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "XMGLrcCell.h"
#import "XMGLrcLabel.h"
#import "Masonry.h"

@implementation XMGLrcCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    if (self) {
        
        [self p_setUPViews];
        
    }
    
    return self;
    
    
}


-(void)p_setUPViews{
    
    
    self.lrcLabel = [[XMGLrcLabel alloc]init];
    self.lrcLabel.textAlignment = NSTextAlignmentCenter;
    self.lrcLabel.backgroundColor = [UIColor clearColor];
    
    self.lrcLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:self.lrcLabel];
    
    
    
}



-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    
    [self.lrcLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
       
        make.centerX.equalTo(self.contentView);
        make.top.and.bottom.mas_equalTo(0);
        
    }];
//
//    self.lrcLabel.frame = self.contentView.bounds;
    
}


-(void)setXmgline:(XMGLrcLine *)xmgline{
    
    _xmgline = xmgline;
    
    self.lrcLabel.text = _xmgline.text;
    
    
  
    
}










@end
