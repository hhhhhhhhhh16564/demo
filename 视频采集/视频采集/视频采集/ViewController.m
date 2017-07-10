//
//  ViewController.m
//  gif动画
//
//  Created by 周磊 on 17/7/10.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <ImageIO/ImageIO.h>
@interface ViewController ()<AVCaptureAudioDataOutputSampleBufferDelegate, AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureFileOutputRecordingDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property(nonatomic, strong) AVCaptureSession *session;

@property(nonatomic, strong) AVCaptureDeviceInput *input;

@property(nonatomic, strong) AVCaptureVideoPreviewLayer *preViewLayer;

@property(nonatomic, strong) AVCaptureMovieFileOutput *movieFileOutput;

@end

@implementation ViewController

-(AVCaptureSession *)session{
    if (!_session) {
        _session = [[AVCaptureSession alloc]init];
    }
    return _session;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 1.初始化视频的输入&输出
    
    [self setupVideoInputOutput];
    
    // 2.初始化音频的输入&输出
    [self setupAudioInputOutput];
    
    
}


// 开启
- (IBAction)first:(UIButton *)sender {
    
    // 开启会话
    
    if (self.session.running) {
        return;
    }
    
    [self.session startRunning];
    
    [self setupPreviewLayer];
    
    [self setupMovieFileOutput];

}

// 停止
- (IBAction)second:(id)sender {
    
    
    // 停止绘画
    if (self.session.running) {
        [self.movieFileOutput stopRecording];

        
        [self.session stopRunning];
        [self.preViewLayer removeFromSuperlayer];
    }

}

// 转换摄像图
- (IBAction)third:(id)sender {
    //1. 取出之前的方向
    
    AVCaptureDevicePosition position = self.input.device.position;
    
    position = position == AVCaptureDevicePositionBack ? AVCaptureDevicePositionFront : AVCaptureDevicePositionBack;
    
    NSArray *devices = [AVCaptureDevice devices];
    
    AVCaptureDevice *changTodevice = nil;
    
    for (AVCaptureDevice *device in devices) {
        
        if (device.position == position) {
            changTodevice = device;
            
            break;
        }
        
    }
    
    AVCaptureDeviceInput *input = [[AVCaptureDeviceInput alloc]initWithDevice:changTodevice error:nil];
    
    [self.session beginConfiguration];
    
    [self.session removeInput:self.input];
    
    if ([self.session canAddInput:input]) {
        [self.session addInput:input];
    }

    [self.session commitConfiguration];

    self.input = input;
    
}



-(void)setupVideoInputOutput{
    
    //1. 添加视频的输入
    // 包含了所有的设备： 前置输入、后置摄像头输入
    NSArray *devices = [AVCaptureDevice devices];
    AVCaptureDevice *device = devices.firstObject;
    
    NSLog(@"设备的个数: %zd", devices.count);
    
    for (AVCaptureDevice *device in devices) {
        NSLog(@" %@", device);
    }
    
    AVCaptureDeviceInput *input = [[AVCaptureDeviceInput alloc]initWithDevice:device error:nil];
    self.input = input;
    
    
    // 2.添加视频的输入
    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc]init];
    [output setSampleBufferDelegate:self queue:dispatch_get_global_queue(0, 0)];

    
    [self.session beginConfiguration];
 
    
    if ([self.session canAddInput:input]) {
        [self.session addInput:input];
    }
    
    if ([self.session canAddOutput:output]) {
        [self.session addOutput:output];
    }
    [self.session commitConfiguration];
    
}

-(void)setupAudioInputOutput{
    
    //1.创建音频输入： 音频只有麦克风，可以直接传一个类型
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    // 2. 创建输出
    
    AVCaptureAudioDataOutput *output = [[AVCaptureAudioDataOutput alloc]init];
    
    [output setSampleBufferDelegate:self queue:dispatch_get_global_queue(0, 0)];
    
    
    [self.session beginConfiguration];
    if ([self.session canAddInput:input]) {
        [self.session addInput:input];
    }
    
    if ([self.session canAddOutput:output]) {
        [self.session addOutput:output];
    }
    [self.session commitConfiguration];

    
}

// 添加预览层
-(void)setupPreviewLayer{
    
    
    if (self.preViewLayer) {
        
        [self.view.layer insertSublayer:self.preViewLayer atIndex:0];

        return;
    }
    
    // 1. 创建预览图层
    AVCaptureVideoPreviewLayer *preViewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
    
    //2.  设置 previewLayer属性
    preViewLayer.frame = self.view.bounds;
    
    // 3、将图层添加到控制器view的layer中
    
    [self.view.layer insertSublayer:preViewLayer atIndex:0];
    
    self.preViewLayer = preViewLayer;
    
    
    
}

// 录制视频, 并写入文件
-(void)setupMovieFileOutput{
    
    //  移除
    [self.session removeOutput:self.movieFileOutput];
    
    // 1. 创建写入文件的输出
    
    AVCaptureMovieFileOutput *movieFileOutput = [[AVCaptureMovieFileOutput alloc]init];
    
    self.movieFileOutput = movieFileOutput;
    
    
    AVCaptureConnection *connection = [movieFileOutput connectionWithMediaType:AVMediaTypeVideo];
    connection.automaticallyAdjustsVideoMirroring = YES;
    
    if ([self.session canAddOutput:movieFileOutput]) {
        [self.session addOutput:movieFileOutput];
    }
    
    // 2.  直接开始写入文件
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    path = [path stringByAppendingString:@"/abc.mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    [movieFileOutput startRecordingToOutputFileURL:url recordingDelegate:self];
    

    
    
    
    
    
}


#pragma mark 代理方法
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{


    if ([captureOutput isKindOfClass:[AVCaptureVideoDataOutput class]]) {
        
//        NSLog(@"视频处理");
    }
    
    
    if ([captureOutput isKindOfClass:[AVCaptureAudioDataOutput class]]) {
        
//        NSLog(@"音频处理");
    }
    
    
    
}





- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections{
    
    NSLog(@"开始录制");
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didPauseRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections NS_AVAILABLE(10_7, NA){
    
    NSLog(@"暂停录制");
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput willFinishRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections error:(NSError *)error NS_AVAILABLE(10_7, NA){
    
    NSLog(@"将要暂停录制");

}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error{
    
        NSLog(@"结束录制");
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
