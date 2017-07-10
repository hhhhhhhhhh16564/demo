//
//  AppDelegate.m
//  MusicText
//
//  Created by pro on 16/8/7.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "AppDelegate.h"

#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
 
    // 后台播放
    //1、 设置激活会话类型
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    //2. 激活
    [session setActive:YES error:nil];
    
    
    //开启远程控制事件
    [application beginReceivingRemoteControlEvents];
    
    
    
    
    
    
    return YES;
    
    
}



- (void)applicationDidEnterBackground:(UIApplication *)application {
    
       //  2、在didEnterBackground方法中开始后台任务
    
    [application beginBackgroundTaskWithExpirationHandler:nil];
    
    
    
}


-(void)remoteControlReceivedWithEvent:(UIEvent *)event{
    
    if (event.type == UIEventTypeRemoteControl) {
        
        if (self.remotoblock) {
            
//            UIEventSubtypeRemoteControlPlay           播放
//            UIEventSubtypeRemoteControlPause          暂停
//            UIEventSubtypeRemoteControlStop           停止
//            UIEventSubtypeRemoteControlNextTrack      下一首
//            UIEventSubtypeRemoteControlPreviousTrack   上一首
//            
            
            self.remotoblock(event);
        }
        
        
        
        
    }
    
    
}











@end
