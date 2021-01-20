//
//  LXAddAddressViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/28.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXAddAddressViewController.h"
#import "SingleLocationViewController.h"
#import "LXAddAddressItemView.h"
#import "GFAddressPicker.h"

#import "RegularExpression.h"
#import "LXAddressModel.h"

@interface LXAddAddressViewController ()<GFAddressPickerDelegate,UITextViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) LXAddAddressItemView *userNameView;
@property (nonatomic,strong) LXAddAddressItemView *phoneNumView;
@property (nonatomic,strong) LXAddAddressItemView *addressView;
@property (nonatomic,strong) LXAddAddressItemView *detailAddressView;


@property (nonatomic,strong) UIView *textViewBgView;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UILabel *placeHolderLabel;
@property (nonatomic,strong) UIButton *commitBtn;

@property (nonatomic, strong) GFAddressPicker *pickerView;
///省
@property (nonatomic,strong) NSString *province;
///市
@property (nonatomic,strong) NSString *city;
///区
@property (nonatomic,strong) NSString *area;
@end

@implementation LXAddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    if (self.model) {
         [self setValueWithModel:self.model];
    }
    self.title = @"添加新地址";
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar)];
        _scrollView.backgroundColor = kWhiteColor;
        [_scrollView addSubview:self.userNameView];
        [_scrollView addSubview:self.phoneNumView];
        [_scrollView addSubview:self.addressView];
        [_scrollView addSubview:self.detailAddressView];
        [_scrollView addSubview:self.textViewBgView];
        [_scrollView addSubview:self.commitBtn];

        if (ScreenHeight  < self.commitBtn.bottom + ScaleW(160)) {
            self.scrollView.contentSize = CGSizeMake(0, self.commitBtn.bottom + ScaleW(160));
        }else{
            self.scrollView.contentSize = CGSizeMake(0, ScreenHeight);
        }
        
        
        
    }
    return _scrollView;
}
-(LXAddAddressItemView *)userNameView
{
    if (!_userNameView) {
        _userNameView = [[LXAddAddressItemView alloc]initWithTitle:@"收货人" top:0 placeHolder:@"请输入收货人昵称" gotoImgString:@""];
    }
    return _userNameView;
}
-(LXAddAddressItemView *)phoneNumView{
    if (!_phoneNumView) {
        _phoneNumView = [[LXAddAddressItemView alloc]initWithTitle:@"手机号" top:_userNameView.bottom placeHolder:@"请输入联系人的电话" gotoImgString:@""];
    }
    return _phoneNumView;
}
-(LXAddAddressItemView *)addressView{
    if (!_addressView) {
        _addressView = [[LXAddAddressItemView alloc]initWithTitle:@"地址" top:_phoneNumView.bottom placeHolder:@"请选择省/市/区" gotoImgString:@"chakanquanbu"];
        
        WS(weakSelf);
        _addressView.gotoNextBlock = ^{
            [weakSelf.view addSubview:weakSelf.pickerView];
        };
    }
    return _addressView;
}
-(LXAddAddressItemView *)detailAddressView
{
    if (!_detailAddressView) {
        _detailAddressView = [[LXAddAddressItemView alloc]initWithTitle:@"详细地址：" top:_addressView.bottom placeHolder:@"街道、楼牌等" gotoImgString:@""];
        _detailAddressView.textFied.userInteractionEnabled = YES;
        _detailAddressView.bottomLine.hidden = YES;
    }
    return  _detailAddressView;
}
-(UIView *)textViewBgView{
    if (!_textViewBgView) {
        _textViewBgView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(10), ScaleW(10) + _detailAddressView.bottom, ScaleW(354), ScaleW(114))];
        _textViewBgView.backgroundColor = kSubBacColor;
        [_textViewBgView setCornerRadius:ScaleW(5)];
        [_textViewBgView addSubview:self.textView];
        [_textViewBgView addSubview:self.placeHolderLabel];
    }
    return _textViewBgView;
}
-(UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(ScaleW(10), ScaleW(10), _textViewBgView.width - ScaleW(20), ScaleW(84))];
        _textView.delegate = self;
        _textView.backgroundColor = [UIColor clearColor];
        _textView.font = kFont(ScaleW(12));
    }
    return _textView;
}
-(UILabel *)placeHolderLabel{
    if (!_placeHolderLabel) {
        _placeHolderLabel = [WLTools allocLabel:@"请输入您的详细收货地址" font:systemFont(ScaleW(12)) textColor:kGrayTxtColor frame:CGRectMake(_textView.left, _textView.top + ScaleW(5), _textView.width, ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _placeHolderLabel;
}
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

-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [WLTools allocButtonTitle:@"提交" font:systemBoldFont(ScaleW(14)) textColor:kWhiteColor image:nil frame:CGRectMake(ScaleW(10), ScaleW(100) + _textViewBgView.bottom, ScaleW(355), ScaleW(40)) sel:@selector(commitAction:) taget:self];
        _commitBtn.backgroundColor = UIColorFromRGB(0xFFC041);
        [_commitBtn setCornerRadius:_commitBtn.height/2.f];
    }
    return _commitBtn;
}

-(GFAddressPicker *)pickerView{
    if (!_pickerView) {
        _pickerView = [[GFAddressPicker alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - Height_NavBar)];
        [_pickerView updateAddressAtProvince:@"河南省" city:@"郑州市" town:@"金水区"];
        _province = @"河南省";
        _city = @"郑州市";
        _area = @"金水区";
        _pickerView.delegate = self;
        _pickerView.font = [UIFont boldSystemFontOfSize:ScaleW(18)];

    }
    return _pickerView;
}
#pragma mark  ---Action
-(void)setDefultBtnAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
}
-(void)commitAction:(UIButton *)sender{

    if ([self pamasIsOkOrNot]) {
        NSDictionary *pamas = @{};
//        if (_addressNums.length) {
//            pamas = @{@"addressid":_addressNums,@"name":_userNameView.textFied.text,@"phone":_phoneNumView.textFied.text,@"province":_province,@"city":_city,@"area":_area,@"addressdetail":_detailAddressView.textFied.text,@"isdefault":_setDefultBtn.selected?@"1":@"0"};
//        }else{
//            pamas = @{@"name":_userNameView.textFied.text,@"phone":_phoneNumView.textFied.text,@"province":_province,@"city":_city,@"area":_area,@"addressdetail":_detailAddressView.textFied.text,@"isdefault":_setDefultBtn.selected?@"1":@"0"};
//        }
//
        WS(weakSelf);
           [NetWorkTools postConJSONWithUrl:kEngineeraddAddressUrl parameters:pamas success:^(id responseObject) {
               
               NSString *result = responseObject[@"result"];
               NSString *resultNote = responseObject[@"resultNote"];
               if ([result integerValue] == 0) {
                   !weakSelf.callBackBlock?:self.callBackBlock();
                   [weakSelf.navigationController popViewControllerAnimated:YES];
               }
               [MBProgressHUD showError:resultNote];
              } fail:^(NSError *error) {
                  
        }];
    }
   
}

