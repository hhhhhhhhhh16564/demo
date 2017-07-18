//
//  BlueView.h
//  ReactiveCocoaf
//
//  Created by pro on 16/8/1.
//  Copyright © 2016年 zhl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"

@class RACSubject;
@interface BlueView : UIView

@property(nonatomic, strong) RACSubject *subject;

@end
