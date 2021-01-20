//
//  LXOrderMessageValueItemView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/29.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//
#define kOffsetValue ScaleW(80)
#import "LXOrderMessageValueItemView.h"
@interface LXOrderMessageValueItemView()
@property (nonatomic,strong) NSString *titleString;
@property (nonatomic,strong) NSString *valueString;
@property (nonatomic,assign) BOOL isRed;


@end
@implementation LXOrderMessageValueItemView

-(instancetype)initWithTop:(CGFloat)top  titleString:(NSString *)titleString valueString:(NSString *)valueString isRedValue:(BOOL)isRedValue;
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, top, ScaleW(353), ScaleW(35));
        self.backgroundColor = kWhiteColor;
        self.titleString = titleString;
        self.valueString = valueString;
        self.isRed = isRedValue;
        [self viewConfig];
    }
    return self;
};
-(void)viewConfig{
    [self addSubview:self.titleLabel];
    [self addSubview:self.valueLabel];
}
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:_titleString font:systemFont(ScaleW(13)) textColor:kSubTxtColor frame:CGRectMake(ScaleW(13), 0, self.width - ScaleW(26), self.height) textAlignment:(NSTextAlignmentLeft)];
    }
    return _titleLabel;;
}
-(UILabel *)valueLabel
{
    if (!_valueLabel) {
        _valueLabel = [WLTools allocLabel:_valueString font:systemFont(ScaleW(13)) textColor:_isRed?kRedColor:kMainTxtColor frame:CGRectMake(_titleLabel.left + kOffsetValue, 0, _titleLabel.width - kOffsetValue, _titleLabel.height) textAlignment:(NSTextAlignmentRight)];
    }
    return _valueLabel;
}
@end
