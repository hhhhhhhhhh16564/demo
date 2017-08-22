//
//  ViewController.m
//  按钮点击页面切换
//
//  Created by 周磊 on 17/7/13.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "ViewController.h"
#import "YBTitleStytle.h"
#import "YBPageView.h"
#import "YBPageCollectionView.h"
#import "YBCollectionViewFlowLayout.h"
@interface ViewController ()<YBCollectionViewFlowLayoutDelegate, YBPageCollectionViewDataSoruce>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self text2];

}


-(void)text1{
    
    YBTitleStytle  *style = [[YBTitleStytle alloc]init];
    style.isScrollEndble = YES;
    NSArray *titleArray = @[@"语文", @"数学个地方官的双方各", @"化学生物", @"鹦鹉十多个电饭锅电饭锅", @"孙悟空发送分散", @"语文", @"数学", @"化学生物", @"鹦鹉", @"孙悟发顺丰萨达是否空"];
    //    titleArray = @[@"语文", @"数学", @"英语"];
    NSMutableArray *childVcArray = [NSMutableArray array];
    
    for (int i = 0; i < titleArray.count; i++) {
        UIViewController *Vc = [[UIViewController alloc]init];
        
        [childVcArray addObject:Vc];
    }
    
    CGRect rect = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20);
    
    YBPageView *pageView = [[YBPageView alloc]initWithFrame:rect stytle:style titles:titleArray childVcs:childVcArray parentVc:self];
    
    [self.view addSubview:pageView];
  

}
-(void)text2{
    
    YBTitleStytle *style = [[YBTitleStytle alloc]init];
    style.isScrollEndble = NO;
    NSArray *titleArray = @[@"腾通", @"新浪", @"阿里巴巴", @"京东"];
    
    YBCollectionViewFlowLayout *layout = [[YBCollectionViewFlowLayout alloc]init];
    layout.flowoutDelegate = self;
    
    YBPageCollectionView *collectionView = [[YBPageCollectionView alloc]initWithFrame:CGRectMake(30, 100, 300, 250) titleStyle:style titles:titleArray isTitleTop:YES layout:layout];
    
    collectionView.dataSource = self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"1111"];
    
    
    [self.view addSubview:collectionView];
    

    

    
    
}

#pragma mark YBCollectionViewFlowLayoutDelegate
-(NSInteger)rowCountInWaterFlowLayout:(YBCollectionViewFlowLayout *)flowLayout{
    
    return 3;
}

-(NSInteger)columnCountInWaterFlowLayout:(YBCollectionViewFlowLayout *)flowLayout{
    
    return 4;
}


#pragma mark YBPageCollectionViewDataSoruce
- (__kindof UICollectionViewCell *)pageCollectionView:(YBPageCollectionView *)pagecollectionView  collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"1111" forIndexPath:indexPath];
    UILabel *label = nil;
        for (UIView *vvv in cell.subviews) {
    
            if ([vvv isKindOfClass:[UILabel class]]) {
                label = (UILabel *)vvv;
            }
    
        }
    
    
    
        if (label == nil) {
            label = [[UILabel alloc]init];
            label.frame = cell.bounds;
            label.numberOfLines = 2;
            [cell addSubview:label];
    
    
        }
    //    label = [[UILabel alloc]init];
    
        label.text = [NSString stringWithFormat:@"section %zd   row: %zd ", indexPath.section, indexPath.row];

    return cell;
    
}

- (NSInteger)numberOfSectionsInPageCollectionView:(YBPageCollectionView *)pageCollectionView{
    
    return 4;
}

-(NSInteger)pageCollectionView:(YBPageCollectionView *)pagecollectionView numberOfItemsInSection:(NSInteger)section{
    
    return 35;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
