//
//  BkGoodsDetailViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/13.
//  Copyright © 2021 zhangbenchao. All rights reserved.


#import "BkGoodsDetailViewController.h"
#import "BkAgeListViewController.h"
#import "BkCommitOrderViewController.h"
#import "BkMoreCommedViewController.h"
#import "BkAuthorDetailViewController.h"

#import "BkGoodsCollectionViewCell.h"
#import "BkGoodsBuyBottomView.h"
#import "LXMarketGoodsListModel.h"

#import "BkGoodsDetailHeaderView.h"

@interface BkGoodsDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>{
    CGFloat left;
    CGFloat space;
    
}
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,assign) NSInteger row;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic,strong) BkGoodsDetailHeaderView *headerView;
@property (nonatomic,strong) BkGoodsBuyBottomView *bottomView;
@end

@implementation BkGoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.row = 2;
    [self.view addSubview:self.collectionView];
   
    //[self.collectionView.mj_header beginRefreshing];
    self.view.backgroundColor = kSubBacColor;
    
    [self.view addSubview:self.bottomView];
    self.title = @"商品详情";
    [self navigationConfig];
}
-(BkGoodsBuyBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[BkGoodsBuyBottomView alloc]init];
        _bottomView.top = _collectionView.bottom;
        WS(weakSelf);
        _bottomView.buyBlock = ^{
            BkCommitOrderViewController *vc = [[BkCommitOrderViewController alloc]init];
            [weakSelf naviPushVc:vc];
        };
    }
    return _bottomView;
}
-(void)navigationConfig{
    [self addRightNavgationItemWithImage:[UIImage imageNamed:@"分享"]];
   
}


#pragma mark --分享事件
-(void)rigthBtnAction:(id)sender{
    
}

-(BkGoodsDetailHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[BkGoodsDetailHeaderView alloc]init];
        _headerView.top = -_headerView.height-ScaleW(10);
        WS(weakSelf);
        _headerView.moreConmendBlock = ^{
            BkMoreCommedViewController *vc = [[BkMoreCommedViewController alloc]init];
            [weakSelf naviPushVc:vc];
        };
        _headerView.authorBlock = ^{
            BkAuthorDetailViewController *vc = [BkAuthorDetailViewController alloc];
            [weakSelf naviPushVc:vc];
        };
    }
    return _headerView;
}
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        
           left = ScaleW(15);
           space = ScaleW(10);
           _row = _row?:4;
           UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
           layout.itemSize = CGSizeMake((self.view.width - left * 2 - space * (_row - 1))/_row - 1,ScaleW(233));
           layout.minimumLineSpacing = space;
           layout.minimumInteritemSpacing = space;
           layout.scrollDirection = UICollectionViewScrollDirectionVertical;
           
           
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar- ScaleW(50)) collectionViewLayout:layout];
           _collectionView.delegate = self;
           _collectionView.dataSource = self;
           [_collectionView registerClass:[BkGoodsCollectionViewCell class] forCellWithReuseIdentifier:@"BkGoodsCollectionViewCell"];
        _collectionView.contentInset = UIEdgeInsetsMake(self.headerView.height + ScaleW(10), left, ScaleW(10), left);
           _collectionView.scrollEnabled = YES;
           _collectionView.backgroundColor = kSubBacColor;
        _collectionView.contentOffset = CGPointMake(0, -self.headerView.height-ScaleW(10));
        //手势添加
        //此处给其增加长按手势，用此手势触发cell移动效果
        [self.view addSubview:_collectionView];
        [_collectionView addSubview:self.headerView];
        WS(weakSelf);
                     _collectionView.mj_header = [CustomGifHeader headerWithRefreshingBlock:^{
                             [weakSelf headerRefresh];
                     }];
        _collectionView.mj_header.hidden = YES;
                     _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                             [weakSelf footerRefresh];
                     }];
    }
    return _collectionView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    BkGoodsDetailViewController *vc = [[BkGoodsDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
        
    BkGoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BkGoodsCollectionViewCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = kWhiteColor;
   // cell.model = self.dataArray[indexPath.row];
    return cell;
}


/** 图片滚动回调 */
-(void)collectListReq
{
    NSDictionary * pamas = @{@"nowPage":[NSString stringWithFormat:@"%ld",self.pageNum],@"pageCount":[NSString stringWithFormat:@"%d",kPage_Size]};
    [NetWorkTools postConJSONWithUrl:kGetgoodslistUrl parameters:pamas success:^(id responseObject) {
        NSString *result = responseObject[@"result"];
        NSString *resultNote = responseObject[@"resultNote"];
        NSArray *array = responseObject[@"dataList"];
        NSMutableArray *muArray = [NSMutableArray array];
        if (result.integerValue == 0) {
            for (NSDictionary *dic  in array) {
                LXMarketGoodsListModel *model = [[LXMarketGoodsListModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [muArray addObject:model];
            }
            [self handleListWithModel:muArray];
        }else{
             [MBProgressHUD showError:resultNote];
        }
         
    } fail:^(NSError *error) {
        
    }];

}
#pragma mark - 上拉、下拉

-(void)headerRefresh
{
    self.pageNum = 1;
    [self collectListReq];
    
}

-(void)footerRefresh
{
    [self collectListReq];
}
-(void)endRefrash

{
   if (self.collectionView.mj_header.state == MJRefreshStateRefreshing) {
        [self.collectionView.mj_header endRefreshing];
    }
    
    if (self.collectionView.mj_footer.state == MJRefreshStateRefreshing) {
        [self.collectionView.mj_footer endRefreshing];
    }
}
-(void)handleListWithModel:(id )result
{
    [self endRefrash];

    NSArray *array = result;
    if (self.pageNum == 1) {
        [self.dataArray removeAllObjects];
    }
    
    [self.dataArray addObjectsFromArray:array];
    
   
    
     [SSKJ_NoDataView showNoData:self.dataArray.count toView:self.collectionView offY:ScaleW(10) message:@"您还没有数据哦~" imge:[UIImage imageNamed:@"nolikesimg"]];
    
    self.pageNum++;
    
    
    [self.collectionView reloadData];
    
    if (array.count != kPage_Size) {
        self.collectionView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{

        self.collectionView.mj_footer.state = MJRefreshStateIdle;
    }
}


-(NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
