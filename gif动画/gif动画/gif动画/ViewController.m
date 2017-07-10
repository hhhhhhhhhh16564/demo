//
//  ViewController.m
//  gif动画
//
//  Created by 周磊 on 17/7/10.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "ViewController.h"

#import <ImageIO/ImageIO.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic, strong) UIImage *images;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor redColor];
}

- (IBAction)first:(UIButton *)sender {
    
}
- (IBAction)second:(id)sender {
}
- (IBAction)third:(id)sender {
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
    NSString *path = [[NSBundle mainBundle] pathForResource:@"demo.gif" ofType:nil];
    NSData *data = [[NSData alloc]initWithContentsOfFile:path];
    UIImage *image = [self imagesWithData:data];
    self.imageView.image = image;
    
}




-(UIImage *)imagesWithData:(NSData *)imageData{
    
    
    // 2.从data中读取数据: 将data转成CGImageSource对象
    CGImageSourceRef imagesource  = CGImageSourceCreateWithData((CFDataRef)imageData, nil);
    
    // 3.遍历所有的图片
    // 初始化一个装图片的数组
    NSMutableArray *imageSArray = [NSMutableArray array];
    
    int imageCount = (int)CGImageSourceGetCount(imagesource);
    
    NSTimeInterval frameDuration = 0;
    
    for (int i = 0; i < imageCount; i++) {
        // 3.1.取出图片
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(imagesource, i, nil);
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        [imageSArray addObject:image];
        if (i == 0) {
            self.imageView.image = image;
        }
        
        // 3.2.取出持续的时间
        CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(imagesource, i , nil);
        NSDictionary *frameProperties=(__bridge NSDictionary *)(cfFrameProperties);
        NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
        //从属性中 取出时间
        NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
        if (delayTimeUnclampedProp) {
            frameDuration += [delayTimeUnclampedProp floatValue];
        }
        else {
            NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
            if (delayTimeProp) {
                frameDuration += [delayTimeProp floatValue];
            }
        }
        CFRelease(cfFrameProperties);
        
    }
    
    CFRelease(imagesource);
    if (!frameDuration) {
        frameDuration = 1.0f/10.0f * imageCount;
    }
    
    return  [UIImage animatedImageWithImages:imageSArray duration:frameDuration];

}


















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
