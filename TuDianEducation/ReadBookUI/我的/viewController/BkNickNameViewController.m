//
//  BkNickNameViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/11.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//


#import "BkNickNameViewController.h"
#import "BkInputItemView.h"
@interface BkNickNameViewController ()
@property (nonatomic,strong) BkInputItemView *nickNameView;

@property (nonatomic,strong) UIButton *commitBtn;
@end

@implementation BkNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"昵称";
    [self.view addSubview:self.nickNameView];
   
    [self.view addSubview:self.commitBtn];
}

-(BkInputItemView *)nickNameView{
    if (!_nickNameView) {
        _nickNameView = [[BkInputItemView alloc]initWithTop:ScaleW(20) Title:@"昵称" placeHolder:@"请输入昵称"];
    }
    return _nickNameView;
}

-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [WLTools allocButtonTitle:@"确定" font:systemFont(ScaleW(15)) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(30), _nickNameView.bottom + ScaleW(50), ScaleW(316), ScaleW(40)) sel:@selector(commitBtnAction:) taget:self];
        _commitBtn.backgroundColor = kGreenColor;
        [_commitBtn setCornerRadius:_commitBtn.height/2.f];
    }
    return _commitBtn;
}
-(void)commitBtnAction:(UIButton *)sender
{
    
}

@end
