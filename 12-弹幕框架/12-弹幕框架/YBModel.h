//
//  YBModel.h
//  12-弹幕框架
//
//  Created by yanbo on 17/8/9.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YBDanmuModelProtocol.h"
@interface YBModel : NSObject<YBDanmuModelProtocol>
/** 弹幕的开始时间 */
@property(nonatomic, assign) NSTimeInterval beginTime;

/**  弹幕的存活时间*/
@property (nonatomic,assign) NSTimeInterval liveTime;


@property(nonatomic, strong) NSString *content;
@end
