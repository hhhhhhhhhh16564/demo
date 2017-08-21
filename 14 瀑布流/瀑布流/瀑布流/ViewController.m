//
//  ViewController.m
//  瀑布流
//
//  Created by yanbo on 17/8/18.
//  Copyright © 2017年 zhl. All rights reserved.
//

#import "ViewController.h"
#import "YBCollectionViewCell.h"
#import "YBShop.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "YBCollectionViewFlowLayout.h"
@interface ViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource,YBCollectionViewFlowLayoutDelegate>

@property(nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController
static NSString * const XMGShopId = @"shop";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *shops = [YBShop objectArrayWithFilename:@"1.plist"];
    self.dataArray = [shops mutableCopy];
    [self setUI];
}


-(void)setUI{
    
//    NSString *str = @"http://s6.mogujie.cn/b7/bao/131011/gs50h_kqyvc2czkfbegwlwgfjeg5sckzsew_500x700.jpg_200x999.jpg";
//    
//    UIImageView *imv = [[UIImageView alloc]init];
//    imv.frame = CGRectMake(100, 100, 150, 200);
//    imv.backgroundColor = [UIColor redColor];
//    [self.view addSubview:imv];
//    
//    [imv sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:nil];
    
    
    
    
//    return;
    
    
    
    
    YBCollectionViewFlowLayout *flowout = [[YBCollectionViewFlowLayout alloc]init];
    flowout.flowoutDelegate = self;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"YBCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:XMGShopId];
    
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YBCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:XMGShopId forIndexPath:indexPath];
    
    cell.shop = self.dataArray[indexPath.row];
    return cell;
    
}




#pragma mark 代理方法



-(CGFloat)itemHeightInWaterFlowLayout:(YBCollectionViewFlowLayout *)flowLayout atIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth{
    
    YBShop *shop = self.dataArray[indexPath.item];
    
    CGFloat height = shop.h/shop.w*itemWidth;
 
    return height;
}
// 共有多少列
-(NSInteger)columnCountInWaterFlowLayout:(YBCollectionViewFlowLayout *)flowLayout{
    
    return 3;
}

//行间距
-(CGFloat)rowMarginInWaterFlowLayout:(YBCollectionViewFlowLayout *)flowLayout{
    return 20;
}

//列间距
-(CGFloat)columnMarginInWaterFlowLayout:(YBCollectionViewFlowLayout *)flowLayout{
    
    return 30;
}

// 上下左右距离
-(UIEdgeInsets)edgeInWaterFlowLayout:(YBCollectionViewFlowLayout *)flowLayout{
    
    return UIEdgeInsetsMake(10, 50, 30, 40);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
