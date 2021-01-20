//
//  BkFaceOptionViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/12.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//


#import "BkFaceOptionViewController.h"

@interface BkFaceOptionViewController ()
@property (nonatomic, strong) UIView *bacView;
@property (nonatomic,strong) UILabel *messageLabel;

@property (nonatomic, strong) UIButton *commitBtn;
@property (nonatomic,strong) UIButton *cancellBtn;



@end

@implementation BkFaceOptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.view.backgroundColor = kBacColor;
   
    [self.view addSubview:self.bacView];
    UIButton *selectBtn = [WLTools allocButtonTitle:@"" font:systemFont(ScaleW(12)) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(27), ScaleW(48), ScaleW(252), ScaleW(30)) sel:@selector(selectedAction:) taget:self];
    selectBtn.cornerRadius = ScaleW(3);
    selectBtn.backgroundColor = kSubBacColor;
    [self.bacView addSubview:selectBtn];
    [selectBtn addSubview:self.messageLabel];
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"下拉"]];
    [selectBtn addSubview:img];
    img.right = selectBtn.width - ScaleW(20);
    img.centerY = selectBtn.height/2.f;
    [self.bacView addSubview:self.cancellBtn];
    [self.bacView addSubview:self.commitBtn];
    
    
}
-(void)selectedAction:(UIButton *)sender
{
    
}
-(UIView *)bacView{
    if (!_bacView) {
        _bacView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(34), 0, ScaleW(307), ScaleW(170))];
        _bacView.centerY = ScreenHeight/3.f;
        [_bacView setCornerRadius:ScaleW(10)];
        _bacView.backgroundColor = kWhiteColor;
    }
    return _bacView;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //self.navigationController.navigationBarHidden = YES;
}

-(UILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel = [WLTools allocLabel:@"删除" font:systemFont(ScaleW(16)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(29), ScaleW(0), ScaleW(150), ScaleW(30)) textAlignment:(NSTextAlignmentLeft)];
        
    }
    return _messageLabel;
}


-(UIButton *)commitBtn{
    if (!_commitBtn) {
       _commitBtn = [WLTools allocButtonTitle:@"确认" font:systemBoldFont(14) textColor:kGreenColor image:nil frame:CGRectMake(_bacView.width/2.f, 0, ScaleW(120), ScaleW(50)) sel:@selector(commitAction:) taget:self];
        _commitBtn.bottom = _bacView.height;
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _cancellBtn.width, 0.5)];
        line.backgroundColor = kMainLineColor;
        [_commitBtn addSubview:line];
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _cancellBtn.width, 0.5)];
        line2.backgroundColor = kMainLineColor;
        [_commitBtn addSubview:line2];
    }
    return _commitBtn;
}
-(UIButton *)cancellBtn{
    if (!_cancellBtn) {
        _cancellBtn = [WLTools allocButtonTitle:@"取消" font:systemBoldFont(14) textColor:kMainTxtColor image:nil frame:CGRectMake(0, 0, ScaleW(120), ScaleW(50)) sel:@selector(commitAction:) taget:self];
        _cancellBtn.bottom = _bacView.height;
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, .5f, _cancellBtn.height)];
        line.backgroundColor = kMainLineColor;
        [_cancellBtn addSubview:line];
        
    }
    return _cancellBtn;
}

-(void)commitAction:(UIButton *)sender
{
    !self.callBackBlcok?:self.callBackBlcok();
   [self dismissAction];
    
}

-(void)dismissAction{
    [self dismissViewControllerAnimated:YES completion:nil];
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
