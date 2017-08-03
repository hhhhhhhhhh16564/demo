//
//  YBRemoteAudioFile.m
//  视频播放&缓存
//
//  Created by 周磊 on 17/8/2.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "YBRemoteAudioFile.h"
#import <MobileCoreServices/MobileCoreServices.h>
#define kCachePath NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject
#define kTmpPath NSTemporaryDirectory()
@implementation YBRemoteAudioFile

// 下载完成 -> cache + 文件名称
+ (NSString *)cacheFilePath:(NSURL *)url {
    return [kCachePath stringByAppendingPathComponent:url.lastPathComponent];
}


+ (long long)cacheFileSize:(NSURL *)url {
    
    // 1.2 计算文件路径对应的文件大小
    if (![self cacheFileExists:url]) {
        return 0;
    }
    // 1.1 获取文件路径
    NSString *path = [self cacheFilePath:url];
    NSDictionary *fileInfoDic = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    return  [fileInfoDic[NSFileSize] longLongValue];
}


+ (BOOL)cacheFileExists:(NSURL *)url {
    
    NSString *path = [self cacheFilePath:url];
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}



+ (NSString *)tmpFilePath:(NSURL *)url {
    return [kTmpPath stringByAppendingPathComponent:url.lastPathComponent];
}
// 下载中 -> tmp + 文件名称
+ (long long)tmpFileSize:(NSURL *)url {
    // 1.2 计算文件路径对应的文件大小
    if (![self tmpFileExists:url]) {
        return 0;
    }
    // 1.1 获取文件路径
    NSString *path = [self tmpFilePath:url];
    NSDictionary *fileInfoDic = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    return  [fileInfoDic[NSFileSize] longLongValue];
}


+ (BOOL)tmpFileExists:(NSURL *)url {
    NSString *path = [self tmpFilePath:url];
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (void)clearTmpFile:(NSURL *)url {
    NSString *tmpPath = [self tmpFilePath:url];
    BOOL isDirectory = YES;
    BOOL isEx = [[NSFileManager defaultManager] fileExistsAtPath:tmpPath isDirectory:&isDirectory];
    if (isEx && !isDirectory) {
        [[NSFileManager defaultManager] removeItemAtPath:tmpPath error:nil];
    }
    
}




+ (NSString *)contentType:(NSURL *)url {
    
    NSString *path = [self cacheFilePath:url];
    NSString *fileExtension = path.pathExtension;
    
    CFStringRef contentTypeCF = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef _Nonnull)(fileExtension), NULL);
    NSString *contentType = CFBridgingRelease(contentTypeCF);
    
    return contentType;
    
}


+ (void)moveTmpPathToCachePath:(NSURL *)url {
    
    NSString *tmpPath = [self tmpFilePath:url];
    NSString *cachePath = [self cacheFilePath:url];
    [[NSFileManager defaultManager] moveItemAtPath:tmpPath toPath:cachePath error:nil];
    
    
    
}

@end
