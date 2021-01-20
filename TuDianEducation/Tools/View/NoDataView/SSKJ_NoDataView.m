//
//  QBWShowNoDataView.m
//  ZYW_MIT
//
//  Created by 张本超 on 2018/4/28.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "SSKJ_NoDataView.h"


#define textLabelFontHeight  12.f
#define spetorHeight 10.f
@interface SSKJ_NoDataView()


@property (nonatomic, strong) UILabel *textLabel;


@end
@implementation SSKJ_NoDataView
//
+(instancetype)showNoData:(BOOL)haveData toView:(UIView *)view offY:(CGFloat) offY
{
    SSKJ_NoDataView *viewResult = [[SSKJ_NoDataView alloc]initWithFrame:CGRectMake(0, offY, view.width, view.height - offY)];
    for (UIView *v in view.subviews) {
        if ([v isKindOfClass:[SSKJ_NoDataView class]]) {
            [v removeFromSuperview];
            break;
        }
    }
    if (haveData)
    {
        
    }else{
      [view addSubview:viewResult];
    }
    return viewResult;
};
+(instancetype)showNoData:(BOOL)haveData toView:(UIView *)view offY:(CGFloat) offY message:(NSString *)message imge:(UIImage *)img
{
    SSKJ_NoDataView *viewResult = [[SSKJ_NoDataView alloc]initWithFrame:CGRectMake(0, offY, view.width, view.height - offY)];
    viewResult.img.image = img;
    viewResult.img.size = img.size;
    viewResult.img.centerX = viewResult.width/2.f;
    viewResult.img.centerY = viewResult.height/3.f;
    viewResult.textLabel.text = message;
    viewResult.backgroundColor = kWhiteColor;
    viewResult.textLabel.top = viewResult.img.bottom + ScaleW(10);
    for (UIView *v in view.subviews) {
        if ([v isKindOfClass:[SSKJ_NoDataView class]]) {
            [v removeFromSuperview];
            break;
        }
    }
    if (haveData)
    {
        
    }else{
      [view addSubview:viewResult];
    }
    return viewResult;
};
+(instancetype)showNoData:(BOOL)haveData toView:(UIView *)view frame:(CGRect)frame
{
    SSKJ_NoDataView *viewResult = [[SSKJ_NoDataView alloc]initWithFrame:view.bounds];
    viewResult.frame = frame;
    viewResult.img.centerY = viewResult.height / 2;
    viewResult.textLabel.top = viewResult.img.bottom + spetorHeight;
    for (UIView *v in view.subviews) {
        if ([v isKindOfClass:[SSKJ_NoDataView class]]) {
            [v removeFromSuperview];
            break;
        }
    }
    if (haveData)
    {
        
    }
    else
    {
        [view addSubview:viewResult];
    }
    return viewResult;
};
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"public_noData"]];
        self.img.centerX = self.centerX;
        self.img.centerY = self.height / 2 - self.img.image.size.height / 2;
        [self addSubview:self.img];
        [self addSubview:self.textLabel];
        self.backgroundColor = kMainBgColor;
    }
    return self;
}

-(UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.width = self.width;
        _textLabel.height = textLabelFontHeight;
        _textLabel.left = 0;
        _textLabel.top = _img.bottom + spetorHeight;
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [_textLabel label:_textLabel font:textLabelFontHeight textColor:UIColorFromRGB(0xC0CDDD) text:SSKJLocalized(@"暂无记录", nil)];
        
    }
    return _textLabel;
}
@end
