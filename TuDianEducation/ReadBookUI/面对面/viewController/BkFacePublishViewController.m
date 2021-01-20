//
//  BkFacePublishViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/11.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//


#import "BkFacePublishViewController.h"
#import "MediaCollectionView.h"
#import "RegularExpression.h"
#import "LXSaveUserInforTool.h"


@interface BkFacePublishViewController ()<UITextViewDelegate>
@property (nonatomic, strong) UIView *textViewBgView;
@property (nonatomic, strong) UIView *septorLine;
@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UILabel *placeHolderLabel;
@property (nonatomic, strong) UIButton *commitBtn;


@property (nonatomic,strong) UITextField *telTextFiled;
@property (nonatomic,strong) MediaCollectionView *mediaView;

@property (nonatomic,strong) UILabel *chirdrenLabel;
@property (nonatomic,strong) UIButton *ageBtn;

@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation BkFacePublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布心得";

   
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = kWhiteColor;

    
    
}
-(UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(200))];
        [_headerView addSubview:self.textViewBgView];
        [self.textViewBgView addSubview:self.septorLine];
        [self.textViewBgView addSubview:self.textView];
        [self.textViewBgView addSubview:self.placeHolderLabel];
        self.textViewBgView.height = ScaleW(163);
        [_headerView addSubview:self.mediaView];
        [_headerView addSubview:self.chirdrenLabel];
        [_headerView addSubview:self.ageBtn];
        [_headerView addSubview:self.commitBtn];
        _headerView.height = self.commitBtn.bottom + ScaleW(20);
    }
    return _headerView;
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
        _placeHolderLabel = [WLTools allocLabel:@"#孩子如何教育#" font:systemFont(14) textColor:kGrayTxtColor frame:CGRectMake(_textView.left, _textView.top + ScaleW(5), _textView.width, ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _placeHolderLabel;
}


-(MediaCollectionView *)mediaView{
    if (!_mediaView) {
        _mediaView = [[MediaCollectionView alloc]initWithFrame:CGRectMake(ScaleW(15),  _textViewBgView.bottom + ScaleW(20), ScaleW(320), ScaleW(50))];
        WS(weakSelf);
        _mediaView.limitCount = 5;
        _mediaView.row = 5;
        _mediaView.collectionView.backgroundColor = kWhiteColor;
        [LXSaveUserInforTool sharedUserTool].medaiType = 2;
        _mediaView.showCurrentIndexBlock = ^(NSInteger currentIndex) {
            //[weakSelf selectedIndex:currentIndex];
        };
        _mediaView.addCurrentBlock = ^{
           
        };
    }
    return _mediaView;
}
-(UILabel *)chirdrenLabel{
    if (!_chirdrenLabel) {
        _chirdrenLabel = [WLTools allocLabel:@"   选择孩子年龄段" font:systemFont(ScaleW(13)) textColor:kGreenColor frame:CGRectMake(0, ScaleW(40) + _mediaView.bottom, ScreenWidth, ScaleW(40)) textAlignment:(NSTextAlignmentLeft)];
        _chirdrenLabel.backgroundColor = UIColorFromRGB(0xF2FFF9);
    }
    return _chirdrenLabel;
}
-(UIButton *)ageBtn{
    if (!_ageBtn) {
        _ageBtn = [WLTools allocButtonTitle:@"0~3岁" font:systemFont(ScaleW(12)) textColor:kSubTxtColor image:[UIImage imageNamed:@"下拉"] frame:CGRectMake(ScaleW(11), ScaleW(15) + _chirdrenLabel.bottom, ScaleW(78), ScaleW(22)) sel:@selector(ageAction:) taget:self];
        _ageBtn.cornerRadius = _ageBtn.height/2.f;
        [_ageBtn setBorderWithWidth:.5 andColor:kMainLineColor];
        [_ageBtn setBtnLeftLabelRightImgOffSet:ScaleW(5)];
    }
    return _ageBtn;
}
-(void)ageAction:(UIButton *)sender
{
    
}
-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitBtn.frame = CGRectMake(ScaleW(10), ScaleW(50) + _ageBtn.bottom, ScreenWidth - ScaleW(20), kCommitBtnHeight);
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
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar ) style:(UITableViewStyleGrouped)];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = kWhiteColor;
        _tableView.tableHeaderView = self.headerView;
        if (@available(iOS 11.0, *))
        {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
       
    }
    return _tableView;
}

@end
