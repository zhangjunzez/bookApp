//
//  LXMarketOrderBottomView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/29.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXMarketOrderBottomView.h"
@interface LXMarketOrderBottomView()
@property (nonatomic,strong) UIButton *confirmDoneBtn;
@property (nonatomic,strong) UIButton *seeFlowBtn;
@end

@implementation LXMarketOrderBottomView

-(instancetype)init
{
    if (self = [super init])
    {
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig{
    self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(50));
    [self addSubview:self.confirmDoneBtn];
    [self addSubview:self.seeFlowBtn];
    
}
-(UIButton *)confirmDoneBtn{
    if (!_confirmDoneBtn) {
        _confirmDoneBtn = [WLTools allocButtonTitle:@"确认完成" font:systemFont(ScaleW(14)) textColor:kMainTxtColor image:nil frame:CGRectMake(ScaleW(248), ScaleW(9), ScaleW(83), ScaleW(31)) sel:@selector(confirmDoneBtnAction:) taget:self];
        [_confirmDoneBtn setBorderWithWidth:1 andColor:kGrayTxtColor];
        [_confirmDoneBtn setCornerRadius:_confirmDoneBtn.height/2.f];
    }
    return _confirmDoneBtn;
}
-(UIButton *)seeFlowBtn{
    if (!_seeFlowBtn) {
        _seeFlowBtn = [WLTools allocButtonTitle:@"查看物流" font:systemFont(ScaleW(14)) textColor:kMainTxtColor image:nil frame:CGRectMake(ScaleW(151), ScaleW(9), ScaleW(83), ScaleW(31)) sel:@selector(seeFlowBtnAction:) taget:self];
        [_seeFlowBtn setBorderWithWidth:1 andColor:kGrayTxtColor];
        [_seeFlowBtn setCornerRadius:_confirmDoneBtn.height/2.f];
    }
    return _seeFlowBtn;
}
#pragma mark  ---Action

-(void)confirmDoneBtnAction:(UIButton *)sender
{
    !self.rightBtnBlock?:self.rightBtnBlock();
}
-(void)seeFlowBtnAction:(UIButton *)sender
{
    !self.seeFlowsBlock?:self.seeFlowsBlock();
}
-(void)setModel:(LXMarketOrderDetailModel *)model{
    _model = model;
     // 状态 0待发货 1待收货 2已完成
   
    if (_model.state.intValue == 1) {
         self.seeFlowBtn.left = ScaleW(151);
         self.confirmDoneBtn.hidden = NO;
        [self.confirmDoneBtn setTitle:@"确认完成" forState:(UIControlStateNormal)];
        self.rightBtnBlock = self.confirmDoneBlock;
        self.seeFlowBtn.hidden = NO;
    }else if(_model.state.integerValue == 0){
        self.confirmDoneBtn.hidden = YES;
        self.seeFlowBtn.hidden = YES;
    }else if (_model.state.integerValue == 2){
        self.confirmDoneBtn.hidden = NO;
        [self.confirmDoneBtn setTitle:@"删除" forState:(UIControlStateNormal)];
        self.rightBtnBlock = self.deleteBlock;
        self.seeFlowBtn.hidden = YES;
        
    }
}


@end
