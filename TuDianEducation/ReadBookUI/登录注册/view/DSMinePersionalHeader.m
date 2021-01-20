//
//  DSMinePersionalHeader.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/12/10.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//
#define kBtnTag(a) 100000 + a
#import "DSMinePersionalHeader.h"
@interface DSMinePersionalHeader()
@property (nonatomic,strong) UIImageView *headerView;
@property (nonatomic,strong) UIButton *fansBtn;
@property (nonatomic,strong) UIButton *collectBtn;
@property (nonatomic,strong) UIButton *edtingBtn;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *descrepLabel;
@property (nonatomic,strong) NSMutableArray *tagUiArray;
@property (nonatomic,strong) NSArray *tagArray;

@property (nonatomic,strong) UIButton *pingbiBtn;
@property (nonatomic,strong) UIView *movingLine;


@end

@implementation DSMinePersionalHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, ScaleW(85), ScreenWidth, ScaleW(250));
        self.backgroundColor = kMainBgColor;
        self.layer.cornerRadius = ScaleW(10);
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - ScaleW(20), self.width, ScaleW(20))];
        view.backgroundColor = kMainBgColor;
        [self addSubview:view];
        [self addSubview:self.headerView];
        [self addSubview:self.fansBtn];
        [self addSubview:self.collectBtn];
        [self addSubview:self.edtingBtn];
        [self addSubview:self.pingbiBtn];
        self.pingbiBtn.hidden = !_isOther;
        [self addSubview:self.nameLabel];
        [self addSubview:self.descrepLabel];
        self.tagArray = @[@"男",@"29岁",@"河南郑州"];
        [self addSubview:self.movingLine];
        self.selectArray = @[@"喜欢",@"作品",@"动态"];
        
    }
    return self;
}

-(UIImageView *)headerView{
    if (!_headerView) {
        _headerView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(12), ScaleW(20), ScaleW(54), ScaleW(54))];
       
        [_headerView setBorderWithWidth:1 andColor:kRedColor];
        _headerView.backgroundColor = kGrayBtnBacColor;
        [_headerView setCornerRadius: _headerView.height/2.f];
    }
    return _headerView;
}

