//
//  MediaCollectionView.m
//  tudianjiaoyu
//
//  Created by 张本超 on 2020/4/5.
//  Copyright © 2020 张本超. All rights reserved.
//

#import "MediaCollectionView.h"
#import "MediaCollectionViewCell.h"
#import "MediaModel.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
@interface MediaCollectionView()<UICollectionViewDataSource, UICollectionViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    CGFloat left ;
    CGFloat space;
}

@property (nonatomic, strong) UICollectionViewCell *lastCell;

@end

@implementation MediaCollectionView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
         //self.limitCount = _limitCount==0?4:_limitCount;
        [self addSubview:self.collectionView];
       
    }
    return self;
}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        MediaModel *firstModel = [[MediaModel alloc]init];
        firstModel.img = [UIImage imageNamed:@""];
        [_dataSource addObjectsFromArray:@[firstModel]];
    }
    return _dataSource;
}
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        
           left = ScaleW(15);
           space = ScaleW(10);
           _row = _row?:4;
           UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
           layout.itemSize = CGSizeMake((self.width - left * 2 - space * (_row - 1))/_row,(self.width - left * 2 - space * (_row - 1))/_row);
           layout.minimumLineSpacing = space;
           layout.minimumInteritemSpacing = space;
           layout.scrollDirection = UICollectionViewScrollDirectionVertical;
           
           
           _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
           _collectionView.delegate = self;
           _collectionView.dataSource = self;
           [_collectionView registerClass:[MediaCollectionViewCell class] forCellWithReuseIdentifier:@"MediaCollectionViewCell"];
           _collectionView.contentInset = UIEdgeInsetsMake(0, left, 0, left);
           _collectionView.scrollEnabled = YES;
           self.collectionView.backgroundColor = kMainBgColor;
        //手势添加
//        //此处给其增加长按手势，用此手势触发cell移动效果
//        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)];
       // [_collectionView addGestureRecognizer:longGesture];
        [self addSubview:_collectionView];
    }
    return _collectionView;
}
- (void)handlelongGesture:(UILongPressGestureRecognizer *)longGesture {
    //判断手势状态
        switch (longGesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            //判断手势落点位置是否在路径上
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longGesture locationInView:self.collectionView]];
            if (indexPath == nil ) {
                break;
            }
            //在路径上则开始移动该路径上的cell
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            //移动过程当中随时更新cell位置
            [self.collectionView updateInteractiveMovementTargetPosition:[longGesture locationInView:self.collectionView]];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            //移动结束后关闭cell移动
            [self.collectionView endInteractiveMovement];
            if (self.dataSource.count < 9) {
               
                NSIndexPath *temp = [self.collectionView indexPathForCell:self.lastCell];
                NSIndexPath *end = [NSIndexPath indexPathForRow:self.dataSource.count - 1 inSection:0];
                if (temp.row != end.row) {
                     // 交换我们记录的最后一个位置的cell 和 当前最后一个位置的cell
                    [self.collectionView moveItemAtIndexPath:temp toIndexPath:end];
                }
            }
        }
            break;
        default:
        {
            [self.collectionView cancelInteractiveMovement];
        }
            break;
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    !self.showCurrentIndexBlock?:self.showCurrentIndexBlock(indexPath.row);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
        
    MediaCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MediaCollectionViewCell" forIndexPath:indexPath];
    MediaModel *model = self.dataSource[indexPath.row];
    
    
    if (model.img) {
       cell.contentImgView.image = model.img;
    }else{
        NSString* urls = [WLTools imageURLWithURL: model.imgUrl];
        if (model.imgUrl) {
            [cell.contentImgView sd_setImageWithURL:[NSURL URLWithString: urls] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                model.img = image;
            }];
        }
    }
    
    
    if (indexPath.row == self.dataSource.count - 1&&(model.img==nil&&model.imgUrl == nil)) {
        cell.deleteBtn.hidden = YES;
        cell.addBtn.hidden = NO;
        self.lastCell = cell;
    }else{
        cell.deleteBtn.hidden = NO;
        cell.addBtn.hidden = YES;
    }
    
    cell.deleteBtn.tag = indexPath.row + 10000;
    WS(weakSelf);
    cell.deleteBlock = ^(UIButton * _Nonnull btn) {
        [weakSelf.dataSource removeObjectAtIndex:btn.tag - 10000];
        if (weakSelf.dataSource.count == 0) {
            MediaModel *model = [[MediaModel alloc]init];
            [weakSelf.dataSource addObject:model];
        }
        [weakSelf.collectionView reloadData];
        !weakSelf.addCurrentBlock?:weakSelf.addCurrentBlock();
    };
    cell.addBlock = ^(UIButton * _Nonnull btn) {
       
       [self alertController];
    };
    return cell;
}
- (BOOL)collectionView:(UICollectionView *)collectionView canFocusItemAtIndexPath:(NSIndexPath *)indexPath {
        return YES;
}
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
        //返回YES允许其item移动
        if (indexPath.row == self.dataSource.count - 1 && self.dataSource.count < 9) {
            return NO;
        }
       return YES;
    }
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
        
      NSString *num = self.dataSource[sourceIndexPath.item];
     
        if (destinationIndexPath.row != self.dataSource.count - 1) {
           [self.dataSource removeObjectAtIndex:sourceIndexPath.item];
                [self.dataSource insertObject:num atIndex:destinationIndexPath.item];
        }else{
            
        }
        [self.collectionView reloadData];
}


