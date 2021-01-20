//
//  DSUserDelegeViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/6.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//


#import "DSUserDelegeViewController.h"
#import "UILabel+RichText.h"
@interface DSUserDelegeViewController ()
@property (nonatomic,strong) UIView *mainView;
@property (nonatomic,strong) UIImageView *titleImgView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIButton *cancelBtn;
@property (nonatomic,strong) UIButton *commitBtn;

@end

@implementation DSUserDelegeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBacColor;
    [self.view addSubview:self.mainView];
    

}

-(UIView *)mainView{
    if (!_mainView) {
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(53), ScaleW(200), ScreenWidth - ScaleW(106), ScaleW(340))];
        _mainView.backgroundColor = kWhiteColor;
        [_mainView setCornerRadius:ScaleW(10)];
        [_mainView addSubview:self.titleImgView];
        [_mainView addSubview:self.titleLabel];
        [_mainView addSubview:self.scrollView];
        [_mainView addSubview:self.cancelBtn];
       [_mainView addSubview:self.commitBtn];
        _mainView.centerY = ScreenHeight/2.f;
    }
    return _mainView;
}
-(UIImageView *)titleImgView{
    if (!_titleImgView ){
        _titleImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lingdang"]];
        _titleImgView.centerX = _mainView.width/2.f;
        _titleImgView.top = ScaleW(5);
    }
    return _titleImgView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:@"用户协议与隐私政策" font:systemFont(ScaleW(17)) textColor:kMainTxtColor frame:CGRectMake(0, ScaleW(10) + _titleImgView.bottom, self.mainView.width, ScaleW(17)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _titleLabel;
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(ScaleW(0), ScaleW(25) + _titleLabel.bottom, _mainView.width, ScaleW(123))];
        UILabel *subLabel1 = [WLTools allocLabel:@"欢迎使用戴胜鸟图书APP软件，在您成为戴胜鸟的一员，务必仔细阅读，充分理解协议中的条款内容候后再点击同意。" font:systemFont(ScaleW(12)) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(18), ScaleW(5), ScaleW(235), ScaleW(50)) textAlignment:(NSTextAlignmentLeft)];
        [_scrollView addSubview:subLabel1];
        UILabel *subLabel2 = [WLTools allocLabel:@"您可阅读《服务协议》和《隐私协议》了解详细信息，如您同意，请点击同意，开始接受我们的服务。" font:systemFont(ScaleW(12)) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(18), ScaleW(15) + subLabel1.bottom, ScaleW(235), ScaleW(50)) textAlignment:(NSTextAlignmentLeft)];
        subLabel2.userInteractionEnabled = YES;
        [_scrollView addSubview:subLabel1];
        NSString *string = subLabel2.text;
        NSMutableAttributedString *atts = [[NSMutableAttributedString alloc] initWithString:string];
        [atts setAttributes:@{ NSForegroundColorAttributeName:kGreenColor,NSFontAttributeName:systemFont(ScaleW(12))} range:NSMakeRange(4,  6)];
        [atts setAttributes:@{ NSForegroundColorAttributeName:kGreenColor,NSFontAttributeName:systemFont(ScaleW(12))} range:NSMakeRange(11,  6)];
        subLabel2.attributedText = atts;
        
        [subLabel2 clickRichTextWithStrings:@[@"《服务协议》",@"《隐私协议》"] clickAction:^(NSString * _Nonnull string, NSRange range, NSInteger index) {
                    
        }];
        [_scrollView addSubview:subLabel2];
        _scrollView.contentSize = CGSizeMake(0, subLabel2.bottom + ScaleW(20));
    }
    return _scrollView;
}
-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [WLTools allocButtonTitle:@"不同意" font:systemFont(15) textColor:kMainTxtColor image:nil frame:CGRectMake(ScaleW(20),_mainView.height - ScaleW(47) , ScaleW(113), ScaleW(33)) sel:@selector(cancellBtnBtnAction) taget:self];
       
    }
    return _cancelBtn;
}
#pragma mark ---取消
-(void)cancellBtnBtnAction{
    !self.callBackBlock?:self.callBackBlock(NO);
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [WLTools allocButtonTitle:@"同意" font:systemFont(15) textColor:kGreenColor image:nil frame:CGRectMake(_cancelBtn.right,_mainView.height - ScaleW(47) , ScaleW(113), ScaleW(33)) sel:@selector(commitAction) taget:self];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(_commitBtn.width - 1, 0, 1, _commitBtn.height)];
        [_commitBtn addSubview:line];
    }
    return _commitBtn;
}
-(void)commitAction{
    !self.callBackBlock?:self.callBackBlock(YES);
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}




@end
