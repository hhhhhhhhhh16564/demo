//
//  ViewController.m
//  二维码
//
//  Created by yanbo on 17/9/5.
//  Copyright © 2017年 zhl. All rights reserved.
//
#import "StaticLibrary.h"

#import "ViewController.h"
#import <CoreImage/CoreImage.h>
#import <AVFoundation/AVFoundation.h>
#import "ScanAnimaitonView.h"

#define Kwidth  [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height

#define KSccanWidth 212
@interface ViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property(nonatomic, strong) CIFilter *filter;
@property(nonatomic, strong) AVCaptureSession *session;
@property(nonatomic, strong) UIImageView *imv;


@property(nonatomic, strong) ScanAnimaitonView *scanView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    ScanAnimaitonView *scanView = [[ScanAnimaitonView alloc]init];
    scanView.frame = CGRectMake((Kwidth-KSccanWidth)*0.5, (KHeight-KSccanWidth)*0.5, KSccanWidth, KSccanWidth);
    [self.view addSubview:scanView];
    self.scanView = scanView;
}


- (IBAction)a1:(id)sender {

    UIImage *image = [self createQRCode];
    
    self.imv.image = image;
    NSLog(@"%@", image);

    NSData *data = UIImagePNGRepresentation(image);
 
    NSLog(@"%@", data);
    [data writeToFile:@"/Users/julyonline/Desktop/demo/11.png" atomically:YES];
    
}


- (IBAction)a2:(id)sender {
    
    UIImage *image = [UIImage imageNamed:@"222.jpg"];
    
    NSData *data = UIImageJPEGRepresentation(image, 1);
    [data writeToFile:@"/Users/julyonline/Desktop/demo/11.jpg" atomically:YES];

    self.imv.image = image;
}


- (IBAction)a3:(id)sender {
    
    
    [self scanQRCode:self.scanView.frame];
}


- (IBAction)a4:(id)sender {
    
    [StaticLibrary hhhh];
    
}


- (IBAction)a5:(id)sender {
    
 
    
}





-(UIImage *)createQRCode{
    
    //1、实例化一个滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //2、 恢复滤镜的默认属性
    [filter setDefaults];
    
    //3、 将字符串转化为data
    NSString *urlString = @"http://www.julyedu.com/";
    NSData *data = [urlString dataUsingEncoding:NSUTF8StringEncoding];
    
    
    //4、通过kvc获得输出数据
    [filter setValue:data forKey:@"inputMessage"];
    
    //5、 设置二维码的纠错水平 越高纠错水平越高，可以污损的范围越大
//    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    
    //5、 获得Image
    CIImage *CiImage = [filter outputImage];

    return [UIImage imageWithCIImage:CiImage];
}



//利用摄像图识别二维码中的内容
-(void)scanQRCode:(CGRect)scanRect{

    //1、实例化拍摄设备
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 2.设置输入设备
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    
    // 3. 设置元数据输出
    
    //3.1 实例化拍摄元数据输出
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
    
    // 3.2 设置输出数据代理
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 3.3设置扫描区域  坐标系为横屏下（逆时针转90度）
    // 范围为0-1
    CGFloat x = scanRect.origin.y / KHeight;
    CGFloat y = 1 - CGRectGetMaxX(scanRect) / Kwidth;
    CGFloat w = scanRect.size.height / KHeight;
    CGFloat h = scanRect.size.width / Kwidth;
    output.rectOfInterest = CGRectMake(x, y, w, h);
    

    
    
//4. 添加拍摄绘话
    
    //4.1 实例拍摄会话
    AVCaptureSession *session = [[AVCaptureSession alloc]init];
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    
    
    self.session = session;
    
    //4.2 添加绘画输入 输出
    if ([session canAddInput:input]) {
        [session addInput:input];
    }
    
    if ([session canAddOutput:output]) {
        NSLog(@"添加输出");
        [session addOutput:output];
    }
    
    
    // 4.3设置输出的数据类型，需要经将元数据输出添加到会话后，才能指定元数据类型，否则报错
    
    //    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    
    //5/实例化输出图层
    
    //5.1 实例化
    AVCaptureVideoPreviewLayer *preViewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:session];
    //    第1种模式AVLayerVideoGravityResizeAspect是按原视频比例显示，是竖屏的就显示出竖屏的，两边留黑；
    //    第2种AVLayerVideoGravityResizeAspectFill是以原比例拉伸视频，直到两边屏幕都占满，但视频内容有部分就被切割了；
    //    第3种AVLayerVideoGravityResize是拉伸视频内容达到边框占满，但不按原比例拉伸，这里明显可以看出宽度被拉伸了。
    
    // 5.2   适配时填充模式
    preViewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    preViewLayer.frame = self.view.bounds;
    
    // 5.3 经图层插入当前视图
    [self.view.layer  insertSublayer:preViewLayer atIndex:0];
    
    
    //6、 启动会话
    [self.session startRunning];
    

    [self.scanView startAnimation];
    
}



// 实现代理方法



//该代理方法会自己做判断，扫描区域内二维码的图形会不断走这个方法，当扫描其它空白的方时，不会走
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
 
    AVMetadataMachineReadableCodeObject *  object = [metadataObjects lastObject];
    
    if (!object) return;
    
    NSLog(@"已经扫描到数据:  %@", object.stringValue);
//    [self.session stopRunning];
    
    
    
    
    
}











@end
