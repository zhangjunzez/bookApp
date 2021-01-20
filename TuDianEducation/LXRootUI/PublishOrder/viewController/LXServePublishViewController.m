//
//  LXServePublishViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/30.
//  Copyright © 2020 zhangbenchao. All rights reserved.

#import "LXServePublishViewController.h"
#import "LXGetMoneyRecodeViewController.h"
#import "LXPublishSucessViewController.h"

#import "LXApplyGetMoneyItemView.h"
#import "LXTitleImgeArrayItemView.h"
#import "LXPublishTileTxtView.h"

#import "LXSaveUserInforTool.h"
#import "ETF_Default_ActionsheetView.h"
#import "GYZChooseCityController.h"
@interface LXServePublishViewController ()<UITextViewDelegate,GYZChooseCityDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIImageView *headerImg;
@property (nonatomic,strong) LXTitleImgeArrayItemView *lunboView;
@property (nonatomic,strong) LXApplyGetMoneyItemView *cityView;
@property (nonatomic,strong) LXApplyGetMoneyItemView *hangyeFenView;
@property (nonatomic,strong) LXApplyGetMoneyItemView *severNameView;
@property (nonatomic,strong) LXApplyGetMoneyItemView *fubiaotiView;
@property (nonatomic,strong) LXApplyGetMoneyItemView *fuwuPriceView;
@property (nonatomic,strong) LXPublishTileTxtView *serverjianjieView;
@property (nonatomic,strong) LXPublishTileTxtView *xiangqingView;
@property (nonatomic,strong) LXTitleImgeArrayItemView *detailPicView;
@property (nonatomic,strong) UIButton *commitBtn;

@property (nonatomic,strong) NSArray *dataList;
@property (nonatomic,strong) NSString *currentId;
@property (nonatomic,strong) NSString *cityId;

@property (nonatomic,strong) LXTitleImgeArrayItemView *currentAddView;

@end

@implementation LXServePublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    self.title = @"服务发布";
    [self requsetHangYeIdRequstAction];
    [self requstBigImgeRqust];
}
-(void)rigthBtnAction:(id)sender{
    LXGetMoneyRecodeViewController *vc = [[LXGetMoneyRecodeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar)];
        _scrollView.backgroundColor = kMainBgColor;
        [_scrollView addSubview:self.headerImg];
        [_scrollView addSubview:self.lunboView];
        [_scrollView addSubview:self.cityView];
        [_scrollView addSubview:self.hangyeFenView];
        [_scrollView addSubview:self.severNameView];
        [_scrollView addSubview:self.fubiaotiView];
        [_scrollView addSubview:self.fuwuPriceView];
        [_scrollView addSubview:self.serverjianjieView];
        [_scrollView addSubview:self.xiangqingView];
        [_scrollView addSubview:self.detailPicView];
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
        _headerImg.backgroundColor = kBlueColor;
    }
    return _headerImg;
}
-(LXTitleImgeArrayItemView *)lunboView{
    if (!_lunboView) {
        _lunboView = [[LXTitleImgeArrayItemView alloc]initWithTop:_headerImg.bottom title:@"轮播图片" imgeArray:@[@""] redHidden:NO];
        
    }
    return _lunboView;
}

