//
//  LXSelectPickerViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/8/19.
//  Copyright © 2020 zhangbenchao. All rights reserved.

#import "LXSelectPickerViewController.h"

@interface LXSelectPickerViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong) UIView *mainView;

@property (nonatomic,strong) UIButton *closeBtn;
@property (strong, nonatomic) UIPickerView *pickView;
@property (nonatomic,strong) UIButton *commitBtn;

@property (nonatomic,strong) NSString *type;




@end

@implementation LXSelectPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self viewConfig];
}
-(void)viewConfig{
    self.view.backgroundColor = kBacColor;
    [self.view addSubview:self.mainView];
    [self.mainView addSubview:self.titleLabel];
    [self.mainView addSubview:self.closeBtn];
    [self.mainView addSubview:self.pickView];
    [self.mainView addSubview:self.commitBtn];
    
}
-(UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - ScaleW(322), ScreenWidth, ScaleW(342))];
        _mainView.cornerRadius = ScaleW(20);
        _mainView.backgroundColor = kWhiteColor;
    }
    return _mainView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:@"货物装载方式" font:systemBoldFont(ScaleW(17)) textColor:kMainTxtColor frame:CGRectMake(0, ScaleW(27), self.mainView.width, ScaleW(17)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _titleLabel;
}
-(UIButton *)closeBtn
{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame = CGRectMake(ScaleW(20), ScaleW(15) +Height_StatusBar, ScaleW(20), ScaleW(20));
        [_closeBtn btn:_closeBtn font:ScaleW(0) textColor:kWhiteColor text:@"" image:[UIImage imageNamed:@"denglu_guanbi"] sel:@selector(closeBtnAction:) taget:self];
        _closeBtn.right = self.mainView.width - ScaleW(25);
        _closeBtn.centerY = _titleLabel.centerY;
    }
    return _closeBtn;
}
-(UIPickerView *)pickView{
    if (!_pickView) {
        _pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, _titleLabel.bottom + ScaleW(20), self.mainView.width, ScaleW(160))];
        _pickView.delegate = self;
        _pickView.dataSource = self;
        _pickView.backgroundColor = kWhiteColor;
        [self updateTime];
    }
    return _pickView;
}
-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [WLTools allocButtonTitle:@"确定" font:systemBoldFont(17) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(37), ScaleW(45), ScaleW(300), ScaleW(50)) sel:@selector(commitAction:) taget:self];
        _commitBtn.bottom = _mainView.height - ScaleW(45);
        _commitBtn.backgroundColor = kBlueColor;
         _commitBtn.layer.cornerRadius = _commitBtn.height/2.f;
        [_commitBtn setShadowColor:kBlueColor];
    }
    return _commitBtn;
}
-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
//    [_pickView reloadAllComponents];
//    [self updateTime];
}

-(void)commitAction:(UIButton *)sender{
    !self.selecedTypeBlock?:self.selecedTypeBlock(_type);
    [self dissMissAction];
}
-(void)closeBtnAction:(UIButton *)sender
{
    [self dissMissAction];
}
#pragma mark ---pickerViewDelegate

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return self.mainView.width;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return ScaleW(50);
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [self updateTime];
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:ScaleW(16)]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
        return [self.dataArray objectAtIndex:row];
   
}
- (void)updateTime {
    self.type = [self.dataArray objectAtIndex:[self.pickView selectedRowInComponent:0]];
   
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
