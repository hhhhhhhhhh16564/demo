//
//  XMGAudioTool.m
//  MusicText
//
//  Created by pro on 16/8/7.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "XMGAudioTool.h"
#import "XMGMusicTool.h"


//设置锁屏信息需要导入一个框架
#import <MediaPlayer/MediaPlayer.h>


static NSMutableDictionary *_soudIDs;
static NSMutableDictionary *_players;

@implementation XMGAudioTool

+(void)initialize{
    
    _soudIDs = [NSMutableDictionary dictionary];
    _players = [NSMutableDictionary dictionary];
    
}

// 播放音乐 fileName:音乐文件
+ (AVAudioPlayer *)playMusicWithFileName:(NSString *)fileName{
    
    AVAudioPlayer *player = nil;
    player = _players[fileName];
    
    if (player == nil) {
    //生成对应的音乐资源
    
        NSURL *fileUrl = [[NSBundle mainBundle]URLForResource:fileName withExtension:nil];
        
        if (fileUrl == nil) {
            return nil;
        }
    
    
        player = [[AVAudioPlayer alloc]initWithContentsOfURL:fileUrl error:nil];
        
        [_players setObject:player forKey:fileName];
        
        [player prepareToPlay];
        
    }
    
    //开始播放
    [player play];
    
   //设置锁屏音乐的信息
    
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    
    //设置专辑名称
    info[MPMediaItemPropertyAlbumTitle] = @"中文十大金曲";
    
    
    XMGMusic *playingMusic = [XMGMusicTool playingMusic];
    // 设置歌曲名称
    info[MPMediaItemPropertyTitle] =  playingMusic.name;
    
    //设置歌手
    
    info[MPMediaItemPropertyArtist] = playingMusic.singer;
    
    //设置专辑图片
    
    info[MPMediaItemPropertyArtwork] = [[MPMediaItemArtwork alloc]initWithImage:[UIImage imageNamed:@"dzq.jpg"]];
    
    //设置时间
    info[MPMediaItemPropertyPlaybackDuration] = @(player.duration);
    
    
    [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = info;


    return player;
}
// 暂停音乐 fileName:音乐文件
+ (void)pauseMusicWithFileName:(NSString *)fileName{
    //从字典中取出播放器
    AVAudioPlayer *player = _players[fileName];
    if (player) {
        [player pause];
    }
}

// 停止音乐 fileName:音乐文件
+ (void)stopMusicWithFileName:(NSString *)fileName{
    
   //1.从字段中取出播放器
    AVAudioPlayer *player = _players[fileName];
    if (player) {
        [player stop];
        [_players removeObjectForKey:fileName];
        player = nil;
    }

}

@end
