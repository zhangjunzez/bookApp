//
//  LXMineHeader.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/23.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXMineHeader.h"
#import "LXMineHeaderItemView.h"
#import "LXHeaderSignItemView.h"
#import "LXUserInforModel.h"
@interface LXMineHeader()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *ivateCodeLabel;
@property (nonatomic,strong) UIButton *copBtn;
@property (nonatomic,strong) UIImageView *headerImage;
@property (nonatomic,strong) UIImageView *gotoImg;
@property (nonatomic,strong) UIView *actionView;

@property (nonatomic,strong) LXMineHeaderItemView *requstOrderView;
@property (nonatomic,strong) LXMineHeaderItemView *serverOrderView;
@property (nonatomic,strong) LXMineHeaderItemView *scoreOrderView;
@property (nonatomic,strong) LXHeaderSignItemView *signView;
@property (nonatomic,strong) LXHeaderSignItemView *scoreMarketView;
@end
@implementation LXMineHeader

-(instancetype)init
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(100));
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig{
    [self addSubview:self.actionView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.ivateCodeLabel];
    [self addSubview:self.copBtn];
    [self addSubview:self.headerImage];
    [self addSubview:self.gotoImg];
    [self addSubview:self.requstOrderView];
    [self addSubview:self.serverOrderView];
    [self addSubview:self.scoreOrderView];
    [self addSubview:self.signView];
    [self addSubview:self.scoreMarketView];
    self.height = self.scoreMarketView.bottom + ScaleW(10);
    
    self.statusType = kLogin?MineStatusTypeLogin:MineStatusTypeLoginOut;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:@"*****" font:systemBoldFont(ScaleW(19)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(17), ScaleW(15), ScaleW(150), ScaleW(19)) textAlignment:(NSTextAlignmentLeft)];
        
    }
    return _nameLabel;
}

-(UILabel *)ivateCodeLabel{
    if (!_ivateCodeLabel) {
        _ivateCodeLabel = [WLTools allocLabel:@"邀请码：****" font:systemFont(ScaleW(13)) textColor:kGrayTxtColor frame:CGRectMake(_nameLabel.left, ScaleW(15) + _nameLabel.bottom, ScaleW(120), ScaleW(13)) textAlignment:(NSTextAlignmentLeft)];
        
    }
    return _ivateCodeLabel;
}
-(UIButton *)copBtn{
    if (!_copBtn) {
        _copBtn = [WLTools allocButtonTitle:@"复制" font:systemFont(ScaleW(11)) textColor:kWhiteColor image:nil frame:CGRectMake(_ivateCodeLabel.right, ScaleW(12) + _nameLabel.bottom, ScaleW(47), ScaleW(19)) sel:@selector(copBtnAction:) taget:self];
        [_copBtn setCornerRadius:ScaleW(19/2.f)];
        _copBtn.backgroundColor = kBlueColor;
    }
    return _copBtn;
}
-(UIImageView *)headerImage{
    if (!_headerImage) {
        _headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth -(ScaleW(45+63)), ScaleW(5), ScaleW(63), ScaleW(63))];
        _headerImage.backgroundColor = kGrayTxtColor;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoInforAction)];
              _headerImage.userInteractionEnabled = YES;
        [_headerImage addGestureRecognizer:tap];
        [_headerImage setImage:[UIImage imageNamed:@"morentouxiang"]];
        [_headerImage setCornerRadius:_headerImage.height/2.f];
    }
    return _headerImage;
}
-(UIView *)actionView{
    if (!_actionView) {
        _actionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(70))];
        _actionView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoInforAction)];
       [_actionView addGestureRecognizer:tap];
    }
    return _actionView;
}
-(UIImageView *)gotoImg{
    if (!_gotoImg) {
        _gotoImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"chakanquanbu"]];
        _gotoImg.right = ScreenWidth - ScaleW(15);
        _gotoImg.centerY = _headerImage.centerY;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoInforAction)];
        _gotoImg.userInteractionEnabled = YES;
        [_gotoImg addGestureRecognizer:tap];
    }
    return _gotoImg;
}

