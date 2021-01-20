//
//  DSMineBackView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/12/9.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//
#define kBtnTag(a) 100000 + a
#import "DSMineBackView.h"
@interface DSMineBackView()
@property (nonatomic,strong) UIImageView *backImgView;
@property (nonatomic,strong) UIImageView *headerImgView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *descrpLabel;
///设置按钮
@property (nonatomic,strong) UIButton *settingBtn;
///消息按钮
@property (nonatomic,strong) UIButton *messageBtn;
@end

@implementation DSMineBackView
- (instancetype)init
{
    self = [super init];
    if (self) {
      UIImage *bg = [UIImage imageNamed:@"bg"];
      CGFloat height =  ScreenWidth*(bg.size.height/bg.size.width);
        self.frame = CGRectMake(0, 0, ScreenWidth, height);
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig{
    [self addSubview:self.backImgView];
    [self.backImgView addSubview:self.headerImgView];
    [self.backImgView addSubview:self.nameLabel];
    [self.backImgView addSubview:self.descrpLabel];
    [self.backImgView addSubview:self.settingBtn];
    [self.backImgView addSubview:self.messageBtn];
    ///验证是否登录事件
    UIButton *isloginBtn = [WLTools allocButtonTitle:@"" font:systemFont(ScaleW(0)) textColor:kWhiteColor image:nil frame:CGRectMake(_nameLabel.left, _nameLabel.top, _nameLabel.width - ScaleW(30), ScaleW(40)) sel:@selector(headerAction) taget:self];
    [self.backImgView addSubview:isloginBtn];
    
}
-(void)headerAction{
    !self.headerBlock?:self.headerBlock();
}
-(UIImageView *)backImgView{
    if (!_backImgView) {
        _backImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _backImgView.image = [UIImage imageNamed:@"bg"];
        _backImgView.userInteractionEnabled = YES;
    }
    return _backImgView;
}
-(UIImageView *)headerImgView{
    if (!_headerImgView) {
        _headerImgView  = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(12), ScaleW(20) + Height_StatusBar, ScaleW(45), ScaleW(45))];
        _headerImgView.backgroundColor = kGrayBtnBacColor;
        [_headerImgView setCornerRadius:_headerImgView.height/2.f];
        _headerImgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [_headerImgView addGestureRecognizer:tap];
    }
    return _headerImgView;
}
-(UIButton *)messageBtn{
    if (!_messageBtn) {
        _messageBtn = [WLTools allocButtonTitle:@"" font:systemFont(0) textColor:kWhiteColor image:[UIImage imageNamed:@"消息"] frame:CGRectMake(ScreenWidth - ScaleW(36), Height_StatusBar, ScaleW(36), ScaleW(36)) sel:@selector(messageBtnAction:) taget:self];
    }
    return _messageBtn;
}
-(void)messageBtnAction:(UIButton *)sender
{
    !self.messageBlock?:self.messageBlock();
}
-(UIButton *)settingBtn{
    if (!_settingBtn) {
        _settingBtn = [WLTools allocButtonTitle:@"" font:systemFont(0) textColor:kWhiteColor image:[UIImage imageNamed:@"设置_d"] frame:CGRectMake(ScreenWidth - ScaleW(72), Height_StatusBar, ScaleW(36), ScaleW(36)) sel:@selector(settingBtnAction:) taget:self];
    }
    return _settingBtn;
}
-(void)settingBtnAction:(UIButton *)sender
{
    !self.settingsBlock?:self.settingsBlock();
}
-(void)tapAction:(UITapGestureRecognizer *)tap{
    [self headerAction];
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:@"柠檬不酸" font:systemBoldFont(ScaleW(16)) textColor:kMainTxtColor frame:CGRectMake(_headerImgView.right + ScaleW(16), _headerImgView.top + ScaleW(5), ScaleW(200), ScaleW(16)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _nameLabel;
}

-(UILabel *)descrpLabel{
    if (!_descrpLabel) {
        _descrpLabel = [WLTools allocLabel:@"生活很苦，但你很甜呐~" font:systemFont(ScaleW(12)) textColor:kSubTxtColor frame:CGRectMake(_nameLabel.left, _nameLabel.bottom + ScaleW(9), _nameLabel.width, ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _descrpLabel;
}


-(void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    //NSString *idS = _dataDic[@"id"];
    NSString *nickname = _dataDic[@"nickname"];
    NSString *motto = _dataDic[@"motto"];
    NSString *focusedCount = _dataDic[@"focusedCount"];
    NSString *toFocusedCount = _dataDic[@"toFocusedCount"];
    NSString *avatar = _dataDic[@"avatar"];
    self.nameLabel.text = nickname;
    self.descrpLabel.text = motto;
    
    [self.headerImgView sd_setImageWithURL:[NSURL URLWithString:avatar]];
    
}
-(void)setType:(MineStatusType)type{
    _type = type;
    _descrpLabel.hidden = NO;
    _headerImgView.hidden = NO;
    if (_type == MineStatusTypeLogin) {
        _nameLabel.text = @"昵称";
    }
    if (_type == MineStatusTypeLoginOut) {
        _descrpLabel.hidden = YES;
        _headerImgView.hidden = YES;
        _nameLabel.text = @"请登录";
    }
}

@end
