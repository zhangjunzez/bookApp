//
//  BkBeizhuView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/13.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BkBeizhuView.h"
@interface BkBeizhuView()<UITextViewDelegate>
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *placeHolderLabel;
@property (nonatomic,strong) UITextView *textView;
@end
@implementation BkBeizhuView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(200));
        self.backgroundColor = kWhiteColor;
        [self addSubview:self.nameLabel];
        [self addSubview:self.textView];
        [self addSubview:self.placeHolderLabel];
        self.height = self.textView.bottom + ScaleW(20);
    }
    return self;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:@"订单备注" font:systemFont(ScaleW(13)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(12), ScaleW(14), ScaleW(200), ScaleW(13)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _nameLabel;
}
-(UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(ScaleW(10), ScaleW(10), self.width - ScaleW(24), ScaleW(250))];
        _textView.delegate = self;
        _textView.font = kFont(ScaleW(13));
        _textView.backgroundColor = kWhiteColor;
    }
    return _textView;
}
-(UILabel *)placeHolderLabel{
    if (!_placeHolderLabel) {
        _placeHolderLabel = [WLTools allocLabel:@"请填写备注文字信息~" font:systemFont(14) textColor:kGrayTxtColor frame:CGRectMake(_textView.left, _textView.top + ScaleW(5), _textView.width, ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _placeHolderLabel;
}


#pragma mark ------textViewDelegate

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.placeHolderLabel.hidden = YES;
}


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
