//
//  ModifyPwdViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/11.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "ModifyPwdViewController.h"
#import "BkInputItemView.h"
@interface ModifyPwdViewController ()
@property (nonatomic,strong) BkInputItemView *oldPswView;
@property (nonatomic,strong) BkInputItemView *nePswView;
@property (nonatomic,strong) UIButton *commitBtn;
@end

@implementation ModifyPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改登录密码";
    [self.view addSubview:self.oldPswView];
    [self.view addSubview:self.nePswView];
    [self.view addSubview:self.commitBtn];
}

-(BkInputItemView *)oldPswView{
    if (!_oldPswView) {
        _oldPswView = [[BkInputItemView alloc]initWithTop:ScaleW(20) Title:@"旧密码" placeHolder:@"请输入旧密码"];
    }
    return _oldPswView;
}
-(BkInputItemView *)nePswView{
    if (!_nePswView) {
        _nePswView = [[BkInputItemView alloc]initWithTop:ScaleW(10) + _oldPswView.bottom Title:@"新密码" placeHolder:@"请设置新密码"];
    }
    return _nePswView;
}

-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [WLTools allocButtonTitle:@"确定" font:systemFont(ScaleW(15)) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(30), _nePswView.bottom + ScaleW(50), ScaleW(316), ScaleW(40)) sel:@selector(commitBtnAction:) taget:self];
        _commitBtn.backgroundColor = kGreenColor;
        [_commitBtn setCornerRadius:_commitBtn.height/2.f];
    }
    return _commitBtn;
}
-(void)commitBtnAction:(UIButton *)sender
{
    
}

@end