-(LXApplyGetMoneyItemView *)cityView
{
    if (!_cityView) {
        _cityView = [[LXApplyGetMoneyItemView alloc]initWithTitle:@"选择城市" top:ScaleW(10) + _lunboView.bottom placeHolder:@"请选择" redHidden:NO isgGotoAction:YES];
        WS(weakSelf);
        _cityView.gotoInforActionBlock = ^{
            [weakSelf getSelfAddressAction];
        };
    }
    return _cityView;
}
-(LXApplyGetMoneyItemView *)hangyeFenView
{
    if (!_hangyeFenView) {
        _hangyeFenView = [[LXApplyGetMoneyItemView alloc]initWithTitle:@"行业分类" top:ScaleW(10) + _cityView.bottom placeHolder:@"请选择" redHidden:NO isgGotoAction:YES];
        WS(weakSelf);
        _hangyeFenView.gotoInforActionBlock = ^{
            [weakSelf showAlertSheet];
        };
    }
    return _hangyeFenView;
}
-(LXApplyGetMoneyItemView *)severNameView
{
    if (!_severNameView) {
        _severNameView = [[LXApplyGetMoneyItemView alloc]initWithTitle:@"服务名称" top:ScaleW(10)  + _hangyeFenView.bottom placeHolder:@"请输入"];
    }
    return _severNameView;
}
-(LXApplyGetMoneyItemView *)fubiaotiView
{
    if (!_fubiaotiView) {
        _fubiaotiView = [[LXApplyGetMoneyItemView alloc]initWithTitle:@"副标题" top:_severNameView.bottom placeHolder:@"请输入" redHidden:YES];
    }
    return _fubiaotiView;
}
-(LXApplyGetMoneyItemView *)fuwuPriceView
{
    if (!_fuwuPriceView) {
        _fuwuPriceView = [[LXApplyGetMoneyItemView alloc]initWithTitle:@"服务价格" top:_fubiaotiView.bottom + ScaleW(10) placeHolder:@"请输入"];
        _fuwuPriceView.textFied.keyboardType = UIKeyboardTypeDecimalPad;
    }
    return _fuwuPriceView;
}
-(LXPublishTileTxtView *)serverjianjieView{
    if (!_serverjianjieView) {
        _serverjianjieView = [[LXPublishTileTxtView alloc]initWithTop:_fuwuPriceView.bottom + ScaleW(10) titleString:@"服务简介" placeHolder:@"请简单介绍下您的服务信息~" redHidden:NO];
    }
    return _serverjianjieView;
}
-(LXPublishTileTxtView *)xiangqingView{
    if (!_xiangqingView) {
        _xiangqingView = [[LXPublishTileTxtView alloc]initWithTop:_serverjianjieView.bottom + ScaleW(10) titleString:@"详情内容" placeHolder:@"请输入您的详细要求~" redHidden:YES];
    }
    return _xiangqingView;
}
-(LXTitleImgeArrayItemView *)detailPicView{
    if (!_detailPicView) {
        _detailPicView = [[LXTitleImgeArrayItemView alloc]initWithTop:_xiangqingView.bottom + ScaleW(10) title:@"详情图片" imgeArray:@[@""] redHidden:YES];
    }
    return _detailPicView;
}
-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [WLTools allocButtonTitle:@"发布" font:systemBoldFont(17) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(100), ScaleW(52) + _detailPicView.bottom, ScaleW(175), ScaleW(40)) sel:@selector(commitAction:) taget:self];
        _commitBtn.backgroundColor = kBlueColor;
        [_commitBtn setCornerRadius:_commitBtn.height/2.f];
    }
    return _commitBtn;
}

