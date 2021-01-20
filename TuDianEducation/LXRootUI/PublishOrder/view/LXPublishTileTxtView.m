//
//  LXPublishTileTxtView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/30.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXPublishTileTxtView.h"
@interface LXPublishTileTxtView()<UITextViewDelegate>
@property (nonatomic,strong) UILabel *redPointLabel;
@property (nonatomic,strong) UILabel *titleLabel;


@end

@implementation LXPublishTileTxtView
-(instancetype)initWithTop:(CGFloat)top titleString:(NSString *)titleString placeHolder:(NSString *)placeHolder redHidden:(BOOL)redHidden{
    if (self = [super init]) {
        self = [[LXPublishTileTxtView alloc]initWithFrame:CGRectMake(0, top ,ScreenWidth, ScaleW(120))];
        self.backgroundColor = kWhiteColor;
        [self addSubview:self.redPointLabel];
        self.redPointLabel.hidden = redHidden;
        [self addSubview:self.titleLabel];
        self.titleLabel.text = titleString;
       
        [self addSubview:self.textView];
        [self.textView addSubview:self.placeHolderLabel];
         self.placeHolderLabel.text = placeHolder;
        
    }
    return self;
};
-(UILabel *)redPointLabel{
    if (!_redPointLabel) {
        _redPointLabel = [WLTools allocLabel:@"*" font:systemFont(ScaleW(14)) textColor:kRedColor frame:CGRectMake(ScaleW(12), ScaleW(15), ScaleW(15), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _redPointLabel;
}
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:@"" font:systemBoldFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(26), ScaleW(15), ScreenWidth - ScaleW(26), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _titleLabel;
}
-(UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(ScaleW(26), ScaleW(14) + _titleLabel.bottom, self.width - ScaleW(52), ScaleW(70))];
        _textView.delegate = self;
        _textView.font = kFont(15);
    }
    return _textView;
}
-(UILabel *)placeHolderLabel{
    if (!_placeHolderLabel) {
        _placeHolderLabel = [WLTools allocLabel:@"" font:systemFont(14) textColor:kGrayTxtColor frame:CGRectMake(0,  ScaleW(5), _textView.width - ScaleW(30), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _placeHolderLabel;
}
#pragma mark --textViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *contentString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if (contentString.length == 0) {
        self.placeHolderLabel.hidden = NO;
    }else{
        self.placeHolderLabel.hidden = YES;
    }
    return YES;
}
@end
