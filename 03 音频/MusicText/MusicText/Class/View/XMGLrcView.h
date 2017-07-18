//
//  XMGLrcView.h
//  MusicText
//
//  Created by 周磊 on 16/8/8.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMGLrcView : UITableView
//歌词名

@property(nonatomic, strong) NSString *lrcName;


//当前播放器播放的时间
@property (nonatomic,assign) NSTimeInterval currentTime;

//当前播放器总时间
@property (nonatomic,assign) NSTimeInterval duration;



@end
























