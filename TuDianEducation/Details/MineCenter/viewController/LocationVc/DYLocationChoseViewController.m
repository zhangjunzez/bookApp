//
//  DYLocationChoseViewController.m
//  XILAIBANG
//
//  Created by ff on 2019/11/30.
//  Copyright © 2019 大點哥. All rights reserved.
//

#import "DYLocationChoseViewController.h"
#import "DYAuthHelper.h"
#import "DYHandleView.h"
#import "DYMapSearchListView.h"
#import <CoreLocation/CoreLocation.h>

#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface DYLocationChoseViewController ()<
CLLocationManagerDelegate,
DYMapSearchListViewDelegate,
AMapLocationManagerDelegate,MAMapViewDelegate,AMapSearchDelegate,
UITextFieldDelegate,UIScrollViewDelegate>
{
    UIButton *doneBtn;
    UIButton *cancelBtn;
    
    BOOL isfirst;
    BOOL isDragSearch;
}

@property (nonatomic, strong)UIScrollView *mapBackView;
@property (nonatomic, strong)MAMapView *mapView;
@property (nonatomic, strong)UIImageView *centerImgv;
@property (nonatomic, strong)AMapSearchAPI *search;
@property (nonatomic, assign)BOOL isEditStatus;

@property (nonatomic, strong)DYHandleView *handleView;
@property (nonatomic, strong)UIButton *locaResetBtn;
@property (nonatomic, strong)UITextField *tf;

@property (nonatomic, strong)DYMapSearchListView *mapSearchListView;

@property (nonatomic, strong)NSDictionary *choseDic;

@end

@implementation DYLocationChoseViewController



#pragma mark - 地图部分
- (void)creatMap {
    isfirst = NO;
    CGFloat h = SCREEN_HEIGHT/3;
    _mapBackView = [UIScrollView new];
    [self.view addSubview:_mapBackView];
    [_mapBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-h);
    }];
    
    _mapBackView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    _mapBackView.scrollEnabled = NO;
    _mapBackView.showsVerticalScrollIndicator =
    _mapBackView.showsHorizontalScrollIndicator = NO;
    [_mapBackView setContentOffset:(CGPointMake(0, SCREEN_HEIGHT/3)) animated:NO];
    [AMapServices sharedServices].apiKey = @"53195f9a32a87375a3e60c5e2cc137a6";
    [AMapServices sharedServices].enableHTTPS = YES;
    self.mapView = [MAMapView new];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [_mapView addGestureRecognizer:tap];
    [_mapBackView addSubview:_mapView];
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_mapBackView).offset(SCREEN_HEIGHT/3);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_HEIGHT/3*2);
        make.centerX.equalTo(self->_mapBackView);
        make.bottom.equalTo(self->_mapBackView);
    }];
    _mapView.mapLanguage = [[[DY_LanguageManager shareManager]currentLanguage]isEqualToString:@"English"]==YES?@1:@0;
    _mapView.mapType = [DYColorHelper isDarkSystemMode]==YES?MAMapTypeStandardNight:MAMapTypeStandard;
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    _mapView.rotateCameraEnabled = NO;
    _mapView.zoomLevel = 16;
    _mapView.showsCompass = NO;
    _mapView.showsScale = NO;
    _mapView.delegate = self;
    
    _centerImgv = [UIImageView new];
    _centerImgv.image = BUNDLE_PNGIMG(@"Chat", @"pin");
    _centerImgv.userInteractionEnabled = NO;
    [_mapView addSubview:_centerImgv];
    [_centerImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(44);
        make.centerX.equalTo(self->_mapView);
        make.centerY.equalTo(self->_mapView).offset(-10);
    }];
    
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    _search.language = [[[DY_LanguageManager shareManager] currentLanguage]isEqualToString:@"English"]==YES?AMapSearchLanguageEn:AMapSearchLanguageZhCN;
}

- (void)tap {
    ENDEDIT;
}

