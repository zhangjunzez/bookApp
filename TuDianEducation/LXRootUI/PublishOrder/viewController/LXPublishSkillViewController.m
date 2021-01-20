//
//  LXPublishSkillViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/1.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXPublishSkillViewController.h"
#import "LXGetMoneyRecodeViewController.h"
#import "LXPublishSucessViewController.h"

#import "LXApplyGetMoneyItemView.h"
#import "LXTitleImgeArrayItemView.h"
#import "LXPublishTileTxtView.h"
#import "ETF_Default_ActionsheetView.h"
#import "LXSaveUserInforTool.h"

@interface LXPublishSkillViewController ()<UITextViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIImageView *headerImg;
@property (nonatomic,strong) LXApplyGetMoneyItemView *titleView;
@property (nonatomic,strong) LXApplyGetMoneyItemView *shareTypeView;
@property (nonatomic,strong) LXPublishTileTxtView *oneTxtView;
@property (nonatomic,strong) LXTitleImgeArrayItemView *oneImgView;
@property (nonatomic,strong) LXPublishTileTxtView *twoTxtView;
@property (nonatomic,strong) LXTitleImgeArrayItemView *twoImgView;
@property (nonatomic,strong) LXPublishTileTxtView *threeTxtView;
@property (nonatomic,strong) LXTitleImgeArrayItemView *threeImgView;
@property (nonatomic,strong) UIButton *commitBtn;

@property (nonatomic,strong) NSArray *dataList;
@property (nonatomic,strong) NSString *currentId;
@end

@implementation LXPublishSkillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    self.title = @"技能分享发布";
    //[self addRightNavItemWithTitle:@"提现记录" color:kMainTxtColor font:systemFont(ScaleW(16))];
    [self requstBigImgeRqust];
    [self requsetHangYeIdRequstAction];
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar)];
        _scrollView.backgroundColor = kMainBgColor;
        [_scrollView addSubview:self.headerImg];
        [_scrollView addSubview:self.titleView];
        [_scrollView addSubview:self.shareTypeView];
        [_scrollView addSubview:self.oneTxtView];
        [_scrollView addSubview:self.oneImgView];
        [_scrollView addSubview:self.twoTxtView];
        [_scrollView addSubview:self.twoImgView];
        [_scrollView addSubview:self.threeTxtView];
        [_scrollView addSubview:self.threeImgView];
        [_scrollView addSubview:self.commitBtn];
        
        if (ScreenHeight  < self.commitBtn.bottom + ScaleW(160)) {
            self.scrollView.contentSize = CGSizeMake(0, self.commitBtn.bottom + ScaleW(160));
        }else{
            self.scrollView.contentSize = CGSizeMake(0, ScreenHeight);
        }
        
    }
    return _scrollView;
}
-(UIImageView *)headerImg{
    if (!_headerImg) {
        _headerImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(130))];
        _headerImg.image = [UIImage imageWithColor:kGrayBtnBacColor];
    }
    return _headerImg;
}
-(LXApplyGetMoneyItemView *)titleView{
    if (!_titleView) {
        _titleView = [[LXApplyGetMoneyItemView alloc]initWithTitle:@"标题" top:ScaleW(10) + _headerImg.bottom placeHolder:@"请输入"];
    }
    return _titleView;
}
-(LXApplyGetMoneyItemView *)shareTypeView{
    if (!_shareTypeView) {
        _shareTypeView = [[LXApplyGetMoneyItemView alloc]initWithTitle:@"分享类型" top:_titleView.bottom + ScaleW(10) placeHolder:@"请选择" redHidden:NO isgGotoAction:YES];
        WS(weakSelf);
        _shareTypeView.gotoInforActionBlock = ^{
            [weakSelf showAlertSheet];
        };
    }
    return _shareTypeView;
}
-(LXPublishTileTxtView *)oneTxtView{
    if (!_oneTxtView) {
        _oneTxtView = [[LXPublishTileTxtView alloc]initWithTop:_shareTypeView.bottom  + ScaleW(10) titleString:@"段落一" placeHolder:@"请输入需求信息~" redHidden:YES];
    }
    return _oneTxtView;
}
-(LXTitleImgeArrayItemView *)oneImgView{
    if (!_oneImgView) {
        _oneImgView = [[LXTitleImgeArrayItemView alloc]initWithTop:_oneTxtView.bottom +ScaleW(5) title:@"图片一" imgeArray:@[@""] redHidden:YES];
        _oneImgView.limitCount = 1;
    }
    return _oneImgView;
}
-(LXPublishTileTxtView *)twoTxtView{
    if (!_twoTxtView) {
        _twoTxtView = [[LXPublishTileTxtView alloc]initWithTop:_oneImgView.bottom  + ScaleW(10) titleString:@"段落二" placeHolder:@"请输入需求信息~" redHidden:YES];
        
    }
    return _twoTxtView;
}
-(LXTitleImgeArrayItemView *)twoImgView{
    if (!_twoImgView) {
        _twoImgView = [[LXTitleImgeArrayItemView alloc]initWithTop:_twoTxtView.bottom +ScaleW(5) title:@"图片二" imgeArray:@[@""] redHidden:YES];
        _twoImgView.limitCount = 1;
    }
    return _twoImgView;
}
-(LXPublishTileTxtView *)threeTxtView{
    if (!_threeTxtView) {
        _threeTxtView = [[LXPublishTileTxtView alloc]initWithTop:_twoImgView.bottom  + ScaleW(10) titleString:@"段落三" placeHolder:@"请输入需求信息~" redHidden:YES];
    }
    return _threeTxtView;
}
-(LXTitleImgeArrayItemView *)threeImgView{
    if (!_threeImgView) {
        _threeImgView = [[LXTitleImgeArrayItemView alloc]initWithTop:_threeTxtView.bottom +ScaleW(5) title:@"图片三" imgeArray:@[@""] redHidden:YES];
        _threeImgView.limitCount = 1;
    }
    return _threeImgView;
}
-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [WLTools allocButtonTitle:@"发布" font:systemBoldFont(17) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(100), ScaleW(52) + _threeImgView.bottom, ScaleW(175), ScaleW(40)) sel:@selector(commitAction:) taget:self];
        _commitBtn.backgroundColor = kBlueColor;
        [_commitBtn setCornerRadius:_commitBtn.height/2.f];
    }
    return _commitBtn;
}

