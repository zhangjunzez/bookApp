//
//  LXRealNameViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/24.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXRealNameViewController.h"
#import "LXRealNameUploadItemView.h"
#import "LXRealNameSelectView.h"
#import "LXRealCommitSucessAlertVc.h"

#import "ETF_Default_ActionsheetView.h"
@interface LXRealNameViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) LXRealNameUploadItemView *zhengmianView;
@property (nonatomic,strong) LXRealNameUploadItemView *fanMianView;
@property (nonatomic,strong) LXRealNameSelectView *hangyeView;
@property (nonatomic,strong) LXRealNameUploadItemView *zizhiView;
@property (nonatomic,strong) LXRealNameSelectView *congyeTimeView;
@property (nonatomic,strong) LXRealNameSelectView *yearsAgeView;
@property (nonatomic,strong) UIButton *commitBtn;

@property (nonatomic,strong) LXRealNameUploadItemView *currenUploadView;

@property (nonatomic,strong) NSArray *dataList;

@property (nonatomic,strong) NSString *currentId;
@end

@implementation LXRealNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requsetHangYeIdRequstAction];
    [self.view addSubview:self.scrollView];
    self.title = @"实名认证";
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar)];
        _scrollView.backgroundColor = kMainBgColor;
        [_scrollView addSubview:self.zhengmianView];
        [_scrollView addSubview:self.fanMianView];
        [_scrollView addSubview:self.hangyeView];
        [_scrollView addSubview:self.zizhiView];
        [_scrollView addSubview:self.congyeTimeView];
        [_scrollView addSubview:self.yearsAgeView];
        [_scrollView addSubview:self.commitBtn];
        if (ScreenHeight  < self.commitBtn.bottom + ScaleW(60)) {
            self.scrollView.contentSize = CGSizeMake(0, self.commitBtn.bottom + ScaleW(60));
        }else{
            self.scrollView.contentSize = CGSizeMake(0, ScreenHeight);
        }
        
    }
    return _scrollView;
}

-(LXRealNameUploadItemView *)zhengmianView{
    if (!_zhengmianView) {
        _zhengmianView = [[LXRealNameUploadItemView alloc]initWithTop:ScaleW(10) name:@"上传身份证正面"];
        WS(weakSelf);
        _zhengmianView.uploadBlcok = ^{
            weakSelf.currenUploadView = weakSelf.zhengmianView;
            [weakSelf getUserPhoto];
        };
    }
    return _zhengmianView;
}
-(LXRealNameUploadItemView *)fanMianView{
    if (!_fanMianView) {
        _fanMianView = [[LXRealNameUploadItemView alloc]initWithTop:ScaleW(10) + _zhengmianView.bottom name:@"上传身份证反面"];
        WS(weakSelf);
        _fanMianView.uploadBlcok = ^{
          weakSelf.currenUploadView = weakSelf.fanMianView;
            [weakSelf getUserPhoto];
        };
    }
    return _fanMianView;
}
-(LXRealNameSelectView *)hangyeView{
    if (!_hangyeView) {
        _hangyeView = [[LXRealNameSelectView alloc]init];
        _hangyeView.top = _fanMianView.bottom + ScaleW(10);
        _hangyeView.nameLabel.text = @"擅长行业";
        _hangyeView.subNameLabel.text = @"";
        WS(weakSelf);
        _hangyeView.gotoBlock = ^{
            [weakSelf showAlertSheet];
        };
    }
    return _hangyeView;
}
-(LXRealNameUploadItemView *)zizhiView{
    if (!_zizhiView) {
        _zizhiView  = [[LXRealNameUploadItemView alloc]initWithTop:_hangyeView.bottom + ScaleW(10) name:@"上传资质照片"];
        WS(weakSelf);
        _zizhiView.uploadBlcok = ^{
            weakSelf.currenUploadView = weakSelf.zizhiView;
            [weakSelf getUserPhoto];
        };
    }
    return _zizhiView;
}
-(LXRealNameSelectView *)congyeTimeView{
    if (!_congyeTimeView) {
        _congyeTimeView = [[LXRealNameSelectView alloc]init];
        _congyeTimeView.top = _zizhiView.bottom + ScaleW(10);
        _congyeTimeView.nameLabel.text = @"从业时间";
        _congyeTimeView.subNameLabel.text = @"10";
        _congyeTimeView.isEdting = YES;
        _congyeTimeView.gotoBlock = ^{
//            [ETF_Default_ActionsheetView showWithItems:@[@"1",@"2"] title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
//
//                }cancleBlock:^{
//
//            }];
            
        };
    }
    return _congyeTimeView;
}
-(LXRealNameSelectView *)yearsAgeView{
    if (!_yearsAgeView) {
        _yearsAgeView = [[LXRealNameSelectView alloc]init];
        _yearsAgeView.top = _congyeTimeView.bottom ;
        _yearsAgeView.nameLabel.text = @"年纪";
        _yearsAgeView.subNameLabel.text = @"2";
        _yearsAgeView.isEdting = YES;
        _yearsAgeView.gotoBlock = ^{
//            [ETF_Default_ActionsheetView showWithItems:@[@"1",@"2"] title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
//
//
//            } cancleBlock:^{
//
//            }];
        };
    }
    return _yearsAgeView;
}
-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [WLTools allocButtonTitle:@"确认" font:systemBoldFont(17) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(37), ScaleW(37) + _yearsAgeView.bottom, ScaleW(300), ScaleW(50)) sel:@selector(commitAction:) taget:self];
        _commitBtn.backgroundColor = kBlueColor;
        [_commitBtn setCornerRadius:_commitBtn.height/2.f];
    }
    return _commitBtn;
}

