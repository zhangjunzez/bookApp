//
//  LXScoreMarketViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/2.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXScoreMarketViewController.h"
#import "LXScoreMarkeDetailViewController.h"

#import "LXScoreMarketCollectionViewCell.h"
#import "SDCycleScrollView.h"

#import "LXMarketGoodsListModel.h"

@interface LXScoreMarketViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,SDCycleScrollViewDelegate>{
    CGFloat left;
    CGFloat space;
    
}
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,assign) NSInteger row;
@property (nonatomic,strong) UIImageView *bigImgView;
@property (nonatomic,strong) SDCycleScrollView *bannerView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger pageNum;
@end

@implementation LXScoreMarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.row = 2;
    [self.view addSubview:self.collectionView];
    self.title = @"积分商城";
    [self requstBigImgeRqust];
    [self.collectionView.mj_header beginRefreshing];
    self.view.backgroundColor = kMainBgColor;
    
    
    
}
#pragma mark - 播视图
-(SDCycleScrollView *)bannerView
{
    if (_bannerView==nil)
    {
        _bannerView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(ScaleW(0),-ScaleW(185), self.collectionView.width - ScaleW(30), ScaleW(170)) delegate:self placeholderImage:BUNDLE_PNGIMG(@"homePage", @"bannerDefult")];
        _bannerView.backgroundColor = [UIColor clearColor];
        _bannerView.pageControlAliment = SDCycleScrollViewPageContolStyleNone;
        _bannerView.localizationImageNamesGroup = @[@"defultLocalImg",@"defultLocalimg2"];
        _bannerView.autoScrollTimeInterval = 5.0;
        _bannerView.pageDotColor = kWhiteColor;
        _bannerView.currentPageDotColor = kRedColor;
        
    }
    
    return _bannerView;
}
-(UIImageView *)bigImgView{
    if (!_bigImgView) {
        _bigImgView = [[UIImageView alloc]initWithFrame:self.bannerView.frame];
        _bigImgView.backgroundColor = kGrayTxtColor;
        _bannerView.hidden = YES;
    }
    return _bigImgView;
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        
           left = ScaleW(15);
           space = ScaleW(10);
           _row = _row?:4;
           UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
           layout.itemSize = CGSizeMake((self.view.width - left * 2 - space * (_row - 1))/_row - 1,ScaleW(265));
           layout.minimumLineSpacing = space;
           layout.minimumInteritemSpacing = space;
           layout.scrollDirection = UICollectionViewScrollDirectionVertical;
           
           
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar) collectionViewLayout:layout];
           _collectionView.delegate = self;
           _collectionView.dataSource = self;
           [_collectionView registerClass:[LXScoreMarketCollectionViewCell class] forCellWithReuseIdentifier:@"LXScoreMarketCollectionViewCell"];
           _collectionView.contentInset = UIEdgeInsetsMake(ScaleW(185), left, 0, left);
           _collectionView.scrollEnabled = YES;
           self.collectionView.backgroundColor = kMainBgColor;
        //手势添加
        //此处给其增加长按手势，用此手势触发cell移动效果
        [self.view addSubview:_collectionView];
        [_collectionView addSubview:self.bigImgView];
        WS(weakSelf);
                     _collectionView.mj_header = [CustomGifHeader headerWithRefreshingBlock:^{
                             [weakSelf headerRefresh];
                     }];
                     _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                             [weakSelf footerRefresh];
                     }];
    }
    return _collectionView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LXScoreMarkeDetailViewController *vc = [[LXScoreMarkeDetailViewController alloc]init];
    LXMarketGoodsListModel *model = self.dataArray[indexPath.row];
    vc.goodsId = model.goodsid;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
        
    LXScoreMarketCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LXScoreMarketCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    //!self.urlClickBlock?:self.urlClickBlock(index);
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
#pragma mark ---获取封面图片
-(void)requstBigImgeRqust{
    [NetWorkTools postConJSONWithUrl:kGetimagesUrl parameters:@{@"type":@"6"} success:^(id responseObject) {
        NSString *result = responseObject[@"result"];
        NSString *resultNote = responseObject[@"resultNote"];
        NSString *datastr = responseObject[@"datastr"];
        if ([result integerValue] == 0) {
            [self.bigImgView sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:datastr]]];
        }else{
            [MBProgressHUD showError:resultNote];
        }
    } fail:^(NSError *error) {
        
    }];
}

-(NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
