//
//  BkShopCarBottomView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/11.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BkShopCarBottomView.h"
@interface BkShopCarBottomView()
@property (nonatomic,strong) UIButton *allSelecBtn;
@property (nonatomic,strong) UILabel *totalLabel;
@property (nonatomic,strong) UIButton *commitBtn;
@end

@implementation BkShopCarBottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(55));
        _allSelecBtn = [WLTools allocButtonTitle:@"全选" font:systemFont(ScaleW(12)) textColor:kMainTxtColor image:[UIImage imageNamed:@"weixuanzhong"] frame:CGRectMake(0, 0, ScaleW(80), self.height) sel:@selector(allSelecBtnAction:) taget:self];
        [_allSelecBtn setImage:[UIImage imageNamed:@"xuanzhong"] forState:(UIControlStateSelected)];
        [_allSelecBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,ScaleW(10), 0, 0)];
        _totalLabel = [WLTools allocLabel:@"总计：￥219.80" font:systemFont(ScaleW(15)) textColor:kMainTxtColor frame:CGRectMake(_allSelecBtn.right, 0, ScaleW(150), self.height) textAlignment:(NSTextAlignmentRight)];
        [self addSubview:self.commitBtn];
        [self addSubview:self.allSelecBtn];
        [self addSubview:self.totalLabel];
    }
    return self;
}
-(void)allSelecBtnAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
}
-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [WLTools allocButtonTitle:@"去结算（2)" font:systemFont(ScaleW(15)) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(11), ScaleW(10) , ScaleW(114), ScaleW(35)) sel:@selector(commentAction:) taget:self];
        _commitBtn.backgroundColor = kGreenColor;
        _commitBtn.cornerRadius = _commitBtn.height/2.f;
        _commitBtn.right = ScreenWidth - ScaleW(12);
    }
    return _commitBtn;
}
-(void)commentAction:(UIButton *)sender{
    
}
@end
