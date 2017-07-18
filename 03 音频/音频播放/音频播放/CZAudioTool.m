//
//  CZAudioTool.m
//  音频播放
//
//  Created by pro on 16/8/3.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "CZAudioTool.h"
#import <AudioToolbox/AudioToolbox.h>

static NSDictionary *soundDict; //存贮所有的音频文件的systemSoundID

@implementation CZAudioTool

singleton_implementation(CZAudioTool)

//通过MP3的名字播放音频

+(void)initialize{
    
    //加载所有的音频文件
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //资源的路径
    
    // path不需要加 / 默认会有 /
    //但加了也可以，因为可以另个//
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"plane.bundle" ofType:nil];
    
    NSLog(@"%@", path);
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    NSArray *arrayPath = [fileManager contentsOfDirectoryAtPath:path error:nil];
    
    for (NSString *subpath in arrayPath) {
        //音频文件的urlpath
        NSString *urlpath = [path stringByAppendingPathComponent:subpath];
   
        NSURL *subUrlpaht = [NSURL fileURLWithPath:urlpath];
        
        SystemSoundID soundID ;
        
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(subUrlpaht), &soundID);
        
        dict[subpath] = @(soundID);
      
        
    }
    
    soundDict = dict;
    
    
}

-(void)playMp3WithName:(NSString *)mp3Name{
    
    
    SystemSoundID soundID = [soundDict[mp3Name] unsignedIntValue];
    
    
     //振动
    AudioServicesPlayAlertSound(soundID);
    
  
    
    
    
}

@end