#pragma mark -----------上传图片

- (void)alertController {
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
    }];
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
//    imagePickerController.allowsEditing = YES;
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self presentPickerConroller:imagePickerController sourceType:UIImagePickerControllerSourceTypeCamera];
    }];
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self presentPickerConroller:imagePickerController sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    [alertVc addAction:cancle];
    [alertVc addAction:camera];
    [alertVc addAction:photo];
    [[self topViewController]  presentViewController:alertVc animated:YES completion:nil];
}
- (void)presentPickerConroller:(UIImagePickerController *)imagePickerController sourceType:(UIImagePickerControllerSourceType)sourceType
{
    imagePickerController.sourceType = sourceType;
    imagePickerController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    //WS(weakSelf);
    [[self topViewController] presentViewController:imagePickerController animated:YES completion:^{
        //LSLog(Localized(@"present成功", nil));
        // [weakSelf hiddenView];
    }];
}
#pragma mark - photo delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //获取返回的图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //[self performSelector:@selector(saveImage:) withObject:image afterDelay:0.5];
    [self saveImage:image];
    [[self topViewController] dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)saveImage:(UIImage *)image
{
    MediaModel *model = [[MediaModel alloc]init];
    model.img = image;
    if (self.dataSource.count == self.limitCount) {
        [self.dataSource replaceObjectAtIndex:self.dataSource.count - 1 withObject:model];
    }else{
        [self.dataSource insertObject:model atIndex:self.dataSource.count -1];
    }
    !self.addCurrentBlock?:self.addCurrentBlock();
    [self.collectionView reloadData];
    NSUInteger index = [self.dataSource indexOfObject:model];
    
    [self uploadImage:image index:index];
}
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
}

-(UIView *)getCurrentViewWith:(NSInteger)index
{
  return   [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
};
-(void)setRow:(NSInteger)row{
    _row = row;
    [self.collectionView removeFromSuperview];
    [self addSubview:self.collectionView];
    self.height = (_limitCount/_row)*((self.width - left * 2 - space * (_row - 1))/_row) + space*2;
    self.collectionView.height = self.height;
}

#pragma mark 上传图片
-(void)uploadImage:(UIImage*)image index:(NSInteger)index
{
    [MBProgressHUD showHUDAddedTo:[self topViewController].view animated:YES];
    //!< 限制图片在1M以内
    image = [UIImage compressImageQuality:image toByte:(1*1024)];
    WS(weakSelf);
    [[HttpRequstApiManger shareManager]  upLoadImageByUrl:kImgBaseUrl ImageName:@"file" Params:@{} Image:image CallBack:^(id responseObject)
     {
        [MBProgressHUD hideHUDForView:[self topViewController].view animated:YES];

       NSString *result = responseObject[@"result"];
                 NSString *resultNote = responseObject[@"resultNote"];
                 NSString *urlString = responseObject[@"datastr"];
                 if ([result integerValue] == 0) {
                     //[self requstEdtingWithKey:@"icon" value:urlString];
                     //weakSelf.currenUploadView.currentUrl = urlString;
                     [weakSelf replaceDataArrayWith:urlString index:index];
                 }else{
                     [MBProgressHUD showError:resultNote];
                 }
     } Failure:^(NSError *error)
     {
         [MBProgressHUD hideHUDForView:[self topViewController].view animated:YES];
     }];
}
-(void)replaceDataArrayWith:(NSString *)urlString index:(NSInteger)index{
    MediaModel *model = self.dataSource[index];
    model.imgUrl = urlString;
}
-(void)setLimitCount:(NSInteger)limitCount{
    _limitCount = limitCount;
}

@end
