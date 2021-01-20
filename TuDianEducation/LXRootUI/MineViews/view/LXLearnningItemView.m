//
//  LXLearnningItemView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/2.
//  Copyright © 2020 zhangbenchao. All rights reserved.

#import "LXLearnningItemView.h"
@interface LXLearnningItemView()
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UIImageView *contentImg;

@end

@implementation LXLearnningItemView

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
    [self addSubview: self.contentImg];
    [self addSubview:self.detailLabel];
  
}


-(UILabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel = [WLTools allocLabel:@"比纳颜色分类: 亏本冲量 领券立减50 咨询客服有好礼 黑色特惠基础款 144档健身调节 不稳包退 柠檬黄特惠基础款 144档健身调节 不稳包退 黑色加粗珍藏款适用身高1.3-1.9米 承重测试600斤 不稳包退 柠檬黄加粗珍藏款 适用身高1.3-1.9米 承重测试600斤 不稳包退上市时间: 2017年冬季货号: BN-XKYWB" font:systemFont(ScaleW(14)) textColor:kSubTxtColor frame:CGRectMake(ScaleW(15), ScaleW(22), self.width - ScaleW(15)*2, ScaleW(50)) textAlignment:(NSTextAlignmentLeft)];
        _detailLabel.numberOfLines = 0;
        [_detailLabel sizeToFit];
    }
    return _detailLabel;
}

@end