-(BOOL)pamasIsOkOrNot{
   
       if (!self.userNameView.textFied.text.length) {
          // [SSTool error:SSKJLanguage(@"请输入您的手机号")];
           [MBProgressHUD showError:@"请输入联系人姓名"];
           return NO;
       }

       if (!self.phoneNumView.textFied.text.length) {
           [MBProgressHUD showError:_phoneNumView.textFied.placeholder];
          return NO;
       }

       if (![RegularExpression validateMobile:self.phoneNumView.textFied.text]) {
            [MBProgressHUD showError:SSKJLanguage(@"手机号码格式不正确")];
            return NO;
        }
       if (!self.addressView.textFied.text.length) {
           [MBProgressHUD showError:_addressView.textFied.placeholder];
           return NO;
       }
       
       if (!self.detailAddressView.textFied.text.length) {
            [MBProgressHUD showError:_detailAddressView.textFied.placeholder];
            return NO;
        }
    
    return YES;
}
#pragma mark -delegateAction
- (void)GFAddressPickerCancleAction
{
       [self.pickerView removeFromSuperview];
}

- (void)GFAddressPickerWithProvince:(NSString *)province
                               city:(NSString *)city area:(NSString *)area
{
    [self.pickerView removeFromSuperview];
    _province = province;
    _city = city;
    _area = area;
    _addressView.textFied.text = [NSString stringWithFormat:@"%@  %@  %@",province,city,area];
    
}
-(void)setValueWithModel:(LXAddressModel *)model{
    self.userNameView.textFied.text = model.name;
    self.phoneNumView.textFied.text = model.phone;
   // [self.setDefultBtn setSelected:model.isdefault.integerValue];
    self.addressView.textFied.text = [NSString stringWithFormat:@"%@ %@ %@",model.province,model.city,model.area];
    //self.detailAddressView.textFied.text = model.addressdetail;
}
@end
