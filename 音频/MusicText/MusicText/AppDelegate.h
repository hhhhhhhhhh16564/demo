//
//  AppDelegate.h
//  MusicText
//
//  Created by pro on 16/8/7.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^remotoControlBlock)(UIEvent *);

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic, copy)remotoControlBlock remotoblock;


@end