- (void)searchReq:(BOOL)isreset {
    _mapView.userInteractionEnabled = NO;
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    if (isreset == YES) {
        request.location = [AMapGeoPoint locationWithLatitude:_mapView.userLocation.location.coordinate.latitude longitude:_mapView.userLocation.location.coordinate.longitude];
    }else {
        request.location = [AMapGeoPoint locationWithLatitude:_mapView.centerCoordinate.latitude longitude:_mapView.centerCoordinate.longitude];
    }
    request.requireExtension = YES;
    request.radius = 50000;
    request.types = @"风景名胜|商务住宅|政府机构及社会团体|交通设施服务|公司企业|道路附属设施|地名地址信息";
    request.offset = 20;
    [_search AMapPOIAroundSearch:request];
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    [DYProgressHUD showMsg:error.description];
    _mapView.userInteractionEnabled = YES;
}

- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
    [DYProgressHUD showMsg:error.description];
    _mapView.userInteractionEnabled = YES;
}

- (void)mapViewDidFailLoadingMap:(MAMapView *)mapView withError:(NSError *)error {
    [DYProgressHUD showMsg:error.description];
    _mapView.userInteractionEnabled = YES;
}

- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction {
    if (wasUserAction == YES) {
        isDragSearch = YES;
//        if (_mapView.annotations.count != 0) {
//            [_mapView removeAnnotations:_mapView.annotations];
//        }
    }
    
}

- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction {
    if (isfirst == NO) {
        isfirst = YES;
        [self searchReq:NO];
    }
    if (wasUserAction == YES && _isEditStatus == 0) {
        [self searchReq:NO];
    }
}

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {
//    DYLog(@"%-----ld",response.pois.count);
    _mapView.userInteractionEnabled = YES;
    if (response.count == 0) {
        [DYProgressHUD showMsg:DYLocalizedString(@"m搜索无结果")];
        return;
    }
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < response.pois.count; i++) {
        AMapPOI *poi = response.pois[i];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:poi.name forKey:@"name"];
        [dic setValue:poi.address forKey:@"detail"];
        [dic setValue:@"PositionMsg" forKey:@"type"];
        [dic setValue:@"[自定义消息]" forKey:@"content_text"];
        [dic setValue:[NSString stringWithFormat:@"%f",poi.location.latitude] forKey:@"lat"];
        [dic setValue:[NSString stringWithFormat:@"%f",poi.location.longitude] forKey:@"longs"];
        [dic setValue:@{@"1":@"1"} forKey:@"extras"];
        [arr addObject:dic];
//        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
//        pointAnnotation.coordinate = CLLocationCoordinate2DMake(poi.location.latitude, poi.location.longitude);
//        pointAnnotation.title = poi.name;
//        pointAnnotation.subtitle = poi.address;
//        [self.mapView addAnnotation:pointAnnotation];
    }
    if (isDragSearch == YES) {
        [_mapSearchListView data:arr];
    }else {
        [_mapSearchListView dataFromText:arr];
    }
    
    
}

//- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
//    if ([annotation isKindOfClass:[MAPointAnnotation class]])
//        {
//            static NSString *reuseIndetifier = @"annotationReuseIndetifier";
//            MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:[NSString stringWithFormat:@"%f-%f",annotation.coordinate.latitude,annotation.coordinate.longitude]];
//            if (annotationView == nil)
//            {
//                annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
//    reuseIdentifier:reuseIndetifier];
//            }
//            annotationView.canShowCallout = YES;
//            annotationView.image = BUNDLE_PNGIMG(@"Chat", @"pin_red");
//            //设置中心点偏移，使得标注底部中间点成为经纬度对应点
//            annotationView.centerOffset = CGPointMake(0, -18);
//            return annotationView;
//        }
//        return nil;
//}

//- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
//
//}


- (void)dealloc {
    _search.delegate = nil;
    _mapView.delegate = nil;
}


#pragma mark - 列表部分
- (void)creatList {
    CGFloat h = SCREEN_HEIGHT/3;
    _mapSearchListView = [[DYMapSearchListView alloc]initWithFrame:(CGRectZero) style:(UITableViewStyleGrouped)];
    _mapSearchListView.listViewDelegate = self;
    [self.view addSubview:_mapSearchListView];
    [_mapSearchListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(h);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-SafeAreaBottomHeight);
    }];
}

// list代理 list偏移
- (void)offset:(CGFloat)offsetY {
    
    CGFloat h = SCREEN_HEIGHT/3;
    if (offsetY <= h) {
        [_handleView setContentOffset:(CGPointMake(0, offsetY)) animated:NO];
        [_mapBackView setContentOffset:(CGPointMake(0, h+offsetY/2)) animated:NO];
    }else {
        if (_handleView.contentOffset.y != h) {
            [_handleView setContentOffset:(CGPointMake(0, h)) animated:NO];
        }
        if (_mapBackView.contentOffset.y != h+offsetY/2) {
            [_mapBackView setContentOffset:(CGPointMake(0, h+h/2)) animated:NO];
        }
    }
}

