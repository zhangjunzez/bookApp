//
//  LXLearnningDetailViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/2.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXLearnningDetailViewController.h"
#import "LXEdtingLearnningViewController.h"
#import "LXMySkillModel.h"

@interface LXLearnningDetailViewController ()
@property (nonatomic,strong) UIImageView *imgView1;
@property (nonatomic,strong) UILabel *titleLabel1;
@property (nonatomic,strong) UIImageView *imgView2;
@property (nonatomic,strong) UILabel *titleLabel2;
@property (nonatomic,strong) UIImageView *imgView3;
@property (nonatomic,strong) UILabel *titleLabel3;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) NSInteger timeCount;
@end

@implementation LXLearnningDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _model.title;
    if (_edtingType == LearnningEdtingTypeEdting) {
        [self addRightNavItemWithTitle:@"编辑" color:kSubTxtColor font:systemFont(ScaleW(12))];
    }
    [self.view addSubview:self.scrollView];
    [self requstDetailDataRequst];
   [self timerStart];
   
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar)];
        _scrollView.backgroundColor = kWhiteColor;
        [self.scrollView addSubview:self.titleLabel1];
        [self.scrollView addSubview:self.imgView1];
        [self.scrollView addSubview:self.titleLabel2];
        [self.scrollView addSubview:self.imgView2];
        [self.scrollView addSubview:self.titleLabel3];
        [self.scrollView addSubview:self.imgView3];
        self.scrollView.hidden = YES;
    }
    return _scrollView;
}

-(void)rigthBtnAction:(id)sender{
    LXEdtingLearnningViewController *vc = [[LXEdtingLearnningViewController alloc]init];
    vc.model = _model;
    [self.navigationController pushViewController:vc animated:YES];
}
-(UIImageView *)imgView1{
    if (!_imgView1) {
        _imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScreenWidth -ScaleW(30), ScaleW(100))];
    }
    return  _imgView1;
}
-(UILabel *)titleLabel1{
    if (!_titleLabel1) {
        _titleLabel1 = [WLTools allocLabel:@"" font:systemFont(ScaleW(15)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), ScaleW(20), ScreenWidth - ScaleW(30), ScaleW(100)) textAlignment:(NSTextAlignmentLeft)];
       
    }
    return _titleLabel1;
}
-(UIImageView *)imgView2{
    if (!_imgView2) {
        _imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScreenWidth -ScaleW(30), ScaleW(100))];
    }
    return  _imgView2;
}
-(UILabel *)titleLabel2{
    if (!_titleLabel2) {
        _titleLabel2 = [WLTools allocLabel:@"" font:systemFont(ScaleW(15)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), ScaleW(20), ScreenWidth - ScaleW(30), ScaleW(100)) textAlignment:(NSTextAlignmentLeft)];
        
       
    }
    return _titleLabel2;
}
-(UIImageView *)imgView3{
    if (!_imgView3) {
        _imgView3 = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScreenWidth -ScaleW(30), ScaleW(100))];
    }
    return  _imgView3;
}
-(UILabel *)titleLabel3{
    if (!_titleLabel3) {
        _titleLabel3 = [WLTools allocLabel:@"" font:systemFont(ScaleW(15)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(15), ScaleW(20), ScreenWidth - ScaleW(30), ScaleW(100)) textAlignment:(NSTextAlignmentLeft)];
        
    }
    return _titleLabel3;
}

