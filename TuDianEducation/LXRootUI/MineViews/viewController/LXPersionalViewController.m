//
//  LXPersionalViewController.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/1.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXPersionalViewController.h"
#import "LXResetPswViewController.h"
#import "LXMailBackViewController.h"
#import "MineEdtingViewController.h"
#import "LXSelectPickerViewController.h"
#import "BkNickNameViewController.h"
#import "BkBindViewController.h"
#import "LXAddressListViewController.h"
#import "BkSignViewController.h"


#import "LXSettingCell.h"
#import "LXSettingImgTableViewCell.h"
//#import "TeacherShowModel.h"
#import "LXTuiJianHeaderView.h"
#import "ETF_Default_ActionsheetView.h"

#import "LXSaveUserInforTool.h"
#import "LXUserInforModel.h"



@interface LXPersionalViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *subArray;


@property (nonatomic,strong) NSArray *ageArray;

@property (nonatomic,strong) NSArray *workAgeArray;
///行业列表
@property (nonatomic,strong) NSArray *dataList;

@property (nonatomic) NSInteger pageNum;

@end

@implementation LXPersionalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人资料";
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view addSubview:self.tableView];
    [self requsetHangYeIdRequstAction];
    NSMutableArray *array = [NSMutableArray array];
          for (int i = 18; i < 71; i ++) {
              [array addObject:[NSString stringWithFormat:@"%d",i]];
          }
    self.ageArray = array;
    NSMutableArray *array1 = [NSMutableArray array];
    for (int i = 1; i < 51; i ++) {
        [array1 addObject:[NSString stringWithFormat:@"%d",i]];
    }
    self.workAgeArray = array1;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self userInforRequstAction];
}
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[@"头像",@"昵称",@"性别",@"年龄",@"手机号",@"微信",@"地区",@"收货地址",@"签名"].mutableCopy;
    }
    return _dataArray;
}
-(NSMutableArray *)subArray
{
    if (!_subArray) {
        _subArray = @[@"",@"**",@"*",@"**",@"*****",@"****",@"***",@"****",@"****"].mutableCopy;
    }
    return _dataArray;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight -  Height_NavBar) style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = kWhiteColor;
        if (@available(iOS 11.0, *))
        {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
      
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *nameString = self.dataArray[indexPath.row];
    NSString *substring = self.subArray[indexPath.row];
    if (indexPath.row == 0) {
        LXSettingImgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LXSettingImgTableViewCell"];
               if (!cell) {
                   cell = [[LXSettingImgTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"LXSettingImgTableViewCell"];
               }
        cell.nameLabel.text = nameString;
        [self setValueToImgCell:cell];
        return cell;
    }else{
        LXSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LXSettingCell"];
        if (!cell) {
            cell = [[LXSettingCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"LXSettingCell"];
        }
        cell.subNameLabel.hidden = NO;
        cell.gotoImg.hidden = NO;
        cell.swithUnknow.hidden = YES;
        cell.subNameLabel.textColor = kMainTxtColor;
        cell.nameLabel.text = nameString;
        cell.subNameLabel.text = substring;
        [self setValueToCell:cell];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LXSettingCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row == 0) {
        [self getUserPhoto];
        return;
    }
    if (indexPath.row != 0) {
        if ([cell.nameLabel.text isEqualToString:@"手机号"]) {
            BkBindViewController *vc = [[BkBindViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
              return;
           }
        //
        if ([cell.nameLabel.text isEqualToString:@"收货地址"]) {
            LXAddressListViewController *vc = [[LXAddressListViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
        if ([cell.nameLabel.text isEqualToString:@"性别"]) {
            [self showAlertSex];
            return;
        }
        if ([cell.nameLabel.text isEqualToString:@"年龄"]) {
            [self settingAgeAction:cell];
            return;
        }
        if ([cell.nameLabel.text isEqualToString:@"签名"]) {
            BkSignViewController *vc = [[BkSignViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
        if ([cell.nameLabel.text isEqualToString:@"昵称"]) {
            BkNickNameViewController *vc = [[BkNickNameViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
        MineEdtingViewController *vc = [[MineEdtingViewController alloc]init];
        vc.title = self.dataArray[indexPath.row];
        WS(weakSelf);
        vc.sucessEdtingBlock = ^(NSString * _Nonnull string)
        {
            [weakSelf edtingValueToCell:cell withString:string];
        };
        [self naviPushVc:vc];
    }
}

-(void)settingAgeAction:(LXSettingCell *)cell{
    LXSelectPickerViewController *vc = [[LXSelectPickerViewController alloc]init];
    vc.titleLabel.text = @"选择年纪";
    
    vc.dataArray = self.ageArray;
    WS(weakSelf);
    vc.selecedTypeBlock = ^(NSString * _Nonnull type) {
         [weakSelf edtingValueToCell:cell withString:type];
    };
    [self preasntVc:vc];
   
    
}
-(void)settingWorksAgeAction:(LXSettingCell *)cell{
    LXSelectPickerViewController *vc = [[LXSelectPickerViewController alloc]init];
       vc.titleLabel.text = @"选择从业时间";
   
    vc.dataArray = self.workAgeArray;
      
        WS(weakSelf);
       vc.selecedTypeBlock = ^(NSString * _Nonnull type) {
            [weakSelf edtingValueToCell:cell withString:type];
       };
     [self preasntVc:vc];
}

- (void)updatePageWithIndex:(NSInteger)index collect:(BOOL)bo{
    
    if (bo) {
    
    }else{
        [self.dataArray removeObjectAtIndex:index];
    }
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return ScaleW(66);
    }
    return ScaleW(50);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]initWithFrame:CGRectZero];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    view.backgroundColor = kMainBgColor;
    return view;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return CGFLOAT_MIN;
}

-(void)quitOutLoginAction:(UIButton *)sender
{
    [self loginOutAction];
}

#pragma mark -requstAction

-(void)userInforRequstAction{
    [NetWorkTools postConJSONWithUrl:kUserInforUrl parameters:@{} success:^(id responseObject) {
        NSString *result = responseObject[@"result"];
        NSString *resultNote = responseObject[@"resultNote"];
        NSDictionary *data = responseObject[@"dataobject"];
        if ([result integerValue] == 0) {
            LXUserInforModel *model = [[LXUserInforModel alloc]init];
            [model setValuesForKeysWithDictionary:data];
            [LXSaveUserInforTool sharedUserTool].userInforModel = model;
            [self.tableView reloadData];
        }else{
             [MBProgressHUD showError:resultNote];
        }

    } fail:^(NSError *error) {

    }];
   
}
-(void)setValueToImgCell:(LXSettingImgTableViewCell *)cell{
     LXUserInforModel *model = [LXSaveUserInforTool sharedUserTool].userInforModel;
    [cell.headerImgView sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:model.icon]] placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
}
-(void)setValueToCell:(LXSettingCell *)cell{
    
    LXUserInforModel *model = [LXSaveUserInforTool sharedUserTool].userInforModel;
    if ([cell.nameLabel.text isEqualToString:@"昵称"]) {
        cell.subNameLabel.text = model.nickname;
    }
    if ([cell.nameLabel.text isEqualToString:@"性别"]) {
        cell.subNameLabel.text = model.sex;
    }
    if ([cell.nameLabel.text isEqualToString:@"年龄"]) {
        cell.subNameLabel.text = model.age;
    }
    if ([cell.nameLabel.text isEqualToString:@"手机号"]) {
        cell.subNameLabel.text = model.phone;
        
    }
    if ([cell.nameLabel.text isEqualToString:@"微信"]) {
        cell.subNameLabel.text = model.realname;
    }
    if ([cell.nameLabel.text isEqualToString:@"地区"]) {
        cell.subNameLabel.text = model.companyname;
    }
    if ([cell.nameLabel.text isEqualToString:@"收货地址"]) {
        cell.subNameLabel.text = model.industrys;
    }
    if ([cell.nameLabel.text isEqualToString:@"签名"]) {
        cell.subNameLabel.text = model.workingyears;
    }
}

-(void)edtingValueToCell:(LXSettingCell *)cell withString:(NSString *)string
{
    NSString *key = @"";
    if ([cell.nameLabel.text isEqualToString:@"昵称"]) {
        key = @"nickname";
    }
    if ([cell.nameLabel.text isEqualToString:@"性别"]) {
        key = @"sex";
    }
    if ([cell.nameLabel.text isEqualToString:@"年龄"]) {
        key = @"age";
    }
    if ([cell.nameLabel.text isEqualToString:@"手机号"]) {
        key = @"phone";
    }
    if ([cell.nameLabel.text isEqualToString:@"微信"]) {
        key = @"realname";
    }
    if ([cell.nameLabel.text isEqualToString:@"地区"]) {
        key = @"companyname";
    }
    if ([cell.nameLabel.text isEqualToString:@"收货地址"]) {
        key = @"inid";
        ///key = @"industrys";
    }
    if ([cell.nameLabel.text isEqualToString:@"签名"]) {
        key = @"workingyears";
    }
    
    [self requstEdtingWithKey:key value:string];
}
-(void)requstEdtingWithKey:(NSString *)key value:(NSString *)string{
    NSMutableDictionary *pamas = [NSMutableDictionary dictionary];
    
    [pamas setValue:string forKey:key];
    
    [NetWorkTools postConJSONWithUrl:kEdtingUserUrl parameters:pamas success:^(id responseObject) {
        NSString *result = responseObject[@"result"];
        NSString *resultNote = responseObject[@"resultNote"];
        if ([result integerValue] == 0) {
            [self userInforRequstAction];
        }else{
            
        }
        [MBProgressHUD showError:resultNote];
        
    } fail:^(NSError *error) {
        
    }];
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
              [weakSelf requstEdtingWithKey:@"inid" value:inidArray[selectIndex]];
        } cancleBlock:^{
                   
    }];
}
-(void)showAlertSex{
   
    WS(weakSelf);
    NSArray *array = @[@"男",@"女"];
    [ETF_Default_ActionsheetView showWithItems:array title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
              [weakSelf requstEdtingWithKey:@"sex" value:array[selectIndex]];
        } cancleBlock:^{
                   
    }];
}
#pragma mark - 上传图片
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
    [picker dismissViewControllerAnimated:YES completion:^{
            //[weakSelf hiddenNavigationView];
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
                     [self requstEdtingWithKey:@"icon" value:urlString];
                     
                 }else{
                     [MBProgressHUD showError:resultNote];
                 }
     } Failure:^(NSError *error)
     {
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
     }];
}

- (void)updateUserHead{
    [self userInforRequstAction];
}
@end
