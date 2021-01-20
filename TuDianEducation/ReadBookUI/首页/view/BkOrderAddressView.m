//
//  BkOrderAddressView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/13.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BkOrderAddressView.h"
@interface BkOrderAddressView()
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UILabel *authorLabel;
@property (nonatomic,strong) UIImageView *gotoImgView;
@end
@implementation BkOrderAddressView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(69));
        self.backgroundColor = kWhiteColor;
        UIImageView *addresdsImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shouhuodizhi"]];
        addresdsImgView.centerY = self.height/2.f;
        addresdsImgView.left = ScaleW(11);
        [self addSubview:addresdsImgView];
        [self addSubview:self.addressLabel];
        [self addSubview:self.authorLabel];
        [self addSubview:self.gotoImgView];
        UIButton *btn = [WLTools allocButtonTitle:@"" font:systemFont(ScaleW(0)) textColor:kWhiteColor image:nil frame:CGRectMake(0, 0, self.width, self.height) sel:@selector(swithAddressAction:) taget:self];
        [self addSubview:btn];
    }
    return self;
}
-(void)swithAddressAction:(UIButton *)sender
{
    !self.gotoAddressBlock?:self.gotoAddressBlock();
}
-(UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [WLTools allocLabel:@"中原福塔 航海东路1206号" font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(32), ScaleW(19), ScaleW(300), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _addressLabel;
}


-(UILabel *)authorLabel{
    if (!_authorLabel) {
        _authorLabel = [WLTools allocLabel:@"15656562565 王女士" font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(32), ScaleW(5) + _addressLabel.bottom, ScaleW(300), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _authorLabel;
}

-(UIImageView *)gotoImgView{
    if (!_gotoImgView) {
        _gotoImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"chakanquanbu"]];
        _gotoImgView.centerY = self.height/2.f;
        _gotoImgView.right = self.width - ScaleW(12);
    }
    return _gotoImgView;
}



@end
