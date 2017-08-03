//
//  YBAudioDownLoader.h
//  视频播放&缓存
//
//  Created by 周磊 on 17/8/2.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YBYBAudioDownLoaderDelegate <NSObject>

-(void)downloading;

@end
@interface YBAudioDownLoader : NSObject

@property(nonatomic, weak) id<YBYBAudioDownLoaderDelegate> delegate;

@property (nonatomic,assign) long long totalSize;

@property (nonatomic,assign) long long loadedSize;

@property (nonatomic,assign) long long offset;

@property(nonatomic, strong) NSString *mimeType;

- (void)downLoadWithURL:(NSURL *)url offset:(long long)offset;



@end
