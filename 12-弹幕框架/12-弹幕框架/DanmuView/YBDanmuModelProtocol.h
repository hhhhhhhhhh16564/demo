//
//  YBDanmuModelProtocol.h
//  12-弹幕框架
//
//  Created by yanbo on 17/8/8.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@protocol YBDanmuModelProtocol <NSObject>

/** 弹幕的开始时间 */
@property(nonatomic, readonly) NSTimeInterval beginTime;

/**  弹幕的存活时间*/
@property (nonatomic,readonly) NSTimeInterval liveTime;


@end
