//
//  BookOrderView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/6.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BookOrderView.h"
@interface BookOrderView()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *seeAllBtn;
@property (nonatomic,strong) NSArray *itemsArray;
@property (nonatomic,strong) UIView *wufollowsView;
@property (nonatomic,strong) UILabel *wuNameLabel;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UIImageView *headerImgView;
@property (nonatomic,strong) UILabel *statuslabel;
@property (nonatomic,strong) UILabel *descrpLabel;

@end

@implementation BookOrderView


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScaleW(353), ScaleW(224));
        self.backgroundColor = kWhiteColor;
        self.cornerRadius = ScaleW(5);
        [self addSubview:self.titleLabel];
        [self addSubview:self.seeAllBtn];
        self.itemsArray = @[@"待付款",@"待发货",@"待收货",@"待评价",@"退款/售后"];
        [self addSubview:self.wufollowsView];
    }
    return self;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:@"我的订单" font:systemBoldFont(ScaleW(13)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(12), ScaleW(17), ScaleW(100), ScaleW(13)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _titleLabel;
}
-(UIButton *)seeAllBtn{
    if (!_seeAllBtn) {
        _seeAllBtn = [WLTools allocButtonTitle:@"查看全部>" font:systemFont(ScaleW(11)) textColor:kGrayTxtColor image:nil frame:CGRectMake(self.width - ScaleW(88), ScaleW(10), ScaleW(88), ScaleW(30)) sel:@selector(seeAllBtnAction:) taget:self];
    }
    return _seeAllBtn;
}
-(void)seeAllBtnAction:(UIButton *)sender
{
    !self.seeAllOrderBlock?:self.seeAllOrderBlock();
}
-(void)setItemsArray:(NSArray *)itemsArray{
    _itemsArray = itemsArray;
    NSArray *array = @[@"daifukuan",@"待发货拷贝_d",@"待收货拷贝_d",@"待评价_d",@"icon_退款售后"];
   
    CGFloat w = self.width/_itemsArray.count;
    for (int i = 0; i < _itemsArray.count; i ++) {
        UIButton *btn = [WLTools allocButtonTitle:_itemsArray[i] font:systemFont(ScaleW(12)) textColor:kMainTxtColor image:[UIImage imageNamed:array[i]] frame:CGRectMake(i *w, ScaleW(14)+ _titleLabel.bottom, w, ScaleW(70)) sel:@selector(btnAction:) taget:self];
        CGFloat f = [self returnWidth:_itemsArray[i] font:ScaleW(12)];
        [btn setBtnDownLabelUpDownOffSet:0 leftOffset:0];
        [self addSubview:btn];
    }
}
-(void)btnAction:(UIButton *)sender{
    !self.orderSelectBlock?:self.orderSelectBlock(sender.titleLabel.text);
}
-(UIView *)wufollowsView{
    if (!_wufollowsView) {
        _wufollowsView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(12), ScaleW(88) + _titleLabel.bottom, ScaleW(329), ScaleW(80))];
        _wufollowsView.backgroundColor = kSubBacColor;
        _wufollowsView.cornerRadius = ScaleW(5);
        [_wufollowsView addSubview:self.wuNameLabel];
        [_wufollowsView addSubview:self.dateLabel];
        [_wufollowsView addSubview:self.headerImgView];
        [_wufollowsView addSubview:self.statuslabel];
        [_wufollowsView addSubview:self.descrpLabel];
    }
    return _wufollowsView;
}

-(UILabel *)wuNameLabel{
    if (!_wuNameLabel) {
        _wuNameLabel = [WLTools allocLabel:@"最新物流" font:systemFont(ScaleW(11)) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(22), ScaleW(12), _wufollowsView.width - ScaleW(42), ScaleW(11)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _wuNameLabel;
}
-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [WLTools allocLabel:@"01-02" font:systemFont(ScaleW(11)) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(22), ScaleW(12), _wufollowsView.width - ScaleW(42), ScaleW(11)) textAlignment:(NSTextAlignmentRight)];
    }
    return _dateLabel;
}
-(UIImageView *)headerImgView{
    if (!_headerImgView) {
        _headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(_wuNameLabel.left, _wuNameLabel.bottom + ScaleW(9), ScaleW(33), ScaleW(33))];
        _headerImgView.backgroundColor = kGrayTxtColor;
    }
    return _headerImgView;
}

-(UILabel *)statuslabel{
    if (!_statuslabel) {
        _statuslabel = [WLTools allocLabel:@"运输中" font:systemFont(ScaleW(13)) textColor:kBlueColor frame:CGRectMake(ScaleW(17) + _headerImgView.right, ScaleW(33), ScaleW(235), ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _statuslabel;
}
-(UILabel *)descrpLabel{
    if (!_descrpLabel) {
        _descrpLabel = [WLTools allocLabel:@"【开封市】开封派件员：君临天下驿站的 电…" font:systemFont(ScaleW(13)) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(17) + _headerImgView.right, ScaleW(10) + _statuslabel.bottom, ScaleW(235), ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _descrpLabel;
}

@end