-(UIButton *)fansBtn{
    if (!_fansBtn) {
        _fansBtn = [WLTools allocButtonTitle:@"" font:systemBoldFont(ScaleW(18)) textColor:kMainTxtColor image:nil frame:CGRectMake(ScaleW(17) + _headerView.right, ScaleW(14), ScaleW(80), ScaleW(38)) sel:@selector(fansBtnAction:) taget:self];
//        NSString *string = _fansBtn.titleLabel.text;
//        NSMutableAttributedString *atts = [[NSMutableAttributedString alloc] initWithString:string];
//        [atts setAttributes:@{ NSForegroundColorAttributeName:kGrayTxtColor,NSFontAttributeName:systemFont(ScaleW(14))} range:NSMakeRange(string.length - 2,  2)];
//        [_fansBtn setAttributedTitle:atts forState:(UIControlStateNormal)];
    }
    return _fansBtn;
}
#pragma mark --粉丝
-(void)fansBtnAction:(UIButton *)sender
{
    
}
-(UIButton *)collectBtn{
    if (!_collectBtn) {
        _collectBtn = [WLTools allocButtonTitle:@"" font:systemBoldFont(ScaleW(18)) textColor:kMainTxtColor image:nil frame:CGRectMake(ScaleW(5) + _fansBtn.right, ScaleW(14), ScaleW(80), ScaleW(38)) sel:@selector(collectBtnAction:) taget:self];
//        NSString *string = _collectBtn.titleLabel.text;
//        NSMutableAttributedString *atts = [[NSMutableAttributedString alloc] initWithString:string];
//        [atts setAttributes:@{ NSForegroundColorAttributeName:kGrayTxtColor,NSFontAttributeName:systemFont(ScaleW(14))} range:NSMakeRange(string.length - 2,  2)];
//        [_collectBtn setAttributedTitle:atts forState:(UIControlStateNormal)];
    }
    return _collectBtn;
}
#pragma mark --关注
-(void)collectBtnAction:(UIButton *)sender
{
    
}
-(UIButton *)edtingBtn{
    if (!_edtingBtn) {
        _edtingBtn = [WLTools allocButtonTitle:@"编辑个人资料" font:systemFont(ScaleW(13)) textColor:kMainTxtColor image:nil frame:CGRectMake(ScaleW(31) + _headerView.right, ScaleW(14) + _fansBtn.bottom, ScaleW(147), ScaleW(25)) sel:@selector(edtingBtnAction:) taget:self];
        [_edtingBtn setCornerRadius:_edtingBtn.height/2.f];
        _edtingBtn.backgroundColor = kWhiteColor;
    }
    return _edtingBtn;
}
-(UIButton *)pingbiBtn{
    if (!_pingbiBtn) {
        _pingbiBtn = [WLTools allocButtonTitle:@"屏蔽此人" font:systemFont(ScaleW(13)) textColor:kMainTxtColor image:nil frame:CGRectMake(ScaleW(5) + _edtingBtn.right, ScaleW(14) + _fansBtn.bottom, ScaleW(80), ScaleW(25)) sel:@selector(pingbiBtnAction:) taget:self];
        [_pingbiBtn setCornerRadius:_pingbiBtn.height/2.f];
        _pingbiBtn.backgroundColor = kWhiteColor;
    }
    return _pingbiBtn;
}
#pragma mark --编辑个人资料
-(void)edtingBtnAction:(UIButton *)sender
{
    if (_isOther) {
        !self.attentionBlock?:self.attentionBlock(sender);
    }else{
        !self.edtingBlock?:self.edtingBlock();
    }
   
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:@"张寒希" font:systemBoldFont(ScaleW(18)) textColor:kMainTxtColor frame:CGRectMake(_headerView.left, _headerView.bottom + ScaleW(17), self.width - ScaleW(24), ScaleW(18)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _nameLabel;
}

-(UILabel *)descrepLabel{
    if (!_descrepLabel) {
        _descrepLabel = [WLTools allocLabel:@"生活很苦，但你很甜呐~" font:systemFont(ScaleW(13)) textColor:kSubTxtColor frame:CGRectMake(_headerView.left, _nameLabel.bottom + ScaleW(12), self.width - ScaleW(24), ScaleW(18)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _descrepLabel;
}
-(void)setTagArray:(NSArray *)tagArray{
    _tagArray = tagArray;
    for (UIView *v  in self.tagUiArray) {
        [v removeFromSuperview];
    }
    [self.tagUiArray removeAllObjects];
    CGFloat Offset = _nameLabel.left;
    for (int i = 0;i<_tagArray.count; i ++) {
        NSString *string = _tagArray[i];
        CGFloat w = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, ScaleW(13)) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:systemFont(ScaleW(11))} context:nil].size.width + ScaleW(18);
        UILabel *l = [WLTools allocLabel:_tagArray[i] font:systemFont(ScaleW(11)) textColor:kGrayTxtColor frame:CGRectMake(Offset, _descrepLabel.bottom + ScaleW(8), w, ScaleW(18)) textAlignment:(NSTextAlignmentCenter)];
        l.backgroundColor = kGrayBtnBacColor;
        l.cornerRadius = l.height/2.f;
        Offset += w + ScaleW(6);
        [self addSubview:l];
        [self.tagUiArray addObject:l];
    }
}
-(NSMutableArray *)tagUiArray{
    if (!_tagUiArray) {
        _tagUiArray = [NSMutableArray array];
    }
    return _tagUiArray;
}
-(UIView *)movingLine{
    if (!_movingLine) {
        _movingLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 4, ScaleW(60), 4)];
        _movingLine.backgroundColor = kBlueColor;
    }
    return _movingLine;
}
-(void)setSelectArray:(NSArray *)selectArray{
    _selectArray = selectArray;
    CGFloat w = self.width/3.f;
    for (int i = 0; i < _selectArray.count; i ++) {
        UIButton *btn = [WLTools allocButtonTitle:_selectArray[i] font:systemFont(ScaleW(14)) textColor:kSubTxtColor image:nil frame:CGRectMake(i * w,self.height- ScaleW(40)- 1, w, ScaleW(40)) sel:@selector(btnAction:) taget:self];
        btn.tag = kBtnTag(i);
        [self addSubview:btn];
    }
    self.currentIndex = 0;
}

