//
//  LXPublishAlertViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/1.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//


#import "LXPublishAlertViewController.h"
#import "LXServePublishViewController.h"
#import "LXPublishSkillViewController.h"

#import "LXPublishItemView.h"
@interface LXPublishAlertViewController ()
@property (nonatomic,strong) LXPublishItemView *publishServerView;
@property (nonatomic,strong) LXPublishItemView *skillShareView;
@property (nonatomic,strong) UIButton *cancellBtn;
@end

@implementation LXPublishAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.view.backgroundColor = kPublishAlertBacColor;
   
    [self.view addSubview:self.publishServerView];
    [self.view addSubview:self.skillShareView];
    [self.view addSubview:self.cancellBtn];
    
}

//RoundedRectangle

-(LXPublishItemView *)publishServerView{
    if (!_publishServerView) {
        _publishServerView = [[LXPublishItemView alloc] initWithImge:[UIImage imageNamed:@"fabu_xinzengfuwu"] message:@"新增服务"];
        _publishServerView.left = ScaleW(55);
        _publishServerView.bottom = ScreenHeight - ScaleW(79);
        WS(weakSelf);
        _publishServerView.itemClickBlock = ^(NSInteger index) {
            LXServePublishViewController *vc = [[LXServePublishViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _publishServerView;
}

-(LXPublishItemView *)skillShareView{
    if (!_skillShareView) {
        _skillShareView = [[LXPublishItemView alloc] initWithImge:[UIImage imageNamed:@"fabu_jinjie"] message:@"技能分享"];
        _skillShareView.left = _publishServerView.right + ScaleW(65);
        _skillShareView.bottom = _publishServerView.bottom;
        WS(weakSelf);
        _skillShareView.itemClickBlock = ^(NSInteger index) {
            LXPublishSkillViewController *vc = [[LXPublishSkillViewController alloc]init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _skillShareView;
}
-(UIButton *)cancellBtn{
    if (!_cancellBtn) {
        _cancellBtn = [WLTools allocButtonTitle:@"" font:systemFont(0) textColor:kWhiteColor image:[UIImage imageNamed:@"fabu_guanbi"] frame:CGRectMake(ScaleW(160), ScreenHeight - ScaleW(70), ScaleW(56), ScaleW(56)) sel:@selector(cancellBtnAction:) taget:self];
        _cancellBtn.backgroundColor = kWhiteColor;
        _cancellBtn.layer.cornerRadius = _cancellBtn.height/2.f;
        [_cancellBtn setShadowColor:kMainTxtColor];
    }
    return _cancellBtn;
}
-(void)cancellBtnAction:(UIButton *)sender
{
    [self dismissAction];
}
-(void)dismissAction{
    WS(weakSelf);
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
