//
//  BkSignViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/11.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BkSignViewController.h"
#import "RegularExpression.h"

#define limtWords 500
@interface BkSignViewController ()<UITextViewDelegate>
@property (nonatomic, strong) UIView *textViewBgView;
@property (nonatomic, strong) UIView *septorLine;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *wordsLabel;
@property (nonatomic, strong) UILabel *placeHolderLabel;
@property (nonatomic, strong) UIButton *commitBtn;


@property (nonatomic,strong) UITextField *telTextFiled;
@end

@implementation BkSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"签名";
    [self.view addSubview:self.textViewBgView];
    [self.textViewBgView addSubview:self.septorLine];
    [self.textViewBgView addSubview:self.textView];
    [self.textViewBgView addSubview:self.placeHolderLabel];
    [self.textViewBgView addSubview:self.wordsLabel];
    self.textViewBgView.height = self.wordsLabel.bottom + ScaleW(10);
   
    [self.view addSubview:self.commitBtn];
    self.view.backgroundColor = kWhiteColor;

    
    
}
-(UIView *)textViewBgView{
    if (!_textViewBgView) {
        _textViewBgView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(0), ScaleW(10), ScreenWidth, ScaleW(250))];
        _textViewBgView.backgroundColor = kMainBgColor;
        [_textViewBgView setCornerRadius:ScaleW(5)];
    }
    return _textViewBgView;
}
-(UIView *)septorLine{
    if (!_septorLine) {
        _septorLine = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(214), _textViewBgView.width, 1.f)];
        _septorLine.backgroundColor = kMainLineColor;
    }
    return _septorLine;
}
-(UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(ScaleW(10), ScaleW(10), _textViewBgView.width - ScaleW(20), ScaleW(177))];
        _textView.delegate = self;
        _textView.font = kFont(15);
        _textView.backgroundColor = kMainBgColor;
    }
    return _textView;
}
-(UILabel *)placeHolderLabel{
    if (!_placeHolderLabel) {
        _placeHolderLabel = [WLTools allocLabel:@"请输入您的个性签名" font:systemFont(14) textColor:kGrayTxtColor frame:CGRectMake(_textView.left, _textView.top + ScaleW(5), _textView.width, ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _placeHolderLabel;
}
-(UILabel *)wordsLabel{
    if (!_wordsLabel) {
        
        _wordsLabel = [WLTools allocLabel:[NSString stringWithFormat:@"%d/%d",0,limtWords] font:systemFont(14) textColor:kSubTxtColor frame:CGRectMake(_textView.left, _textView.bottom, _textView.width - ScaleW(10), ScaleW(14)) textAlignment:(NSTextAlignmentRight)];
        _wordsLabel.hidden = YES;
    }
    return _wordsLabel;
}



-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitBtn.frame = CGRectMake(ScaleW(10), ScaleW(50) + _textViewBgView.bottom, ScreenWidth - ScaleW(20), kCommitBtnHeight);
        _commitBtn.backgroundColor = kRedColor;
        [_commitBtn btn:_commitBtn font:ScaleW(16) textColor:kWhiteColor text:@"确定" image:nil sel:@selector(commitAction:) taget:self];
        [_commitBtn setCornerRadius:kCommitBtnRadius];
    }
    return _commitBtn;
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
    if (contentString.length<=limtWords||text.length == 0) {
        self.wordsLabel.text = [NSString stringWithFormat:@"%ld/%d",contentString.length,limtWords];
        return YES;
    }
    if (contentString.length>limtWords) {
        [MBProgressHUD showError:@"已超出最大字数"];
        return NO;
    }
    
    return YES;
}
-(void)commitAction:(UIButton *)sender{
    if ([self pamasIsOkOrNot]) {
        NSDictionary *pamas = @{@"content":_textView.text};
        WS(weakSelf);
           [NetWorkTools postConJSONWithUrl:kAddengineerfeedbackUrl parameters:pamas success:^(id responseObject) {
               
               NSString *result = responseObject[@"result"];
               NSString *resultNote = responseObject[@"resultNote"];
               if ([result integerValue] == 0) {
                   [weakSelf.navigationController popViewControllerAnimated:YES];
               }
               [MBProgressHUD showError:resultNote];
              } fail:^(NSError *error) {
                  
        }];
    }
   
}

-(BOOL)pamasIsOkOrNot{
   
       if (!self.textView.text.length) {
          // [SSTool error:SSKJLanguage(@"请输入您的手机号")];
           [MBProgressHUD showError:@"请输入您的个性签名"];
           return NO;
       }

    return YES;
}

@end
