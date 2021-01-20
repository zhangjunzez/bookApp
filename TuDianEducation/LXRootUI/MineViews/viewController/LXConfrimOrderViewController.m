//
//  LXConfrimOrderViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/10/30.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXConfrimOrderViewController.h"
#import "LXTitleImgeArrayItemView.h"

@interface LXConfrimOrderViewController ()
@property (nonatomic,strong) LXTitleImgeArrayItemView *beforView;
@property (nonatomic,strong) LXTitleImgeArrayItemView *afterView;
@property (nonatomic,strong) UIButton *commitBtn;
@end

@implementation LXConfrimOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    self.view.backgroundColor = kMainBgColor;
    [self.view addSubview:self.beforView];
    [self.view addSubview:self.afterView];
    [self.view addSubview:self.commitBtn];
}

-(LXTitleImgeArrayItemView *)beforView{
    if (!_beforView) {
        _beforView = [[LXTitleImgeArrayItemView alloc]initWithTop:ScaleW(15) title:@"上传服务前照片" imgeArray:@[@""] redHidden:YES];
        _beforView.limitCount = 1;
        
    }
    return _beforView;
}
-(LXTitleImgeArrayItemView *)afterView{
    if (!_afterView) {
        _afterView = [[LXTitleImgeArrayItemView alloc]initWithTop:ScaleW(15) + _beforView.bottom title:@"上传服务后照片" imgeArray:@[@""] redHidden:YES];
        _afterView.limitCount = 1;
    }
    return _afterView;
}
-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [WLTools allocButtonTitle:@"上传" font:systemBoldFont(14) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(175), _afterView.bottom + ScaleW(33) - ScaleW(20), ScaleW(120), ScaleW(33)) sel:@selector(commitAction:) taget:self];
              _commitBtn.backgroundColor = kBlueColor;
              [_commitBtn setCornerRadius:_commitBtn.height/2.f];
        _commitBtn.centerX = ScreenWidth/2.f;
    }
    return _commitBtn;
}
-(void)commitAction:(UIButton *)sender{
    if (!_beforView.urlsString.length) {
        [MBProgressHUD showError:@"请上传服务前照片"];
        return;
    }
    if (!_afterView.urlsString.length) {
        [MBProgressHUD showError:@"请上传服务后照片"];
        return;
    }
    [self ensureOrderWithOrdernum];
}
-(void)ensureOrderWithOrdernum{

    NSDictionary *pamas = @{@"ordernum":_ordernum,@"image1":_beforView.urlsString,@"image2":_afterView.urlsString};
    [NetWorkTools postConJSONWithUrl:kEngineerorderdemandconfirm parameters:pamas success:^(id responseObject) {
           NSString *result = responseObject[@"result"];
           NSString *resultNote = responseObject[@"resultNote"];
          
           if (result.integerValue == 0) {
               [self.navigationController popViewControllerAnimated:YES];
           }else{
               
           }
             [MBProgressHUD showError:resultNote];
       } fail:^(NSError *error) {
           
       }];
}
@end
