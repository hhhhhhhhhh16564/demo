//
//  YBAudioDownLoader.m
//  视频播放&缓存
//
//  Created by 周磊 on 17/8/2.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "YBAudioDownLoader.h"
#import "YBRemoteAudioFile.h"

@interface YBAudioDownLoader ()<NSURLSessionDataDelegate>
@property(nonatomic, strong) NSURLSession *session;

@property(nonatomic, strong) NSOutputStream *outputStream;
@property(nonatomic, strong) NSURL *url;
@end

@implementation YBAudioDownLoader

-(NSURLSession *)session{
    if (!_session) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
    
}


-(void)downLoadWithURL:(NSURL *)url offset:(long long)offset{
    
    [self cancelAndClean];
    self.url = url;
    
    self.offset = offset;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:0];
 
 
    [request setValue:[NSString stringWithFormat:@"bytes=%lld-", offset] forHTTPHeaderField:@"Range"];
    
    
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request];
    [task resume];
}


-(void)cancelAndClean{
    // 取消
    [self.session invalidateAndCancel];
    self.session = nil;
    
    
    //清空临时文件
    [YBRemoteAudioFile clearTmpFile:self.url];
    
    
    //重置数据
    self.loadedSize = 0;
    
    
}




#pragma mark -NSURLSessionDAtaDelegate
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSHTTPURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{

    NSLog(@"%@", response.allHeaderFields);
    
    //1. 当从开头下载时，从 Content-Length取出来
    //    {
    //        "Accept-Ranges" = bytes;
    //        "Content-Length" = 9071810;
    //        "Content-Type" = "video/mp4";
    //        Date = "Mon, 14 Aug 2017 10:17:08 GMT";
    //        Etag = "W/\"9071810-1409456092000\"";
    //        "Last-Modified" = "Sun, 31 Aug 2014 03:34:52 GMT";
    //        Server = "Apache-Coyote/1.1";
    //    }
    
    
    //2. 从指定范围下载时 从1100开始下载 Content-Range有，应该从Content-Range里边获取
//    {
//        "Accept-Ranges" = bytes;
//        "Content-Length" = 9070710;
//        "Content-Range" = "bytes 1100-9071809/9071810";
//        "Content-Type" = "video/mp4";
//        Date = "Mon, 14 Aug 2017 10:25:31 GMT";
//        Etag = "W/\"9071810-1409456092000\"";
//        "Last-Modified" = "Sun, 31 Aug 2014 03:34:52 GMT";
//        Server = "Apache-Coyote/1.1";
//    }
    
    
    
    self.totalSize = [response.allHeaderFields[@"Content-Length"] longLongValue];
    NSString *contentRangeStr = response.allHeaderFields[@"Content-Range"];
    
    if (contentRangeStr.length != 0) {
        self.totalSize = [[contentRangeStr componentsSeparatedByString:@"/"].lastObject longLongValue];
    }
    
    self.outputStream = [NSOutputStream outputStreamToFileAtPath:[YBRemoteAudioFile tmpFilePath:self.url] append:YES];
    [self.outputStream open];
    
    completionHandler(NSURLSessionResponseAllow);
    
    
}

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    
    self.loadedSize += data.length;
    [self.outputStream write:data.bytes maxLength:data.length];
    if ([self.delegate respondsToSelector:@selector(downloading)]) {
        [self.delegate downloading];
    }
    
    
}



-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    
    if (error == nil) {
        NSURL *url = self.url;
        if ([YBRemoteAudioFile tmpFileSize:url] == self.totalSize) {
            
            [YBRemoteAudioFile moveTmpPathToCachePath:url];
        }
        
    }else{
        
        NSLog(@"有错误");
    }
    
    
    
    
}

















@end
