//
//  BookMovieViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/6.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BookMovieViewController.h"
#import "BkGoodsDetailViewController.h"
#import "LXMessageViewController.h"

#import "BkGoodsCollectionViewCell.h"
#import "BkMovieSelectView.h"

#import "LXMarketGoodsListModel.h"
#import "BkFaceControlView.h"

@interface BookMovieViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>{
    CGFloat left;
    CGFloat space;
    
}
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,assign) NSInteger row;
@property (nonatomic,strong) UIImageView *bigImgView;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic,strong) BkFaceControlView *faceHeaderView;
@property (nonatomic,strong) BkMovieSelectView *selcetView;

@property (nonatomic,strong) UITextField *searchTextFiled;
@property (nonatomic,strong) UIImageView *searchImg;
@end

@implementation BookMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.row = 2;
    [self.view addSubview:self.faceHeaderView];
    [self.view addSubview:self.selcetView];
    [self.view addSubview:self.collectionView];
   
    //[self.collectionView.mj_header beginRefreshing];
    self.view.backgroundColor = kWhiteColor;
    
    
    
    [self navigationConfig];
}
-(void)navigationConfig{
    self.navigationItem.titleView = self.searchTextFiled;
    [self addRightNavgationItemWithImage:[UIImage imageNamed:@"wuxiaoxi"]];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(28), ScaleW(28))];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(28), ScaleW(28))];
    imageView.image = [UIImage imageNamed:@"logo"];
    [view addSubview:imageView];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.leftBarButtonItem = leftItem;
}
-(BkFaceControlView *)faceHeaderView{
    if (!_faceHeaderView) {
        _faceHeaderView = [[BkFaceControlView alloc]initWithTop:0 titleArray:@[@"启蒙教育",@"儿童文学",@"科普百科",@"教辅题材"]];
        _faceHeaderView.btnClickedBlock = ^(NSInteger index) {
            
        };
    }
    return _faceHeaderView;
}
-(BkMovieSelectView *)selcetView{
    if (!_selcetView) {
        _selcetView = [[BkMovieSelectView alloc]init];
        _selcetView.top = _faceHeaderView.bottom;
    }
    return _selcetView;
}
#pragma mark ---个人信息事件
-(void)leftBtnAction:(id)sender{
    
}
#pragma mark --消息事件
-(void)rigthBtnAction:(id)sender{
    LXMessageViewController *vc = [[LXMessageViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(UITextField *)searchTextFiled{
    if (!_searchTextFiled) {
        _searchTextFiled = [WLTools allocTextFieldTextFont:ScaleW(14) placeHolderFont:ScaleW(14) text:nil placeText:@"请输入商品名称进行搜索" textColor:kMainTxtColor placeHolderTextColor:kGrayTxtColor frame:CGRectMake(ScaleW(12), ScaleW(10),ScaleW(260), ScaleW(27))];
        _searchTextFiled.cornerRadius = _searchTextFiled.height/2.f;
        _searchTextFiled.leftViewMode = UITextFieldViewModeAlways;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(34), _searchTextFiled.height)];
        [view addSubview:self.searchImg];
        _searchTextFiled.leftView = view;
        _searchTextFiled.backgroundColor = kMainBgColor;
        _searchTextFiled.delegate = self;
    }
    return _searchTextFiled;
}
-(UIImageView *)searchImg{
    if (!_searchImg) {
        _searchImg = [[UIImageView alloc ]initWithFrame:CGRectMake(ScaleW(15), ScaleW(9), ScaleW(12), ScaleW(12))];
        _searchImg.image = [[UIImage imageNamed:@"搜索"] imageChangeColor:kMainTxtColor];
        _searchImg.centerY = _searchTextFiled.height/2.f;
    }
    return _searchImg;
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
           
           
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _selcetView.bottom, ScreenWidth, ScreenHeight - Height_NavBar-Height_TabBar-_selcetView.bottom) collectionViewLayout:layout];
           _collectionView.delegate = self;
           _collectionView.dataSource = self;
           [_collectionView registerClass:[BkGoodsCollectionViewCell class] forCellWithReuseIdentifier:@"BkGoodsCollectionViewCell"];
        _collectionView.contentInset = UIEdgeInsetsMake(0, left, 0, left);
           _collectionView.scrollEnabled = YES;
           self.collectionView.backgroundColor = kWhiteColor;
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
    BkGoodsDetailViewController *vc = [[BkGoodsDetailViewController alloc]init];
  
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
        
    BkGoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BkGoodsCollectionViewCell" forIndexPath:indexPath];
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
