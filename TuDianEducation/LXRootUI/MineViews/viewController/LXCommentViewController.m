//
//  LXCommentViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/30.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXCommentViewController.h"
#import "LXPaySucessViewController.h"
#import "MediaCollectionView.h"
#import "CommentStartView.h"
#import "LXSaveUserInforTool.h"
//#import "UserInforHelper.h"
@interface LXCommentViewController ()<UITextViewDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *headerImgView;
@property (nonatomic, strong) CommentStartView *starView;
@property (nonatomic, strong) UITextView *cancellReTextView;
@property (nonatomic, strong) UILabel *placeHoder;
@property (nonatomic, strong) UIButton *ensureBtn;
@property (nonatomic,strong) MediaCollectionView *mediaView;
@end

@implementation LXCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"去评价";
    self.view.backgroundColor = kWhiteColor;
    [self.view addSubview:self.headerImgView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.starView];
    [self.view addSubview:self.cancellReTextView];
    [self.cancellReTextView addSubview:self.placeHoder];
    [self.cancellReTextView addSubview:self.mediaView];
    
    [self.view addSubview:self.ensureBtn];
}

-(UIImageView *)headerImgView{
    if (!_headerImgView) {
        _headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(10), ScaleW(10), ScaleW(47), ScaleW(63))];
        _headerImgView.backgroundColor = kGrayTxtColor;
    }
    return _headerImgView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:@"初中数学运算大法" font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(10) + _headerImgView.right, ScaleW(10), ScaleW(250), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _titleLabel;
}

-(CommentStartView *)starView{
    if (!_starView) {
        _starView = [[CommentStartView alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom + ScaleW(10), ScaleW(80), ScaleW(14))];
    }
    return _starView;
}
-(UITextView *)cancellReTextView
{
    if (!_cancellReTextView) {
        _cancellReTextView = [[UITextView alloc]initWithFrame:CGRectMake(ScaleW(11), ScaleW(34)+ _headerImgView.bottom, ScreenWidth - ScaleW(22), ScaleW(207))];
        _cancellReTextView.backgroundColor = kMainBgColor;
        _cancellReTextView.delegate = self;
        _cancellReTextView.cornerRadius = ScaleW(10);
        
    }
    return _cancellReTextView;
}
-(UILabel *)placeHoder{
    if (!_placeHoder) {
        _placeHoder = [WLTools allocLabel:@"为了下次更好的相遇，留下你的建议吧！！！" font:systemFont(ScaleW(14)) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(20), ScaleW(20),_cancellReTextView.width - ScaleW(20), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _placeHoder;
}

-(UIButton *)ensureBtn
{
    if (!_ensureBtn) {
        _ensureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _ensureBtn.frame = CGRectMake(ScaleW(11), _cancellReTextView.bottom + ScaleW(50), _cancellReTextView.width,ScaleW(40));
        [_ensureBtn btn:_ensureBtn font:ScaleW(14) textColor:kWhiteColor text:@"提交评论" image:nil sel:@selector(ensureBtnAction:) taget:self];
        _ensureBtn.backgroundColor = kGreenColor;
        _ensureBtn.cornerRadius = _ensureBtn.height/2.f;
    }
    return _ensureBtn;
}
-(MediaCollectionView *)mediaView{
    if (!_mediaView) {
        _mediaView = [[MediaCollectionView alloc]initWithFrame:CGRectMake(ScaleW(15),  _cancellReTextView.height - ScaleW(60), ScaleW(320), ScaleW(50))];
        WS(weakSelf);
        _mediaView.limitCount = 5;
        _mediaView.row = 5;
        
        [LXSaveUserInforTool sharedUserTool].medaiType = 1;
        _mediaView.showCurrentIndexBlock = ^(NSInteger currentIndex) {
            //[weakSelf selectedIndex:currentIndex];
        };
        _mediaView.addCurrentBlock = ^{
           
        };
    }
    return _mediaView;
}

-(void)ensureBtnAction:(UIButton *)sender
{
//    [self teacherCommentRequst];
//    [self dissmiss];
    LXPaySucessViewController *vc = [[LXPaySucessViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)dissmiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//-(void)teacherCommentRequst{
//    if (_cancellReTextView.text.length == 0) {
//        [MBProgressHUD showError:@"请输入评论"];
//        return;
//    }
//
////    token    string    是    令牌
////    orderId    string    是    订单id
////    teacherId    string    是    教师id
////    stars    string    是    星星
////    content    string    是    评价内容
//    NSString *stars = [NSString stringWithFormat:@"%ld",_starView.commentStar];
//    NSString *teacherId = [self.view stringValue:_model.teacherId];
//    NSDictionary *pama = @{@"token":kToken,@"content":_cancellReTextView.text.length?_cancellReTextView.text:@"",@"orderId":_model.ID?:@"",@"stars":stars,@"teacherId":teacherId};
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [DYHttpHepler orderCommonSaveRequstpara:nil para:pama showMsg:YES enableView:nil data:^(long code, id  _Nullable result) {
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        if (code == 200) {
//
//        }
//        !self.callBackBlock?:self.callBackBlock();
//    } error:^(long code, id  _Nullable result) {
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//    }];
//}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *contentString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if (contentString.length == 0) {
        self.placeHoder.hidden = NO;
    }else{
        self.placeHoder.hidden = YES;
    }
    return YES;
}
@end
