//
//  YBDanmuView.h
//  12-弹幕框架
//
//  Created by yanbo on 17/8/8.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBDanmuModelProtocol.h"
@protocol YBDanmuViewProtocol <NSObject>

//外界的时间，也就是视频播放到的时间
@property (nonatomic, readonly) NSTimeInterval currentTime;

-(UIView *)danmuViewModle:(id<YBDanmuModelProtocol>)model;





@end


@interface YBDanmuView : UIView

@property(nonatomic, weak) id<YBDanmuViewProtocol> delegate;
@property(nonatomic, strong) NSMutableArray<id <YBDanmuModelProtocol>> *models;


// 弹幕的行数 默认为5
@property (nonatomic,assign) NSUInteger danDaoCount;

// 检测Modle的时间  默认为0.1
@property (nonatomic,assign) CGFloat timerSes;



@end