// list代理 点击选择地点
- (void)selectAddress:(NSMutableDictionary *)dic isSelectList:(BOOL)isSelectList{
//    [_mapSearchListView setContentOffset:(CGPointMake(0, 0)) animated:YES];
    if (isSelectList == YES) {
        _choseDic = dic;
        [_mapView setCenterCoordinate:(CLLocationCoordinate2DMake([[dic valueForKey:@"lat"] floatValue], [[dic valueForKey:@"longs"] floatValue])) animated:YES];
    }else {
        [dic setValue:[NSString stringWithFormat:@"%f",_mapView.centerCoordinate.latitude] forKey:@"lat"];
        [dic setValue:[NSString stringWithFormat:@"%f",_mapView.centerCoordinate.longitude] forKey:@"longs"];
        _choseDic = dic;
    }
    
}

// list代理 还原按钮
- (void)resetLoca {
    [_mapView setCenterCoordinate:_mapView.userLocation.location.coordinate animated:YES];
    if (_isEditStatus == NO) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self searchReq:YES];
        });
    }
}

// list代理 编辑状态
- (void)isEditStatus:(BOOL)isEditStatus {
    self.isEditStatus = isEditStatus;
    _centerImgv.hidden = isEditStatus;
}

#pragma mark - 搜索框部分
- (void)creatSearch {
    CGFloat h = SCREEN_HEIGHT/3;
    _handleView = [DYHandleView new];
    [self.view addSubview:_handleView];
    [_handleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(_mapBackView).offset(h-103);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(h+103);
    }];
    _tf = [UITextField new];
    _tf.delegate = self;
    _tf.returnKeyType = UIReturnKeySearch;
    _tf.layer.cornerRadius = 4;
    _tf.placeholder = DYLocalizedString(@"m搜索地点");
    _tf.layer.masksToBounds = YES;
    [_tf addTarget:self action:@selector(textChange:) forControlEvents:(UIControlEventEditingChanged)];
    _tf.backgroundColor = [DYColorHelper sysGrayColor:3 lightColor:WHITE_COLOR];
    [_handleView addSubview:_tf];
    [_tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_handleView).offset(7+h+54);
        make.left.equalTo(self->_handleView).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH-40);
        make.height.mas_equalTo(35);
        make.bottom.equalTo(self->_handleView).offset(-7-h);
    }];
    _locaResetBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_locaResetBtn setImage:BUNDLE_PNGIMG(@"Chat", @"loca") forState:(UIControlStateNormal)];
    [_locaResetBtn addTarget:self action:@selector(resetLoca) forControlEvents:(UIControlEventTouchUpInside)];
    [_handleView addSubview:_locaResetBtn];
    [_locaResetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(44);
        make.right.equalTo(self->_tf.mas_right).offset(10);
        make.bottom.equalTo(self->_tf.mas_top).offset(-10);
    }];
}

- (void)textSearch:(NSString *)text {
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    request.keywords = text;
    request.location = [AMapGeoPoint locationWithLatitude:_mapView.userLocation.location.coordinate.latitude longitude:_mapView.userLocation.location.coordinate.longitude];
    request.requireExtension = YES;
    [self.search AMapPOIKeywordsSearch:request];
}

- (void)textChange:(UITextField *)tf {
    [self isEditStatus:YES];
    if (tf.text.length == 0) {
        
    }else {
        [self textSearch:tf.text];
    }
}

//- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {
//    if (_dataArr.count != 0) {
//        [self.dataArr removeAllObjects];
//    }
//    if (response.pois.count == 0) {
//        [self reloadData];
//        return;
//    }
//    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
//        for (int i = 0; i < response.pois.count; i++) {
//            AMapPOI *poi = response.pois[i];
//            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//            [dic setValue:poi.name forKey:@"name"];
//            [dic setValue:poi.address forKey:@"detail"];
//            [dic setValue:@"PositionMsg" forKey:@"type"];
//            [dic setValue:@"[自定义消息]" forKey:@"content_text"];
//            [dic setValue:[NSString stringWithFormat:@"%f",poi.location.latitude] forKey:@"lat"];
//            [dic setValue:[NSString stringWithFormat:@"%f",poi.location.longitude] forKey:@"longs"];
//            [dic setValue:@{@"1":@"1"} forKey:@"extras"];
//            [arr addObject:dic];
//    //        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
//    //        pointAnnotation.coordinate = CLLocationCoordinate2DMake(poi.location.latitude, poi.location.longitude);
//    //        pointAnnotation.title = poi.name;
//    //        pointAnnotation.subtitle = poi.address;
//    //        [self.mapView addAnnotation:pointAnnotation];
//        }
//    self.dataArr = [NSMutableArray arrayWithArray:arr];
//    DYLog(@"-----%@",_dataArr);
//    [self reloadData];
//}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self isEditStatus:YES];
    isDragSearch = NO;
    [_handleView setContentOffset:(CGPointMake(0, SCREEN_HEIGHT/3))animated:YES];
    [_mapSearchListView setContentOffset:(CGPointMake(0, SCREEN_HEIGHT/3))animated:YES];
    if (textField.text.length != 0) {
        [self textSearch:textField.text];
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [self isEditStatus:NO];
    isDragSearch = NO;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    ENDEDIT
    isDragSearch = NO;
    return YES;
}



#pragma mark - 完成取消部分
- (void)creatMore {
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaTopHeight+20);
    gradientLayer.colors = @[(__bridge id)UIColorRGBA(0, 0, 0, 0.4).CGColor,(__bridge id)UIColorRGBA(0, 0, 0, 0.25).CGColor,(__bridge id)UIColorRGBA(0, 0, 0, 0.1).CGColor,(__bridge id)CLEAR_COLOR.CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.locations = @[@0,@0.35,@0.7,@1];
    [self.view.layer addSublayer:gradientLayer];
    cancelBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [cancelBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:DYLocalizedString(@"取消") forState:(UIControlStateNormal)];
    [cancelBtn setTitleColor:WHITE_COLOR forState:(UIControlStateNormal)];
    cancelBtn.titleLabel.font = FONT(16);
    [self.view addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.view).offset(SafeAreaTopHeight-38);
    }];
    doneBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [doneBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn setTitle:DYLocalizedString(@"m发送") forState:(UIControlStateNormal)];
    [doneBtn setTitleColor:WHITE_COLOR forState:(UIControlStateNormal)];
    doneBtn.backgroundColor = BASIC_COLOR;
    doneBtn.titleLabel.font = FONT(16);
    doneBtn.layer.cornerRadius = 4;
    doneBtn.layer.masksToBounds = YES;
    [self.view addSubview:doneBtn];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(self.view).offset(SafeAreaTopHeight-38);
    }];
}

// 完成取消点击
- (void)btnAction:(UIButton *)sender {
    if (sender == doneBtn) {
        DYLog(@"完成");
        if (_choseDic == nil) {
            return;
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(sendLocationMsg:)]) {
            [self.delegate sendLocationMsg:_choseDic];
        }
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }else if (sender == cancelBtn) {
        DYLog(@"取消");
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}


#pragma mark - 视图加载
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self auth];
    
}

- (void)creatUI {
    self.view.backgroundColor = [DYColorHelper sysGrayColor:6 lightColor:WHITE_COLOR];
    [self creatMap];
    [self creatSearch];
    [self creatList];
    [self creatMore];
}

#pragma mark - 权限
- (void)auth {
    [DYAuthHelper AuthForLocation:self hasAuthBlock:^(BOOL isFirst) {
        [self creatUI];
    } noAuth:^(BOOL isGoToResetAuth) {
        if (isGoToResetAuth==NO) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            {
                
            }
            break;
            case kCLAuthorizationStatusRestricted:
            case kCLAuthorizationStatusDenied:
            {
                [DYAuthHelper AuthForLocation:self hasAuthBlock:^(BOOL isFirst) {
                    
                } noAuth:^(BOOL isGoToResetAuth) {
                    if (isGoToResetAuth==NO) {
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }
                }];
            }
            break;
            case kCLAuthorizationStatusAuthorizedAlways:
            case kCLAuthorizationStatusAuthorizedWhenInUse:
            {
                [self creatUI];
            }
            break;
        default:
            break;
    }
}

@end