-(void)commitAction:(UIButton *)sender{
    if ([self pamasIsOkOrNot]) {
        NSDictionary *pamas = @{@"idcard1":_zhengmianView.currentUrl,@"idcard2":_fanMianView.currentUrl,@"qualifications":_zizhiView.currentUrl,@"inid":_currentId,@"workingyears":_congyeTimeView.subTextFild.text,@"age":_yearsAgeView.subTextFild.text};
        WS(weakSelf);
           [NetWorkTools postConJSONWithUrl:kAddengineerauth parameters:pamas success:^(id responseObject) {
               NSString *result = responseObject[@"result"];
               NSString *resultNote = responseObject[@"resultNote"];
               if ([result integerValue] == 0) {
                  LXRealCommitSucessAlertVc *vc = [[LXRealCommitSucessAlertVc alloc]init];
                   vc.callBackBlcok = ^{
                       [weakSelf.navigationController popViewControllerAnimated:YES];
                   };
                   [weakSelf preasntVc:vc];
               }
               [MBProgressHUD showError:resultNote];
              } fail:^(NSError *error) {
                  
        }];
    }
   
}

-(BOOL)pamasIsOkOrNot{
   
       if (!self.zhengmianView.currentUrl.length) {
          // [SSTool error:SSKJLanguage(@"请输入您的手机号")];
           [MBProgressHUD showError:@"请上传您的身份证正面"];
           return NO;
       }

        if (!self.fanMianView.currentUrl.length) {
                // [SSTool error:SSKJLanguage(@"请输入您的手机号")];
                 [MBProgressHUD showError:@"请上传您的身份证反面"];
                 return NO;
             }

       
       if (!self.currentId.length) {
           [MBProgressHUD showError:SSKJLanguage(@"请选择上传行业")];
           return NO;
       }
       if (!self.zizhiView.currentUrl.length) {
                      // [SSTool error:SSKJLanguage(@"请输入您的手机号")];
            [MBProgressHUD showError:@"请上传您的资质照片"];
            return NO;
        }
    if (!self.congyeTimeView.subTextFild.text.length) {
                           // [SSTool error:SSKJLanguage(@"请输入您的手机号")];
                 [MBProgressHUD showError:@"请输入您的从业时间"];
                 return NO;
             }
    if (!self.yearsAgeView.subTextFild.text.length) {
                  // [SSTool error:SSKJLanguage(@"请输入您的手机号")];
        [MBProgressHUD showError:@"请输入您的年纪"];
        return NO;
    }
      
    return YES;
}
-(void)preasntVc:(UIViewController *)vc
{
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
     [self.navigationController presentViewController:vc animated:YES completion:^{
         //
         vc.view.superview.backgroundColor = [UIColor clearColor];
     }];
}
#pragma mark - 用户头像修改
- (void)getUserPhoto{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self goCamera];
    }];
    [alert addAction:action1];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self goPhotoLibrary];
        
    }];
    [alert addAction:action2];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    
    [alert addAction:action];
    
    [self.navigationController presentViewController:alert animated:YES completion:nil];
    
}

- (void)goCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = YES;
        picker.delegate = self;
        picker.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [self.navigationController presentViewController:picker animated:YES completion:nil];
    }else{
        //没有权限
    }
}

- (void)goPhotoLibrary
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        picker.delegate = self;
        picker.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [self.navigationController presentViewController:picker animated:YES completion:nil];
    }else{
        //没有权限
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [[UIImage alloc] init];
    image = [info objectForKey:UIImagePickerControllerEditedImage];

    WS(weakSelf);
    weakSelf.currenUploadView.uploadImgeView.image = image;
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    [self uploadImage:image];
    
}
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
     [self hiddenNavigationView];
}

#pragma mark 上传图片
-(void)uploadImage:(UIImage*)image
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //!< 限制图片在1M以内
    image = [UIImage compressImageQuality:image toByte:(1*1024)];
    WS(weakSelf);
    [[HttpRequstApiManger shareManager]  upLoadImageByUrl:kImgBaseUrl ImageName:@"file" Params:@{} Image:image CallBack:^(id responseObject)
     {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

       NSString *result = responseObject[@"result"];
                 NSString *resultNote = responseObject[@"resultNote"];
                 NSString *urlString = responseObject[@"datastr"];
                 if ([result integerValue] == 0) {
                     //[self requstEdtingWithKey:@"icon" value:urlString];
                     weakSelf.currenUploadView.currentUrl = urlString;
                 }else{
                     [MBProgressHUD showError:resultNote];
                 }
     } Failure:^(NSError *error)
     {
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
     }];
}

- (void)updateUserHead{
    //[self userInforRequstAction];
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
        weakSelf.hangyeView.subNameLabel.text = nameArray[selectIndex];
        weakSelf.currentId = inidArray[selectIndex];
        } cancleBlock:^{
                   
    }];
}

@end
