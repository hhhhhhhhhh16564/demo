//
//  ViewController.m
//  音频播放
//
//  Created by pro on 16/8/3.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "ViewController.h"
#import "CZAudioTool.h"

#import <AudioToolbox/AudioToolbox.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    CZAudioTool *tool = [CZAudioTool sharedCZAudioTool];
    [tool playMp3WithName:@"enemy3_down.mp3"];
    
    

    
}

-(void)test{
    
   // 播放enemy1_down.mp3文件
    
        //音频文件的路径
    
    //URL 要加一个 /
        NSURL *soundUrl = [[NSBundle mainBundle]URLForResource:@"/plane.bundle/enemy1_down.mp3" withExtension:nil];

   
    NSLog(@"%@", soundUrl);
    

    
    //音频ID，一个音频文件对应一个soundID
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(soundUrl), &soundID);
    
    
    AudioServicesPlayAlertSound(soundID);
    
    
    
    
    
    
    
}


@end
