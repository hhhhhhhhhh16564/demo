//
//  YBAudioDownLoader.m
//  视频播放&缓存
//
//  Created by 周磊 on 17/8/2.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "YBAudioDownLoader.h"
#import "YBRemoteAudioFile.h"

@interface YBAudioDownLoader ()
@property(nonatomic, strong) NSURLSession *session;

@property(nonatomic, strong) NSOutputStream *outputStream;
@property(nonatomic, strong) NSURL *url;
@end

@implementation YBAudioDownLoader
- (void)downLoadWithURL:(NSURL *)url offset:(long long)offset{
    
    
    
}

@end