-(LXMineHeaderItemView *)requstOrderView{
    if (!_requstOrderView) {
        _requstOrderView = [[LXMineHeaderItemView alloc]initWithImge:[UIImage imageNamed:@"wode_xuqiu"] message:@"服务订单"];
        _requstOrderView.left = ScaleW(60);
        _requstOrderView.top = ScaleW(35) + _ivateCodeLabel.bottom;
        WS(weakSelf);
        _requstOrderView.itemClickBlock = ^{
            !weakSelf.requstOrderBlock?:weakSelf.requstOrderBlock();
        };
    }
    return _requstOrderView;
}
-(LXMineHeaderItemView *)serverOrderView{
    if (!_serverOrderView) {
        _serverOrderView = [[LXMineHeaderItemView alloc]initWithImge:[UIImage imageNamed:@"wode_fuwu1"] message:@"服务订单"];
        _serverOrderView.centerX = ScreenWidth/2.f;
        _serverOrderView.top = _requstOrderView.top;
        WS(weakSelf);
        _serverOrderView.hidden = YES;
        _serverOrderView.itemClickBlock = ^{
            !weakSelf.serverOrderBlock?:weakSelf.serverOrderBlock();
        };
    }
    return _serverOrderView;
}
-(LXMineHeaderItemView *)scoreOrderView{
    if (!_scoreOrderView) {
        _scoreOrderView = [[LXMineHeaderItemView alloc]initWithImge:[UIImage imageNamed:@"wode_jifen3"] message:@"积分订单"];
        _scoreOrderView.right = ScreenWidth-ScaleW(60);
        _scoreOrderView.top = _requstOrderView.top;
        WS(weakSelf);
        _scoreOrderView.itemClickBlock = ^{
            !weakSelf.scoreOrderBlock?:weakSelf.scoreOrderBlock();
        };
    }
    return _scoreOrderView;
}

-(LXHeaderSignItemView *)signView{
    if (!_signView) {
        _signView = [[LXHeaderSignItemView alloc]initWithTop:_scoreOrderView.bottom + ScaleW(20) left:ScaleW(15) title:@"签到" subTitle:@"签到赢积分" imgeName:@"wode_qiandao"];
        WS(weakSelf);
        _signView.itemClickedBlock = ^{
            !weakSelf.signActionBlock?:weakSelf.signActionBlock();
        };
    }
    return _signView;
}
-(LXHeaderSignItemView *)scoreMarketView
{
    if (!_scoreMarketView) {
        _scoreMarketView = [[LXHeaderSignItemView alloc]initWithTop:_scoreOrderView.bottom + ScaleW(20) left:ScaleW(10) + _signView.right title:@"积分商城" subTitle:@"积分抵现" imgeName:@"wode_jifen1"];
         _scoreMarketView.top = _scoreOrderView.bottom;
        WS(weakSelf);
            _scoreMarketView.itemClickedBlock = ^{
                   !weakSelf.scoreMarketBlock?:weakSelf.scoreMarketBlock();
            };
    }
    return _scoreMarketView;
}
-(void)copBtnAction:(UIButton *)sender
{
    if (_model.invitationcode.length) {
        [MBProgressHUD showError:SSKJLanguage(@"复制成功")];
           UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
           pasteboard.string = self.model.invitationcode;
    }
}
-(void)gotoInforAction{
    !self.userInforBlock?:self.userInforBlock();
}

-(void)setStatusType:(MineStatusType)statusType{
    if (_statusType!=statusType) {
        _statusType = statusType;
    if (_statusType == MineStatusTypeLoginOut) {
        _ivateCodeLabel.hidden = YES;
        _copBtn.hidden = YES;
        _headerImage.hidden = YES;
        _nameLabel.centerY = _headerImage.centerY;
        _nameLabel.text = @"请登录";
    }else{
        _ivateCodeLabel.hidden = _copBtn.hidden = _headerImage.hidden = NO;
        _nameLabel.text = @"**";
        _nameLabel.top = ScaleW(15);
    }
 }
    
}

-(void)setModel:(LXUserInforModel *)model{
   
    _model = model;
    self.nameLabel.text = _model.nickname?:@"";
    self.ivateCodeLabel.text = [NSString stringWithFormat:@"邀请码：%@",_model.invitationcode];
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString: [WLTools imageURLWithURL:_model.icon]] placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
}
@end 
