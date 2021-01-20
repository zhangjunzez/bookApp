//
//  LXHeaderSignItemView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/23.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXHeaderSignItemView.h"
@interface LXHeaderSignItemView()
@property (nonatomic,strong) NSString *title;
@property (nonatomic,assign) CGFloat top;
@property (nonatomic,strong) NSString *subTitle;
@property (nonatomic,strong) NSString *imageName;
@property (nonatomic,assign) CGFloat left;

@property (nonatomic,strong) UILabel *namelabel;
@property (nonatomic,strong) UILabel *subNameLabel;
@property (nonatomic,strong) UIImageView *imageView;
@end

@implementation LXHeaderSignItemView

-(instancetype)initWithTop:(CGFloat)top left:(CGFloat)left title:(NSString *)title subTitle:(NSString *)subTitle imgeName:(NSString *)imgeName
{
    if (self = [super init])
    {
        _top = top;
        _left = left;
        _title = title;
        _subTitle = subTitle;
        _imageName = imgeName;
        [self viewConfig];
    }
    return self;
};
-(void)viewConfig{
    self.backgroundColor = kWhiteColor;
    [self setCornerRadius:ScaleW(5)];
    self.frame = CGRectMake(_left, _top, ScaleW(168), ScaleW(107));
    [self addSubview:self.namelabel];
    [self addSubview:self.subNameLabel];
    [self addSubview:self.imageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

-(UILabel *)namelabel
{
    if (!_namelabel) {
        _namelabel = [WLTools allocLabel:_title font:systemBoldFont(ScaleW(16)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(17), ScaleW(18), ScaleW(120), ScaleW(16)) textAlignment:(NSTextAlignmentLeft)];
        
    }
    return _namelabel;
}
-(UILabel *)subNameLabel{
    if (!_subNameLabel) {
        _subNameLabel = [WLTools allocLabel:_subTitle font:systemFont(ScaleW(11)) textColor:kGrayTxtColor frame:CGRectMake(_namelabel.left, _namelabel.bottom + ScaleW(11), ScaleW(100), ScaleW(11)) textAlignment:(NSTextAlignmentLeft)];
        
    }
    return _subNameLabel;
}
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:_imageName]];
        _imageView.right = self.width - ScaleW(5);
        _imageView.bottom = self.height - ScaleW(5);
        
    }
    return _imageView;
}
-(void)tapAction:(UITapGestureRecognizer *)tap{
    !self.itemClickedBlock?:self.itemClickedBlock();
}

@end
