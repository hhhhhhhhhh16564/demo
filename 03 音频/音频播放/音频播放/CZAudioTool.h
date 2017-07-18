//
//  CZAudioTool.h
//  音频播放
//
//  Created by pro on 16/8/3.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@interface CZAudioTool : NSObject

singleton_interface(CZAudioTool)


-(void)playMp3WithName:(NSString *)mp3Name;
@end
