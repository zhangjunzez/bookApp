//
//  LXScoreHeaderView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/24.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXScoreHeaderView.h"
#import "LXScoreControlView.h"
@interface LXScoreHeaderView()
@property (nonatomic,strong) UIImageView *backView;
@property (nonatomic,strong) UILabel *nameLabel;

@property (nonatomic, strong) LXScoreControlView *controlView;
@end

@implementation LXScoreHeaderView

-(instancetype)init
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(100));
        self.backgroundColor = kWhiteColor;
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig{
    [self addSubview:self.backView];
    [self.backView addSubview:self.nameLabel];
    [self.backView addSubview:self.valueLabel];
    [self addSubview:self.controlView];
    self.height = self.controlView.bottom;
   
}

-(UIImageView *)backView{
    if (!_backView) {
        _backView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(11), ScaleW(15), ScaleW(353), ScaleW(90))];
        _backView.image = [UIImage imageNamed:@"yuebg"];
        [_backView setCornerRadius:ScaleW(15)];
        _backView.userInteractionEnabled = YES;
    }
    return _backView;
}


-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:@"我的余额" font:systemFont(ScaleW(13)) textColor:kWhiteColor frame:CGRectMake(ScaleW(24), ScaleW(19), _backView.width - ScaleW(40), ScaleW(13)) textAlignment:(NSTextAlignmentLeft)];
        
    }
    return _nameLabel;
}
-(UILabel *)valueLabel{
    if (!_valueLabel) {
        _valueLabel = [WLTools allocLabel:@"￥2000.00" font:systemFont(ScaleW(12)) textColor:kWhiteColor frame:CGRectMake(_nameLabel.left, ScaleW(17) + _nameLabel.bottom, _nameLabel.width, ScaleW(20)) textAlignment:(NSTextAlignmentLeft)];
        NSString *string = _valueLabel.text;
        NSMutableAttributedString *atts = [[NSMutableAttributedString alloc] initWithString:string];
        [atts setAttributes:@{NSFontAttributeName:systemBoldFont(ScaleW(20))} range:NSMakeRange(1,  string.length - 4)];
        _valueLabel.attributedText = atts;
    }
    return _valueLabel;
}
-(LXScoreControlView *)controlView{
    if (!_controlView) {
        NSArray *titleArray = @[@"全部",@"收入",@"支出"];
        _controlView = [[LXScoreControlView alloc]initWithTop:ScaleW(10) + _backView.bottom titleArray:titleArray];
        ///默认全部
        _controlView.currentIndex = 0;
        WS(weakSelf);
        _controlView.btnClickedBlock = ^(NSInteger index) {
            !weakSelf.selectIndexBlock?:weakSelf.selectIndexBlock(index);
        };
    }
    return _controlView;
}

@end
