//
//  YBRemoteResourceLoaderDelegate.m
//  视频播放&缓存
//
//  Created by 周磊 on 17/8/2.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "YBRemoteResourceLoaderDelegate.h"
#import "YBRemoteAudioFile.h"
#import "YBAudioDownLoader.h"
#import "NSURL+SZ.h"
@interface YBRemoteResourceLoaderDelegate ()<YBYBAudioDownLoaderDelegate>
@property (nonatomic, strong) NSMutableArray *loadingRequests;
@property(nonatomic, strong) YBAudioDownLoader *downLoader;
@end


@implementation YBRemoteResourceLoaderDelegate
- (NSMutableArray *)loadingRequests {
    if (!_loadingRequests) {
        _loadingRequests = [NSMutableArray array];
    }
    return _loadingRequests;
}
- (YBAudioDownLoader  *)downLoader {
    if (!_downLoader) {
        _downLoader = [[YBAudioDownLoader alloc] init];
        _downLoader.delegate = self;
    }
    return _downLoader;
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
    if (self.downLoader.loadedSize == 0) {
        
        [self.downLoader downLoadWithURL:url offset:requestOffset];
        // 开始下载数据（根据请求的信息， url, requestOffset, requestLeng
        return YES;
    }
    
    
    
    
    //3. 判断当前是否需要重新下载
    // 3.1 当前资源请求， 开始点 < 下载开始点
    // 3.2 当资源的请求， 开始点 > 下载的开始点 + 下载的长度 + 666
    if (requestOffset < self.downLoader.offset || requestOffset > (self.downLoader.offset + self.downLoader.loadedSize +666)) {
        
        [self.downLoader downLoadWithURL:url offset:requestOffset];
        
    }
    
    
    
    
    
    // 开始处理请求资源（在下载过程中，也要不听的判断）
    
    [self handleAllLoadingRequest];
    

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



-(void)handleAllLoadingRequest{
    
    NSMutableArray *deleteRequests = [NSMutableArray array];
    for (AVAssetResourceLoadingRequest * loadingRequest in self.loadingRequests) {
        // 1. 填充内容信息头
        NSURL *url = loadingRequest.request.URL;
        long long totalSize = self.downLoader.totalSize;
        
        loadingRequest.contentInformationRequest.contentLength = totalSize;
        
        NSString *contentType = self.downLoader.mimeType;
        loadingRequest.contentInformationRequest.contentType = contentType;
        loadingRequest.contentInformationRequest.byteRangeAccessSupported = YES;
        
        //2. 填充数据
        NSData *data = [NSData dataWithContentsOfFile:[YBRemoteAudioFile tmpFilePath:url] options:NSDataReadingMappedIfSafe error:nil];
        
        if (data == nil) {
            data = [NSData dataWithContentsOfFile:[YBRemoteAudioFile cacheFilePath:url] options:NSDataReadingMappedIfSafe error:nil];
        }
        long long requestOffset = loadingRequest.dataRequest.requestedOffset;
        long long currentOffset = loadingRequest.dataRequest.currentOffset;
        
        if (requestOffset != currentOffset) {
            requestOffset = currentOffset;
        }
        
        NSInteger requestLength = loadingRequest.dataRequest.requestedLength;
        
        long long responseOffset = requestOffset - self.downLoader.offset;
        
        long long responseLenght = MIN(self.downLoader.offset+self.downLoader.loadedSize-requestOffset, requestLength);
        
        
        NSData *subData = [data subdataWithRange:NSMakeRange(responseOffset, responseLenght)];
        
        [loadingRequest.dataRequest respondWithData:subData];
        
        // 完成请求后，求(必须把所有的关于这个请求的区间数据, 都返回完之后, 才能完成这个请求)
        
        if (responseLenght == responseLenght) {
            [loadingRequest finishLoading];
            [deleteRequests addObject:loadingRequest];
        }
        
        
    }
    
    
    
    [self.loadingRequests removeObjectsInArray:deleteRequests];

    
}













































- (void)resourceLoader:(AVAssetResourceLoader *)resourceLoader didCancelLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest{
    
}
@end
