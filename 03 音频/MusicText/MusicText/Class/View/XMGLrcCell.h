//
//  XMGLrcCell.h
//  04-QQMusic
//
//  Created by xiaomage on 15/12/18.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMGLrcLine.h"

#import "XMGLrcLabel.h"
@interface XMGLrcCell : UITableViewCell


/** lrcLabel */
@property (nonatomic, strong) XMGLrcLabel *lrcLabel;

@property(nonatomic, strong) XMGLrcLine *xmgline;

@end
