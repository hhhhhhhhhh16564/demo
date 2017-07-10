//
//  XMGAudioTool.h
//  MusicText
//
//  Created by pro on 16/8/7.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AVFoundation/AVFoundation.h>

#import "XMGMusic.h"

@interface XMGAudioTool : NSObject
// 播放音乐 fileName:音乐文件
+ (AVAudioPlayer *)playMusicWithFileName:(NSString *)fileName;

// 暂停音乐 fileName:音乐文件
+ (void)pauseMusicWithFileName:(NSString *)fileName;

// 停止音乐 fileName:音乐文件
+ (void)stopMusicWithFileName:(NSString *)fileName;


@end
