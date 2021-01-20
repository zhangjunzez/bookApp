//
//  BookScoreMarketViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/7.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//


#import "BookScoreMarketViewController.h"
#import "LXScoreMarkeDetailViewController.h"
#import "BKScoreMingxiViewController.h"
#import "DJRecodsListViewController.h"
#import "BKJfsmViewController.h"

#import "BKScoreCollectionViewCell.h"
#import "SDCycleScrollView.h"

#import "LXMarketGoodsListModel.h"

@interface BookScoreMarketViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,SDCycleScrollViewDelegate>{
    CGFloat left;
    CGFloat space;
    
}
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,assign) NSInteger row;
@property (nonatomic,strong) UIImageView *bigImgView;
@property (nonatomic,strong) SDCycleScrollView *bannerView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic,strong) UILabel *jifenLabel;
@end

@implementation BookScoreMarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.row = 2;
    [self.view addSubview:self.collectionView];
    self.title = @"积分商城";
   
    [self.collectionView.mj_header beginRefreshing];
    self.view.backgroundColor = kMainBgColor;
    
    [self addRightNavItemWithTitle:@"兑换记录" color:kSubTxtColor font:systemFont(ScaleW(13))];
    
}
#pragma mark ----兑换记录
-(void)rigthBtnAction:(id)sender{
    DJRecodsListViewController *vc = [[DJRecodsListViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
        _bigImgView.image = [UIImage imageNamed:@"jifenbg"];
        _bigImgView.userInteractionEnabled = YES;
        UILabel *shopjifen = [WLTools allocLabel:@"积分商城 购物送积分" font:systemFont(ScaleW(17)) textColor:kWhiteColor frame:CGRectMake(ScaleW(14), ScaleW(14), ScaleW(200), ScaleW(17)) textAlignment:(NSTextAlignmentLeft)];
        NSString *string = shopjifen.text;
        NSMutableAttributedString *atts = [[NSMutableAttributedString alloc] initWithString:string];
        [atts setAttributes:@{ NSForegroundColorAttributeName:UIColorFromRGB(0xF7DDC8),NSFontAttributeName:systemFont(ScaleW(13))} range:NSMakeRange(string.length - 5,  5)];
        shopjifen.attributedText = atts;
        [_bigImgView addSubview:shopjifen];
        UIImageView *imgbg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(14), ScaleW(54), ScaleW(317), ScaleW(100))];
        imgbg.backgroundColor = kWhiteColor;
        UILabel *myscore = [WLTools allocLabel:@"我的积分" font:systemFont(ScaleW(13)) textColor:kSubTxtColor frame:CGRectMake(ScaleW(19), ScaleW(26), ScaleW(120), ScaleW(13)) textAlignment:(NSTextAlignmentLeft)];
        [imgbg addSubview:myscore];
        imgbg.userInteractionEnabled = YES;
        [_bigImgView addSubview:imgbg];
        
        _jifenLabel = [WLTools allocLabel:@"1000" font:systemBoldFont(ScaleW(25)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(20), ScaleW(8) + myscore.bottom, myscore.width, ScaleW(25)) textAlignment:(NSTextAlignmentLeft)];
        [imgbg addSubview:_jifenLabel];
        UIButton *jifenxize = [WLTools allocButtonTitle:@"积分细则" font:systemFont(ScaleW(12)) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(104), ScaleW(41), ScaleW(90), ScaleW(30)) sel:@selector(jifenxizeAction:) taget:self];
        jifenxize.backgroundColor = kRedColor;
        jifenxize.cornerRadius = jifenxize.height/2.f;
        [imgbg addSubview:jifenxize];
        UIButton *jifenguize = [WLTools allocButtonTitle:@"积分规则" font:systemFont(ScaleW(12)) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(16) + jifenxize.right, ScaleW(41), ScaleW(90), ScaleW(30)) sel:@selector(jifenguizeAction:) taget:self];
        [imgbg addSubview:jifenguize];
        jifenguize.backgroundColor = kGreenColor;
        jifenguize.cornerRadius = jifenguize.height/2.f;
    }
    return _bigImgView;
}
#pragma mark ----积分细则
-(void)jifenxizeAction:(UIButton *)sender
{
    BKScoreMingxiViewController *vc = [[BKScoreMingxiViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ----积分规则
-(void)jifenguizeAction:(UIButton *)sender
{
    BKJfsmViewController *vc = [[BKJfsmViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        
           left = ScaleW(15);
           space = ScaleW(10);
           _row = _row?:4;
           UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
           layout.itemSize = CGSizeMake((self.view.width - left * 2 - space * (_row - 1))/_row - 1,ScaleW(205));
           layout.minimumLineSpacing = space;
           layout.minimumInteritemSpacing = space;
           layout.scrollDirection = UICollectionViewScrollDirectionVertical;
           
           
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar) collectionViewLayout:layout];
           _collectionView.delegate = self;
           _collectionView.dataSource = self;
           [_collectionView registerClass:[BKScoreCollectionViewCell class] forCellWithReuseIdentifier:@"BKScoreCollectionViewCell"];
           _collectionView.contentInset = UIEdgeInsetsMake(ScaleW(185), left, 0, left);
           _collectionView.scrollEnabled = YES;
           self.collectionView.backgroundColor = kMainBgColor;
        //手势添加
        //此处给其增加长按手势，用此手势触发cell移动效果
        [self.view addSubview:_collectionView];
        [_collectionView addSubview:self.bigImgView];
        WS(weakSelf);
                     _collectionView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
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
    return 2;
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
        
    BKScoreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BKScoreCollectionViewCell" forIndexPath:indexPath];
    //cell.model = self.dataArray[indexPath.row];
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
    
   
    
    // [SSKJ_NoDataView showNoData:self.dataArray.count toView:self.collectionView offY:ScaleW(10) message:@"您还没有数据哦~" imge:[UIImage imageNamed:@"nolikesimg"]];
    
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