-(void)requsetHangYeIdRequstAction{
    
    [NetWorkTools postConJSONWithUrl:kGetskillstype parameters:@{} success:^(id responseObject) {
           NSString *result = responseObject[@"result"];
           NSString *resultNote = responseObject[@"resultNote"];
           NSArray *dataList = responseObject[@"dataList"];
           if ([result integerValue] == 0) {
               self.dataList = dataList;
               
           }else{
               [MBProgressHUD showError:resultNote];
           }
       } fail:^(NSError *error) {
           
       }];
}
//kGetimagesUrl
#pragma mark ---获取封面图片
-(void)requstBigImgeRqust{
    [NetWorkTools postConJSONWithUrl:kGetimagesUrl parameters:@{@"type":@"4"} success:^(id responseObject) {
        NSString *result = responseObject[@"result"];
        NSString *resultNote = responseObject[@"resultNote"];
        NSString *datastr = responseObject[@"datastr"];
        if ([result integerValue] == 0) {
            [self.headerImg sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:datastr]] placeholderImage:[UIImage imageWithColor:kGrayBtnBacColor]];
        }else{
            [MBProgressHUD showError:resultNote];
        }
    } fail:^(NSError *error) {
        
    }];
}

-(void)showAlertSheet{
    NSMutableArray  *nameArray = [NSMutableArray array];
    NSMutableArray *inidArray = [NSMutableArray array];
    for (NSDictionary *dic in self.dataList) {
        [nameArray addObject:dic[@"name"]];
        [inidArray addObject:dic[@"tid"]];
    };
    WS(weakSelf);
    [ETF_Default_ActionsheetView showWithItems:nameArray title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
             // [weakSelf requstEdtingWithKey:@"inid" value:inidArray[selectIndex]];
        weakSelf.shareTypeView.textFied.text = nameArray[selectIndex];
        weakSelf.currentId = inidArray[selectIndex];
        } cancleBlock:^{
                   
    }];
}
//参数名    必选    类型    说明
//cmd    是    string    addskills
//uid    是    string    工程师id
//skillsid    否    string    技能id 传了是修改 不传是新增
//tid    是    string    分类id
//title    是    string    标题
//content1    是    string    段落一
//content2    是    string    段落二
//content3    是    string    段落三
//images1    是    string    图片一
//images2    是    string    图片二
//images3    是    string    图片三
-(void)commitAction:(UIButton *)sender{
    if ([self pamasIsOkOrNot]) {
        NSDictionary *pamas = @{@"tid":_currentId,@"title":_titleView.textFied.text};
        NSMutableDictionary *muPams = [NSMutableDictionary dictionaryWithDictionary:pamas];
        if (_oneTxtView.textView.text.length) {
            [muPams setValue:_oneTxtView.textView.text forKey:@"content1"];
        }
        if (_twoTxtView.textView.text.length) {
           [muPams setValue:_twoTxtView.textView.text forKey:@"content2"];
        }
        if (_threeTxtView.textView.text.length) {
           [muPams setValue:_twoTxtView.textView.text forKey:@"content3"];
        }
        if (_oneImgView.urlsString.length) {
           [muPams setValue:_oneImgView.urlsString forKey:@"images1"];
        }
        if (_twoImgView.urlsString.length) {
             [muPams setValue:_twoImgView.urlsString forKey:@"images2"];
        }
        if (_threeImgView.urlsString.length) {
             [muPams setValue:_threeImgView.urlsString forKey:@"images3"];
        }
        
        WS(weakSelf);
           [NetWorkTools postConJSONWithUrl:kAddskillsUrl parameters:muPams success:^(id responseObject) {
               
               NSString *result = responseObject[@"result"];
               NSString *resultNote = responseObject[@"resultNote"];
               if ([result integerValue] == 0) {
                   [weakSelf sucessAlertShow];
               }else{
                   [MBProgressHUD showError:resultNote];
               }
               
              } fail:^(NSError *error) {
                  
        }];
    }
   
}

