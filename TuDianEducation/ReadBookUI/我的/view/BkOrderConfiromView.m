//
//  BkOrderConfiromView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/8.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BkOrderConfiromView.h"
@interface BkOrderConfiromView()
@property (nonatomic,strong) UILabel *scroenameLabel;
@property (nonatomic,strong) UILabel *scroreLabel;
@property (nonatomic,strong) UIImageView *headerImgView;
@property (nonatomic,strong) UILabel *nameLable;
@property (nonatomic,strong) UILabel *amountLabel;
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UILabel *messagelabel;

@end

@implementation BkOrderConfiromView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(ScaleW(11), 0, ScreenWidth-ScaleW(22), ScaleW(150));
        self.backgroundColor = kWhiteColor;
        self.cornerRadius = ScaleW(10);
        [self addSubview:self.scroenameLabel];
        [self addSubview:self.scroreLabel];
        [self addSubview:self.headerImgView];
        [self addSubview:self.nameLable];
        [self addSubview:self.amountLabel];
        [self addSubview:self.addressLabel];
        [self addSubview:self.messagelabel];
    }
    return self;
}
-(UILabel *)scroenameLabel{
    if (!_scroenameLabel) {
        _scroenameLabel = [WLTools allocLabel:@"使用积分" font:systemFont(ScaleW(12)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), ScaleW(17), self.width - ScaleW(30), ScaleW(15)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _scroenameLabel;
}
-(UILabel *)scroreLabel{
    if (!_scroreLabel) {
        _scroreLabel = [WLTools allocLabel:@"10000" font:systemBoldFont(ScaleW(18)) textColor:kRedColor frame:CGRectMake(ScaleW(15), ScaleW(17), self.width - ScaleW(30), ScaleW(18)) textAlignment:(NSTextAlignmentRight)];
    }
    return _scroreLabel;
}
-(UIImageView *)headerImgView{
    if (!_headerImgView) {
        _headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(33) + _scroenameLabel.bottom, ScaleW(55), ScaleW(55))];
        _headerImgView.backgroundColor = kGrayTxtColor;
    }
    return _headerImgView;
}
-(UILabel *)nameLable{
    if (!_nameLable) {
        _nameLable = [WLTools allocLabel:@"初中数学运算大法" font:systemBoldFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(25) + _headerImgView.right, ScaleW(30) + _scroenameLabel.bottom, ScaleW(240), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _nameLable;
}
-(UILabel *)amountLabel{
    if (!_amountLabel) {
        _amountLabel = [WLTools allocLabel:@"x1" font:systemFont(ScaleW(12)) textColor:kSubTxtColor frame:CGRectMake(ScaleW(25) + _headerImgView.right, ScaleW(30) + _scroenameLabel.bottom, ScaleW(240), ScaleW(12)) textAlignment:(NSTextAlignmentRight)];
    }
    return _amountLabel;
}
-(UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [WLTools allocLabel:@"选择收货地址" font:systemFont(ScaleW(12)) textColor:kSubTxtColor frame:CGRectMake(ScaleW(25) + _headerImgView.right, ScaleW(12) + _amountLabel.bottom, ScaleW(240), ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        _addressLabel.userInteractionEnabled = YES;
        [_addressLabel addGestureRecognizer:tap];
    }
    return _addressLabel;
}
-(UILabel *)messagelabel{
    if (!_messagelabel) {
        _messagelabel = [WLTools allocLabel:@"兑换商品" font:systemFont(ScaleW(12)) textColor:kGreenColor frame:CGRectMake(ScaleW(25) + _headerImgView.right, ScaleW(12) + _addressLabel.bottom, ScaleW(240), ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _messagelabel;
}
-(void)tapAction:(UITapGestureRecognizer *)tap
{
    UILabel *label = (UILabel *)tap.view;
    !self.selcetAddressBlock?:self.selcetAddressBlock(label);
}
@end
