//
//  LXLearnningHeaderView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/30.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXLearnningHeaderView.h"
@interface LXLearnningHeaderView()
@property (nonatomic,strong) UIView *searchBacView;
@property (nonatomic,strong) UIImageView *searchImg;

@property (nonatomic,strong) UIButton *searchBtn;
@end

@implementation LXLearnningHeaderView

-(instancetype)init{
    if (self = [super init]) {
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig{
    self.backgroundColor = kWhiteColor;
    self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(50));
    [self addSubview:self.searchBacView];
    [self.searchBacView addSubview:self.searchImg];
    [self.searchBacView addSubview:self.searchTf];
    [self addSubview:self.searchBtn];
}
-(UIView *)searchBacView{
    if (!_searchBacView) {
        _searchBacView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(20), ScaleW(10), ScaleW(284), ScaleW(30))];
        _searchBacView.backgroundColor = kMainBgColor;
        [_searchBacView setCornerRadius:_searchBacView.height/2.f];
    }
    return _searchBacView;
}
-(UIImageView *)searchImg{
    if (!_searchImg) {
        _searchImg = [[UIImageView alloc ]initWithFrame:CGRectMake(ScaleW(10), ScaleW(9), ScaleW(12), ScaleW(12))];
        _searchImg.image = [UIImage imageNamed:@"xuexi_sousuo"];
    }
    return _searchImg;
}

-(UITextField *)searchTf{
    if (!_searchTf) {
        
        _searchTf = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(6) + _searchImg.right, 0, _searchBacView.width - ScaleW(12)- _searchImg.right, _searchBacView.height)];
        [_searchTf textField:_searchTf textFont:ScaleW(12) placeHolderFont:ScaleW(12) text:nil placeText:@"请输入关键词搜索" textColor:kMainTxtColor placeHolderTextColor:kGrayTxtColor];
    }
    return _searchTf;
}
-(UIButton *)searchBtn{
    if (!_searchBtn) {
        _searchBtn = [WLTools allocButtonTitle:@"搜索" font:systemFont(ScaleW(16)) textColor:kGrayTxtColor image:nil frame:CGRectMake(_searchBacView.right, _searchBacView.top, ScaleW(62),_searchBacView.height) sel:@selector(searchAction:) taget:self];
    }
    return _searchBtn;
}

-(void)searchAction:(UIButton *)sender
{
    !self.searchBlock?:self.searchBlock();
}
@end