-(void)btnAction:(UIButton *)sender
{
    self.currentIndex = sender.tag - kBtnTag(0);
    !self.selctBlock?:self.selctBlock(_currentIndex);
}

-(void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    
    for (int i = 0; i < _selectArray.count; i ++) {
        UIButton *b = [self viewWithTag:kBtnTag(i)];
        if (i == _currentIndex) {
            b.titleLabel.font = systemBoldFont(15);
            [b setTitleColor:kMainTxtColor forState:(UIControlStateNormal)];
            self.movingLine.centerX = b.centerX;
        }else{
            b.titleLabel.font = systemFont(14);
            [b setTitleColor:kSubTxtColor forState:(UIControlStateNormal)];
        }
    }
}
-(void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    _dataDic = dataDic;
    //NSString *idS = _dataDic[@"id"];
    NSString *nickname = _dataDic[@"nickname"];
    NSString *motto = _dataDic[@"motto"];
    NSString *focusedCount = [NSString stringWithFormat:@"%@",_dataDic[@"focusedCount"]];
    NSString *toFocusedCount =[NSString stringWithFormat:@"%@",_dataDic[@"toFocusedCount"]];;
    
    NSString *avatar = _dataDic[@"avatar"];
    NSString *sex = _dataDic[@"sex"];
    NSString *age = _dataDic[@"age"];
    NSString *district = _dataDic[@"district"];
    self.nameLabel.text = nickname;
    self.descrepLabel.text = motto;
    [self.collectBtn setTitle:[NSString stringWithFormat:@"%@关注",toFocusedCount] forState:(UIControlStateNormal)];
    [self.fansBtn setTitle:[NSString stringWithFormat:@"%@粉丝",focusedCount] forState:(UIControlStateNormal)];
    [self.headerView sd_setImageWithURL:[NSURL URLWithString:avatar]];
    NSString *string = _collectBtn.titleLabel.text;
    NSMutableAttributedString *atts = [[NSMutableAttributedString alloc] initWithString:string];
    [atts setAttributes:@{ NSForegroundColorAttributeName:kGrayTxtColor,NSFontAttributeName:systemFont(ScaleW(14))} range:NSMakeRange(string.length - 2,  2)];
    [_collectBtn setAttributedTitle:atts forState:(UIControlStateNormal)];
    NSString *string1 = _fansBtn.titleLabel.text;
    NSMutableAttributedString *atts1 = [[NSMutableAttributedString alloc] initWithString:string1];
    [atts1 setAttributes:@{ NSForegroundColorAttributeName:kGrayTxtColor,NSFontAttributeName:systemFont(ScaleW(14))} range:NSMakeRange(string1.length - 2,  2)];
    [_fansBtn setAttributedTitle:atts1 forState:(UIControlStateNormal)];
    sex = sex.integerValue == 1 ?@"男":@"女";
    age =[NSString stringWithFormat:@"%@岁",age];
    self.tagArray = @[sex?:@"",age?:@"",district?:@""];
    NSString *focused = _dataDic[@"focused"];
    NSString *beFocused = _dataDic[@"beFocused"];
    NSString *statue= @"关注";
    if (focused.intValue&&beFocused.intValue) {
        statue = @"相互关注";
    }else{
        if (focused.intValue) {
            statue = @"已关注";
        }
        if (beFocused.intValue) {
            statue = @"已被关注";
        }
        if (!beFocused.intValue&&!focused.intValue) {
            statue = @"关注";
        }
    }
    if (_isOther) {
        [self.edtingBtn setTitle:statue forState:(UIControlStateNormal)];
    }
    NSString *  shielded = _dataDic[@"shielded"];
    [self.pingbiBtn setTitle:shielded.intValue?@"已屏蔽":@"屏蔽此人" forState:(UIControlStateNormal)];
   
}
    
-(void)setIsOther:(BOOL)isOther{
    _isOther = isOther;
    self.pingbiBtn.hidden = !_isOther;
}
#pragma mark ---屏蔽事件
-(void)pingbiBtnAction:(UIButton *)sender{
    !self.noceBlock?:self.noceBlock(sender);
}
   
@end
