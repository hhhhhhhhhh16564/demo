//
//  ViewController.m
//  MusicText
//
//  Created by pro on 16/8/7.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "ViewController.h"

#import "XMGAudioTool.h"
#import "XMGMusicTool.h"
#import "XMGLrcLine.h"
#import "XMGLrcTool.h"
#import "XMGLrcView.h"
#import "Masonry.h"
#import "AppDelegate.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIButton *button;

/** 进度条时间 */
@property (nonatomic, strong) NSTimer *progressTimer;

/** 播放器 */
@property (nonatomic, strong) AVAudioPlayer *currentPlayer;

@property(nonatomic, strong) XMGMusic *playingmusic;
@property(nonatomic, strong) XMGLrcView *lrcTabeView;

//歌词定时器
@property(nonatomic, strong) CADisplayLink *lrcTime;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    XMGMusic *playingMusic = [XMGMusicTool playingMusic];
    self.playingmusic = playingMusic;

    
    AVAudioPlayer *currenplayer = [XMGAudioTool playMusicWithFileName:playingMusic.filename];
    self.currentPlayer = currenplayer;

    [self addProgressTimer];
    [self addLrcTimer];
    
    [self setupViews];
    

    [XMGLrcTool lrcToolWithLrcName:playingMusic.lrcname];
    
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    delegate.remotoblock = ^(UIEvent *event){
        
        //            UIEventSubtypeRemoteControlPlay           播放
        //            UIEventSubtypeRemoteControlPause          暂停
        //            UIEventSubtypeRemoteControlStop           停止
        //            UIEventSubtypeRemoteControlNextTrack      下一首
        //            UIEventSubtypeRemoteControlPreviousTrack   上一首
        
        
        
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlPlay:
                
                //播放
                
                [self buttonAction:self.button];
                
                
                break;
                
            case UIEventSubtypeRemoteControlPause:
                
                //暂停
                [self buttonAction:self.button];
                
                break;
            case UIEventSubtypeRemoteControlStop:
                //停止
                
                break;
                //下一首
                
            case UIEventSubtypeRemoteControlNextTrack:
                
                
                break;
                
                //上一首
                
            case UIEventSubtypeRemoteControlPreviousTrack:
                
                
                break;

                
            default:
                break;
        }
        
        
        
        
        
    };
    

    
}

-(void)setupViews{
    
    [self.slider setThumbImage:[UIImage imageNamed:@"player_slider_playback_thumb"] forState:UIControlStateNormal];
    [self.button setBackgroundImage:[UIImage imageNamed:@"player_btn_pause_normal"] forState:(UIControlStateNormal)];
    
    [self.button setBackgroundImage:[UIImage imageNamed:@"player_btn_play_normal"] forState:(UIControlStateSelected)];
    
    XMGLrcView *talbeview = [[XMGLrcView alloc]init];
    self.lrcTabeView = talbeview;
    
    [self.contentView addSubview:talbeview];
    talbeview.backgroundColor = [UIColor clearColor];
    
    
    [talbeview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.top.mas_equalTo(0);
        
        
    }];
    
    
    talbeview.lrcName = self.playingmusic.lrcname;
    
    
}






#pragma mark - 对进度条时间的处理
- (void)addProgressTimer
{
    // 1.提前更新数据
    [self updateProgressInfo];
    
    // 2.添加定时器
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgressInfo) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.progressTimer  forMode:NSRunLoopCommonModes];
}


//歌词定时器
-(void)addLrcTimer{
    
    self.lrcTime = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateLrcInfo)];
    [self.lrcTime addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    
    
}

-(void)removeLrcTimer{
    
    [self.lrcTime invalidate];
    self.lrcTime = nil;
    
    
    
}


-(void)updateLrcInfo{
    
    self.lrcTabeView.currentTime = self.currentPlayer.currentTime;
}


#pragma mark 移除定时器
- (void)removeProgressTimer
{
    [self.progressTimer invalidate];
    self.progressTimer = nil;
}

#pragma mark - 更新进度条
- (void)updateProgressInfo
{
    
    
    // 2.更新滑动条
    self.slider.value = self.currentPlayer.currentTime / self.currentPlayer.duration;
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    

    self.currentPlayer.currentTime = self.slider.value*self.currentPlayer.duration;
    
    
    
}




- (IBAction)UPout:(UISlider *)sender {
    
    NSLog(@"已经松开手");
    
    [self.lrcTabeView reloadData];
}

- (IBAction)UP:(UISlider *)sender {
    
    NSLog(@"已经松开手");
    
    [self.lrcTabeView reloadData];
}

- (IBAction)buttonAction:(UIButton *)sender {
    if (self.currentPlayer.playing) {
        
        [self.currentPlayer pause];
        [self removeProgressTimer];
        [self removeLrcTimer];
        
    }else{
        
        [self.currentPlayer play];
        [self addProgressTimer];
        
        [self addLrcTimer];
    }
    
    
    
    sender.selected = self.currentPlayer.isPlaying;
    
}







@end
