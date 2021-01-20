//
//  LXMarketOrderView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/29.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXMarketOrderView.h"
@interface LXMarketOrderView()
@property (nonatomic,strong) UILabel *titleLabel;
@end

@implementation LXMarketOrderView

-(instancetype)initWithTop:(CGFloat)top messageArray:(NSArray *)msaageArray
{
    if (self = [super init])
    {
        self.frame = CGRectMake(0, top, ScreenWidth, ScaleW(100));
        [self viewConfig];
        self.messageArray = msaageArray;
        
    }
    return self;
};
-(void)viewConfig{
    [self addSubview:self.titleLabel];
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:@"订单信息" font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(33), 0, ScreenWidth - ScaleW(33), ScaleW(45)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _titleLabel;
}
-(void)setMessageArray:(NSArray *)messageArray{
    _messageArray = messageArray;
    if (!_messageArray.count) {
        return;
    }
    UIView *v = [self viewWithTag:1000000];
    if (v) {
        [v removeFromSuperview];
    }
    v = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), _titleLabel.bottom, ScreenWidth - ScaleW(30), ScaleW(50)* _messageArray.count)];
    [v setCornerRadius:ScaleW(5)];
    v.tag = 1000000;
    [self addSubview:v];
    self.height = v.bottom;
    v.backgroundColor = kWhiteColor;
    for (int i = 0; i <_messageArray.count; i ++) {
        UILabel *l = [WLTools allocLabel:_messageArray[i] font:systemFont(ScaleW(15)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(18), i * ScaleW(50), v.width- ScaleW(30), ScaleW(50)) textAlignment:(NSTextAlignmentLeft)];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, l.bottom- 1, v.width, 1)];
        lineView.backgroundColor = kMainBgColor;
        [v addSubview:l];
        [v addSubview:lineView];
    }
}
-(void)setModel:(LXMarketOrderDetailModel *)model{
    _model = model;
    NSString *num = [NSString stringWithFormat:@"订单编号：%@",_model.ordernum];
    NSString *createDate = [NSString stringWithFormat:@"创建时间： %@",_model.adtime];
    NSString *statusString =[NSString stringWithFormat:@"订单状态：%@",_model.statusString];
    NSString *qudiString =[NSString stringWithFormat:@"快递单号：%@",_model.logistics];
    NSString *fahuo = _model.fahuoString;
    NSArray *array = @[num?:@"",createDate?:@"",statusString?:@"",qudiString?:@"" ,fahuo?:@""];
    self.messageArray = array;
    
}

@end
