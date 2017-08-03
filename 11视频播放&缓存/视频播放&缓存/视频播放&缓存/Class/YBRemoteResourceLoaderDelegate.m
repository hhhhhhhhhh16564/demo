//
//  YBRemoteResourceLoaderDelegate.m
//  视频播放&缓存
//
//  Created by 周磊 on 17/8/2.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "YBRemoteResourceLoaderDelegate.h"
#import "YBRemoteAudioFile.h"
#import "NSURL+SZ.h"
@interface YBRemoteResourceLoaderDelegate ()
@property (nonatomic, strong) NSMutableArray *loadingRequests;
@end


@implementation YBRemoteResourceLoaderDelegate
- (NSMutableArray *)loadingRequests {
    if (!_loadingRequests) {
        _loadingRequests = [NSMutableArray array];
    }
    return _loadingRequests;
}


- (BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForLoadingOfRequestedResource:(AVAssetResourceLoadingRequest *)loadingRequest {
    NSLog(@"%@\n\n\n\n", loadingRequest);

    
    // 1. 判断, 本地有没有该音频资源的缓存文件, 如果有 -> 直接根据本地缓存, 向外界响应数据(3个步骤) return
    NSURL *url = [loadingRequest.request.URL httpURL];
    long long requestOffset = loadingRequest.dataRequest.requestedOffset;
    long long currentOffset = loadingRequest.dataRequest.currentOffset;
    
    if (requestOffset != currentOffset) {
        requestOffset = currentOffset;
    }
    
    if ([YBRemoteAudioFile cacheFilePath:url]) {
        
        [self handleLoadingRequest:loadingRequest];
    }
    
    
    
    // 记录所有的请求
    [self.loadingRequests addObject:loadingRequest];
    
    //2. 判断有没有正在下载
    
    
    
    
    
    //3. 判断当前是否需要重新下载
    
    
    
    
    
    
    // 开始处理请求资源（在下载过程中，也要不听的判断）
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    return YES;
}


//处理， 本地已经下载好的资源文件
-(void)handleLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest{
    
    //1. 填充相应的头信息
    //计算总大小
    
    NSURL *url = loadingRequest.request.URL;
    long long totalSize = [YBRemoteAudioFile cacheFileSize:url];
    loadingRequest.contentInformationRequest.contentLength = totalSize;
    
    
    NSString *contentType = [YBRemoteAudioFile contentType:url];
    loadingRequest.contentInformationRequest.contentType = contentType;
    loadingRequest.contentInformationRequest.byteRangeAccessSupported = YES;
    
    
    //相应的数据给外界
    
//    参数NSDataReadingMappedIfSafe参数。使用这个参数后，iOS就不会把整个文件全部读取的内存了，而是将文件映射到进程的地址空间中，这么做并不会占用实际内存。这样就可以解决内存满的问题。
    NSData *data = [NSData dataWithContentsOfFile:[YBRemoteAudioFile cacheFilePath:url] options:NSDataReadingMappedIfSafe error:nil];
    
    
    long long requestOffset = loadingRequest.dataRequest.requestedOffset;
    NSInteger requestLength = loadingRequest.dataRequest.requestedLength;
    
    NSData *subData = [data subdataWithRange:NSMakeRange(requestOffset, requestLength)];
    
    [loadingRequest.dataRequest respondWithData:subData];
    
    
    //3. 完成本次请求(一旦，所有的数据都给完了，才能调用请求方法）
    [loadingRequest finishLoading];
    
    

}

















































- (void)resourceLoader:(AVAssetResourceLoader *)resourceLoader didCancelLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest{
    
}
@end
