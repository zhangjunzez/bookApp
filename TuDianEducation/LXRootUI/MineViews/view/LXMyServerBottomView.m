//
//  LXMyServerBottomView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/1.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXMyServerBottomView.h"
#import "LXServerDetailModel.h"
#define kTag(a) 100000000 + a
@interface LXMyServerBottomView()
@property (nonatomic,strong) UILabel *goodsNameLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UILabel *serverNameLabel;
@property (nonatomic,strong) UILabel *detailServerLabel;
@property (nonatomic,strong) NSArray *contenImgArray;
@property (nonatomic,strong) NSMutableArray *uiArray;
@end

@implementation LXMyServerBottomView

-(instancetype)init
{
    if (self = [super init])
    {
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig{
    self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(100));
    self.backgroundColor = kWhiteColor;
    [self addSubview:self.serverNameLabel];
    [self addSubview:self.detailServerLabel];
    [self addSubview:self.goodsNameLabel];
    [self addSubview:self.detailLabel];
    self.contenImgArray = @[@""];
    
}
-(UILabel *)serverNameLabel{
    if (!_serverNameLabel) {
        _serverNameLabel = [WLTools allocLabel:@"服务简介" font:systemBoldFont(ScaleW(15)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), ScaleW(20), ScreenWidth - ScaleW(15) * 2, ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _serverNameLabel;
}

-(UILabel *)detailServerLabel
{
    if (!_detailServerLabel) {
        _detailServerLabel = [WLTools allocLabel:@"比纳颜色分类: 亏本冲量 领券立减50 咨询客服有好礼 黑色特惠基础款 144档健身调节 不稳包退 柠檬黄特惠基础款 144档健身调节 不稳包退 黑色加粗珍藏款适用身高1.3-1.9米 承重测试600斤 不稳包退 柠檬黄加粗珍藏款 适用身高1.3-1.9米 承重测试600斤 不稳包退上市时间: 2017年冬季货号: BN-XKYWB" font:systemFont(ScaleW(14)) textColor:kSubTxtColor frame:CGRectMake(_serverNameLabel.left, _serverNameLabel.bottom + ScaleW(22), _serverNameLabel.width, ScaleW(50)) textAlignment:(NSTextAlignmentLeft)];
        _detailServerLabel.numberOfLines = 0;
        [_detailServerLabel sizeToFit];
    }
    return _detailServerLabel;
}
-(UILabel *)goodsNameLabel{
    if (!_goodsNameLabel) {
        _goodsNameLabel = [WLTools allocLabel:@"详情内容" font:systemBoldFont(ScaleW(15)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), ScaleW(20) + _detailServerLabel.bottom, ScreenWidth - ScaleW(15) * 2, ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _goodsNameLabel;
}

-(UILabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel = [WLTools allocLabel:@"比纳颜色分类: 亏本冲量 领券立减50 咨询客服有好礼 黑色特惠基础款 144档健身调节 不稳包退 柠檬黄特惠基础款 144档健身调节 不稳包退 黑色加粗珍藏款适用身高1.3-1.9米 承重测试600斤 不稳包退 柠檬黄加粗珍藏款 适用身高1.3-1.9米 承重测试600斤 不稳包退上市时间: 2017年冬季货号: BN-XKYWB" font:systemFont(ScaleW(14)) textColor:kSubTxtColor frame:CGRectMake(_goodsNameLabel.left, _goodsNameLabel.bottom + ScaleW(22), _goodsNameLabel.width, ScaleW(50)) textAlignment:(NSTextAlignmentLeft)];
        _detailLabel.numberOfLines = 0;
        [_detailLabel sizeToFit];
    }
    return _detailLabel;
}
-(NSMutableArray *)uiArray{
    if (!_uiArray) {
        _uiArray = [NSMutableArray array];
    }
    return _uiArray;
}

-(void)setContenImgArray:(NSArray *)contenImgArray{
    _contenImgArray = contenImgArray;
    for (UIView * v in self.uiArray) {
        [v removeFromSuperview];
    }
    WS(weakSelf);
       dispatch_group_t group = dispatch_group_create();
       dispatch_queue_t searialQueue = dispatch_queue_create("com.hmc.www", DISPATCH_QUEUE_SERIAL);
    for (int i = 0; i < _contenImgArray.count; i ++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(_detailLabel.left, _detailLabel.bottom + ScaleW(15) + _detailLabel.width*i , ScreenWidth - ScaleW(15) * 2, _detailLabel.width)];
        imgView.backgroundColor = kBlueColor;
        [self addSubview:imgView];
        imgView.tag = kTag(i);
        NSString *url = [WLTools imageURLWithURL:_contenImgArray[i]];
        [self.uiArray addObject:imgView];
        dispatch_group_enter(group);
           dispatch_group_async(group, searialQueue, ^{
               // 网络请求二
               [imgView sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                         
                          if (image == nil) {
                              imgView.hidden = YES;
                              imgView.height = CGFLOAT_MIN;
                          }else{
                              imgView.hidden = NO;
                              imgView.image = image;
                              imgView.height = (image.size.height/image.size.width)*imgView.width;
                          }
                          dispatch_group_leave(group);
                      }];
           });
    }
    dispatch_group_notify(group, searialQueue, ^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                // 刷新UI
                [weakSelf reloadFrame];
            });
        });
    });
    
    
}
-(void)setModel:(LXServerDetailModel *)model{
    _model = model;
    self.detailLabel.text = _model.servicescontent;
    [self.detailLabel sizeToFit];
    self.contenImgArray = _model.detailimages;
    self.detailServerLabel.text = _model.servicesintroduction;
    [self.detailServerLabel sizeToFit];
    
}
#pragma mark - 单个页面多个网络请求的情况(依次调用接口)，等待所有网络请求结束后，再刷新UI
-(void)reloadFrame
{
    _goodsNameLabel.top = ScaleW(20) + _detailServerLabel.bottom;
    _detailLabel.top = _goodsNameLabel.bottom + ScaleW(20);
    CGFloat top = _detailLabel.bottom + ScaleW(10);
    for (int i = 0; i < self.contenImgArray.count; i ++) {
        UIImageView *imgView = [self viewWithTag:kTag(i)];
        imgView.top = top;
        top += imgView.height + ScaleW(10);
    }
    UIImageView *img = self.uiArray.lastObject;
    self.height = img.bottom + ScaleW(50);
    !self.reloadFrameBlcok?:self.reloadFrameBlcok();
}

@end
