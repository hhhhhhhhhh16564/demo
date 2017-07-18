//
//  XMGLrcView.m
//  MusicText
//
//  Created by 周磊 on 16/8/8.
//  Copyright © 2016年 dfgsg. All rights reserved.
//

#import "XMGLrcView.h"
#import "Masonry.h"

#import "XMGLrcTool.h"
#import "XMGLrcLine.h"


#import "XMGLrcCell.h"

#import "XMGMusic.h"
#import "XMGMusicTool.h"
#import <MediaPlayer/MediaPlayer.h>


@interface XMGLrcView ()<UITableViewDataSource, UITableViewDelegate>


@property(nonatomic, strong) UITableView *tableView;

//歌词数组
@property(nonatomic, strong) NSArray *lrcList;

//记录当前刷新的某行
@property (nonatomic,assign) NSInteger currentIndex;


@end


@implementation XMGLrcView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       
        [self setupTableVeiw];

        
        
        
    }
    
    return self;
    
}


-(void)setupTableVeiw{
    
    //2. 改变tableView属性
    
  
    
    self.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.delegate = self;
    self.dataSource = self;

    self.scrollEnabled = NO;
    
    [self registerClass:[XMGLrcCell class] forCellReuseIdentifier:@"cell"];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    
    XMGLrcCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    XMGLrcLine *lrcline = self.lrcList[indexPath.row];
    
    
    cell.xmgline = lrcline;
    
    
    if (self.currentIndex == indexPath.row) {
        
        cell.lrcLabel.font = [UIFont systemFontOfSize:20];
        
    }else{
        
        cell.lrcLabel.font = [UIFont systemFontOfSize:14];
        cell.lrcLabel.progress = 0;
    }
    
   
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.lrcList.count;
}



-(void)setLrcName:(NSString *)lrcName{
    
    _lrcName = [lrcName copy];
//   [self setContentOffset:CGPointMake(0, -[UIScreen mainScreen].bounds.size.height*0.5+40) animated:NO];

    

    

    self.lrcList = [XMGLrcTool lrcToolWithLrcName:lrcName];
    
    NSLog(@"%ld", self.lrcList.count);
    
    [self reloadData];
    

    
    
}

-(void)setCurrentTime:(NSTimeInterval)currentTime{
    
    _currentTime = currentTime;
    
    NSInteger count = self.lrcList.count;
    
   
    for (NSInteger i = count-1; i >= 0; i--) {
        
        
        XMGLrcLine *LrcLine = self.lrcList[i];
        
        // 2.2取出下一句歌词
        NSInteger nextIndex = i + 1;
        XMGLrcLine *nextLrcLine = nil;
        if (nextIndex < self.lrcList.count) {
            nextLrcLine = self.lrcList[nextIndex];
        }
        

        
        if (LrcLine.time <= currentTime) {
            
            
            self.currentIndex = i;
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
            
            NSInteger lastindex = self.currentIndex -1;
            
            if (lastindex < 0) {
                lastindex = 1;
                
            }
            
            
            NSIndexPath *lastIndexpath = [NSIndexPath indexPathForRow:lastindex inSection:0];
            
            [self reloadRowsAtIndexPaths:@[indexpath,lastIndexpath] withRowAnimation:UITableViewRowAnimationNone];
            
            //滚动到中间
            [self scrollToRowAtIndexPath:indexpath atScrollPosition:(UITableViewScrollPositionMiddle) animated:YES];
            
            CGFloat value = (currentTime-LrcLine.time)/(nextLrcLine.time-LrcLine.time);

            
            //获取cell
            
            // 2.设置当前歌词播放的进度
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
            
            XMGLrcCell *lrcCell = [self cellForRowAtIndexPath:indexPath];
            
            
            lrcCell.lrcLabel.progress = value;

            
            break;
            
        }
        
    }
  
}

@end