-(void)requsetHangYeIdRequstAction{
    
    [NetWorkTools postConJSONWithUrl:kGetindustrysListUrl parameters:@{} success:^(id responseObject) {
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
    [NetWorkTools postConJSONWithUrl:kGetimagesUrl parameters:@{@"type":@"3"} success:^(id responseObject) {
        NSString *result = responseObject[@"result"];
        NSString *resultNote = responseObject[@"resultNote"];
        NSString *datastr = responseObject[@"datastr"];
        if ([result integerValue] == 0) {
            [self.headerImg sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:datastr]]];
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
        [inidArray addObject:dic[@"inid"]];
    };
    WS(weakSelf);
    [ETF_Default_ActionsheetView showWithItems:nameArray title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
             // [weakSelf requstEdtingWithKey:@"inid" value:inidArray[selectIndex]];
        weakSelf.hangyeFenView.textFied.text = nameArray[selectIndex];
        weakSelf.currentId = inidArray[selectIndex];
        } cancleBlock:^{
                   
    }];
}

//参数名    必选    类型    说明
//cmd    是    string    addservicesto
//uid    是    string    工程师id
//servicesid    否    string    服务id 传了是修改 不传是修改
//cid    是    string    城市id
//inid    是    string    行业分类id
//name    是    string    服务名称
//title    是    string    副标题
//price    是    string    价格
//introduction    是    string    服务简介
//content    是    string    详情内容
//bannerimages    是    string[]    轮播图[“”,””]
//detailimages    是    string[]    详情图片[“”,””]
-(void)commitAction:(UIButton *)sender{
    if ([self pamasIsOkOrNot]) {
        NSDictionary *pamas = @{@"cid":[LXSaveUserInforTool sharedUserTool].cityId,@"inid":_currentId,@"name":_severNameView.textFied.text,@"title":_fubiaotiView.textFied.text,@"price":_fuwuPriceView.textFied.text,@"introduction":_serverjianjieView.textView.text,@"content":_xiangqingView.textView.text,@"bannerimages":_lunboView.urlsArray,@"detailimages":_detailPicView.urlsArray};
        WS(weakSelf);
           [NetWorkTools postConJSONWithUrl:kAddservicestoUrl parameters:pamas success:^(id responseObject) {
               
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
   
    if (!self.lunboView.urlsArray.count) {
           [MBProgressHUD showError:@"请上传您的轮播图片"];
           return NO;
       }
    if (!self.cityId.length||!_cityView.textFied.text.length) {
           [MBProgressHUD showError:SSKJLanguage(@"请选择城市")];
           return NO;
    }
    if (!self.currentId.length) {
           [MBProgressHUD showError:SSKJLanguage(@"请选择您的行业分类")];
          return NO;
       }

       if (!self.severNameView.textFied.text.length) {
           [MBProgressHUD showError:SSKJLanguage(@"请输入您的服务名称")];
           return NO;
       }
    if (!self.fubiaotiView.textFied.text.length) {
           [MBProgressHUD showError:@"请输入您的副标题"];
           return NO;
       }

    if (!self.fuwuPriceView.textFied.text.length) {
           [MBProgressHUD showError:SSKJLanguage(@"请输入您的服务价格")];
          return NO;
       }


       if (!self.serverjianjieView.textView.text.length) {
           [MBProgressHUD showError:SSKJLanguage(@"请输入您的服务简介")];
           return NO;
       }
       if (!self.serverjianjieView.textView.text.length) {
              [MBProgressHUD showError:SSKJLanguage(@"请输入您的详细要求")];
          return NO;
        }
       if (!self.lunboView.urlsArray.count) {
           [MBProgressHUD showError:@"请上传您的详情图片"];
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
-(void)getSelfAddressAction
{
    GYZChooseCityController *cityPickerVC = [[GYZChooseCityController alloc] init];
        [cityPickerVC setDelegate:self];
        //cityPickerVC.hotCitys = @[@"北京市", @"上海市", @"杭州市", @"广州市", @"深圳市", @"武汉市", @"南京市", @"天津市"];
       
        [self.navigationController pushViewController:cityPickerVC animated:YES];
}
#pragma mark - GYZCityPickerDelegate
- (void) cityPickerController:(GYZChooseCityController *)chooseCityController didSelectCity:(GYZCity *)city
{
        //[[NSUserDefaults standardUserDefaults] setObject:city.cityName forKey:@"jiejuSelectedCity"];
        [LXSaveUserInforTool sharedUserTool].cityId = city.cid;
        self.cityId = city.cid;
        self.cityView.textFied.text = city.cityName;
        
    [chooseCityController.navigationController popViewControllerAnimated:YES];
}

- (void) cityPickerControllerDidCancel:(GYZChooseCityController *)chooseCityController
{
    
}

@end