-(BOOL)pamasIsOkOrNot{
   
    if (!self.titleView.textFied.text.length) {
           [MBProgressHUD showError:@"请上传您的轮播图片"];
           return NO;
       }

    if (!self.currentId.length) {
           [MBProgressHUD showError:SSKJLanguage(@"请选择您的分享类型")];
          return NO;
       }

        BOOL isData = NO;
       if (self.oneTxtView.textView.text.length) {
           //[MBProgressHUD showError:SSKJLanguage(@"请输入段落一")];
           isData = YES;
       }
    if (self.oneImgView.urlsString.length) {
           //[MBProgressHUD showError:@"请输入图片一"];
           isData = YES;
       }

    if (self.twoTxtView.textView.text.length) {
           //[MBProgressHUD showError:SSKJLanguage(@"请输入段落二")];
          isData = YES;
       }


       if (self.twoImgView.urlsString.length) {
           //[MBProgressHUD showError:SSKJLanguage(@"请输入图片二")];
           isData = YES;
       }
       if (self.threeTxtView.textView.text.length) {
              //[MBProgressHUD showError:SSKJLanguage(@"请输入您的段落三")];
          isData = YES;
        }
       if (self.threeImgView.urlsString.length) {
           //[MBProgressHUD showError:@"请上传您的图片三"];
           isData = YES;
       }
    
    if (!isData) {
        [MBProgressHUD showError:@"请至少选择一个图片或者文字"];
        return NO;
    }
    return YES;
}
-(void)sucessAlertShow{
    LXPublishSucessViewController *vc = [[LXPublishSucessViewController alloc]init];
    vc.callBackBlcok = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self preasntVc:vc];
}
@end
