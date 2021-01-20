//
//  LXTitleImgView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/29.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXTitleImgView.h"
@interface LXTitleImgView()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) NSString *titleString;
@property (nonatomic,assign) CGFloat top;

@property (nonatomic,strong) NSMutableArray *UiArray;
@property (nonatomic,assign) CGFloat imgWidth;
@end
@implementation LXTitleImgView

-(instancetype)initWithTop:(CGFloat)top title:(NSString *)title imageArray:(NSArray *)imgArray imgeWidth:(CGFloat)imgwidth{
    if (self = [super init]) {
        self.titleString = title;
        self.top = top;
        self.imgWidth = imgwidth;
        [self viewConfig];
         self.imgArray = imgArray;
    }
    return self;
};
-(void)viewConfig{
    self.frame = CGRectMake(0, _top, ScreenWidth, ScaleW(100));
    [self addSubview:self.titleLabel];
}
-(NSMutableArray *)UiArray
{
    if (!_UiArray) {
        _UiArray = [NSMutableArray array];
    }
    return _UiArray;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:_titleString font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), ScaleW(15), ScaleW(80), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _titleLabel;
}

-(void)setImgArray:(NSArray *)imgArray{
    _imgArray = imgArray;
    for (UIView *v  in self.UiArray) {
        [v removeFromSuperview];
    }
    
    if (_imgWidth > 200) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(115), ScaleW(15), ScaleW(246), ScaleW(141))];
        imgView.backgroundColor = kBlueColor;
        [self addSubview:imgView];
        [self.UiArray addObject:imgView];
        [imgView sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:_imgArray.firstObject]]];
        self.height = imgView.bottom + ScaleW(15);
    }else{
        for (int i = 0; i < self.imgArray.count; i ++) {
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(115) + (i%3)*(ScaleW(85)), ScaleW(15) + (i/3)*(ScaleW(85)), ScaleW(75), ScaleW(75))];
            imgView.backgroundColor = kBlueColor;
            [self addSubview:imgView];
            [self.UiArray addObject:imgView];
            [imgView sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:_imgArray[i]]]];
        }
        UIImageView *imgView = self.UiArray.lastObject;
         self.height = imgView.bottom + ScaleW(15);
    }
}
@end