-(void)requstDetailDataRequst{
    //kMyservicestodetailUrl
    NSDictionary *pamas = @{@"skillsid":_model.skillsid};
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
          [NetWorkTools postConJSONWithUrl:kGetSkillsDetailUrl parameters:pamas success:^(id responseObject) {
              NSString *result = responseObject[@"result"];
              NSString *resultNote = responseObject[@"resultNote"];
              NSDictionary *data = responseObject[@"dataobject"];
             
              if (result.integerValue == 0) {
                  LXMySkillModel *model = [[LXMySkillModel alloc]init];
                  [model setValuesForKeysWithDictionary:data];
                  self.model = model;
                  [self setValues];
              }else{
                   [MBProgressHUD showError:resultNote];
                   [MBProgressHUD hideHUDForView:self.view animated:YES];
              }
               
          } fail:^(NSError *error) {
             [MBProgressHUD hideHUDForView:self.view animated:YES];
          }];
}
-(void)setValues{
    _titleLabel1.text = _model.content1;
    _titleLabel1.height = [self.view returnHeight:_model.content1 font:ScaleW(15) width:_titleLabel1.width];
    _titleLabel2.text = _model.content2;
    _titleLabel2.height = [self.view returnHeight:_model.content2 font:ScaleW(15) width:_titleLabel2.width];
    _titleLabel3.text = _model.content3;
    _titleLabel3.height = [self.view returnHeight:_model.content3 font:ScaleW(15) width:_titleLabel3.width];
    [self loadImgDown];
}
#pragma mark - 单个页面多个网络请求的情况(依次调用接口)，等待所有网络请求结束后，再刷新UI
- (void)loadImgDown{
    WS(weakSelf);
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t searialQueue = dispatch_queue_create("com.hmc.www", DISPATCH_QUEUE_SERIAL);
    
    dispatch_group_enter(group);
    dispatch_group_async(group, searialQueue, ^{
        // 网络请求一
        [weakSelf.imgView1 sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:weakSelf.model.images1]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
           
            if (image == nil) {
                weakSelf.imgView1.hidden = YES;
                weakSelf.imgView1.height = CGFLOAT_MIN;
            }else{
                weakSelf.imgView1.hidden = NO;
                weakSelf.imgView1.image = image;
                weakSelf.imgView1.height = (image.size.height/image.size.width)*weakSelf.imgView1.width;
            }
            dispatch_group_leave(group);
        }];
    });
    
    dispatch_group_enter(group);
    dispatch_group_async(group, searialQueue, ^{
        // 网络请求二
        [self.imgView2 sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:weakSelf.model.images2]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
               if (image == nil) {
                   weakSelf.imgView2.hidden = YES;
                   weakSelf.imgView2.height = CGFLOAT_MIN;

               }else{
                   weakSelf.imgView2.hidden = NO;
                   weakSelf.imgView2.image = image;
                   weakSelf.imgView2.height = (image.size.height/image.size.width)*weakSelf.imgView2.width;
               }
              
               dispatch_group_leave(group);
           }];
    });
    
    dispatch_group_enter(group);
    dispatch_group_async(group, searialQueue, ^{
        // 网络请求三
        [self.imgView3 sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:weakSelf.model.images3]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (image == nil) {
                weakSelf.imgView3.hidden = YES;
                weakSelf.imgView3.height = CGFLOAT_MIN;
            }else{
                weakSelf.imgView3.hidden = NO;
               weakSelf.imgView3.image = image;
                weakSelf.imgView3.height = (image.size.height/image.size.width)*weakSelf.imgView3.width;
            }
            
            dispatch_group_leave(group);
        }];
    });
    
    //三个网络请求结束后，会进入这个方法，在这个方法中进行洁面的刷行
    dispatch_group_notify(group, searialQueue, ^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                // 刷新UI
                [weakSelf reloadFrame];
            });
        });
    });
}
-(void)reloadFrame
{
    self.scrollView.hidden = NO;
    self.titleLabel1.top = self.imgView1.bottom + ScaleW(10);
    self.imgView2.top = self.titleLabel1.bottom + ScaleW(10);
    self.titleLabel2.top = self.imgView2.bottom + ScaleW(10);
    self.imgView3.top = self.titleLabel2.bottom + ScaleW(10);
    self.titleLabel3.top = self.imgView3.bottom + ScaleW(10);
    if (ScreenHeight  < self.imgView3.bottom + ScaleW(160)) {
        self.scrollView.contentSize = CGSizeMake(0, self.imgView3.bottom + ScaleW(160));
    }else{
        self.scrollView.contentSize = CGSizeMake(0, ScreenHeight);
    }
     [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)timerAction:(NSTimer *)sender{
    self.timeCount ++;
}

- (void)timerStart{
    [self timerStop];
    self.timeCount = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [self.timer fire];
  //  [self.verCodeView.getCodeBtn setTitle:@"" forState:UIControlStateNormal];

}

- (void)timerStop{
    if (!self.timer) {
        return;
    }
    [self.timer invalidate];
    self.timer = nil;
    //self.countLabel.text = @"";
    
   

}
-(void)dealloc{
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self uploadStudyTimeRequst];
    [self timerStop];
    
    
}
-(void)uploadStudyTimeRequst
{
    NSDictionary * pamas = @{@"skillsid":_model.skillsid,@"studytime":[NSString stringWithFormat:@"%ld",(long)self.timeCount]};
    [NetWorkTools postConJSONWithUrl:kAddskillsstudyUrl parameters:pamas success:^(id responseObject) {
        NSString *result = responseObject[@"result"];
        NSString *resultNote = responseObject[@"resultNote"];
        if (result.integerValue == 0) {
        
        }else{
             [MBProgressHUD showError:resultNote];
        }
         
    } fail:^(NSError *error) {
        
    }];

}
@end
