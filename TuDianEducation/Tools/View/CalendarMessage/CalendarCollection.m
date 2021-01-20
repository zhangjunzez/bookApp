//
//  CalendarCollection.m
//  tudianjiaoyu
//
//  Created by 张本超 on 2020/4/3.
//  Copyright © 2020 张本超. All rights reserved.
//


#import "CalendarCollection.h"
#import "MineSignCollectionViewCell.h"
#import "CalendarModel.h"
#import "CalendarHelper.h"
@interface CalendarCollection()<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic)NSInteger totalNum;
@property (nonatomic, assign) BOOL isInit;
@property (nonatomic, strong) UIView *weekView;
@property (nonatomic,strong) UIColor *textColor;

@end

@implementation CalendarCollection

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        self.totalNum = 42;
        self.isInit = YES;
        [self setupUI];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame bacColor:(UIColor *)backColor textColor:(UIColor *)textColor
{
    self = [super initWithFrame:frame];
       if (self) {
           self.backgroundColor = backColor;
           self.totalNum = 42;
           self.isInit = YES;
           self.textColor = textColor;
           [self setupUI];
       }
       return self;
}
- (void)setupUI{
    [self addSubview:self.weekView];
    CGFloat left = ScaleW(15);
    CGFloat space = ScaleW(10);
    NSInteger row = 7;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((self.width - left * 2 - space * (row - 1))/row - 1, self.height/12);
    layout.minimumLineSpacing = space;
    layout.minimumInteritemSpacing = space;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _weekView.bottom + space, self.width, self.height - _weekView.bottom - space) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[MineSignCollectionViewCell class] forCellWithReuseIdentifier:@"MineSignCollectionViewCell"];
    _collectionView.contentInset = UIEdgeInsetsMake(0, left, 0, left);
    _collectionView.scrollEnabled = NO;
    self.collectionView.backgroundColor = self.backgroundColor?: kWhiteColor;
    [self addSubview:_collectionView];

}
-(UIView *)weekView{
    if (!_weekView) {
        _weekView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, ScaleW(28))];
       NSArray *array = [CalendarHelper weeksName];
        for (int i = 0; i < array.count; i ++) {
            CGFloat w = (_weekView.width - ScaleW(30)-6*ScaleW(15))/7.f;
            UILabel *l = [WLTools allocLabel:array[i] font:systemFont(12) textColor:_textColor?:kMainTxtColor frame:CGRectMake(ScaleW(15) + (w +ScaleW(15))*i, 0, w, _weekView.height) textAlignment:(NSTextAlignmentCenter)];
            [_weekView addSubview:l];
        }
    }
    return _weekView;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MineSignCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MineSignCollectionViewCell" forIndexPath:indexPath];
    CalendarModel *model = self.array[indexPath.row];
    if (model.isSelected) {
        cell.messageLabel.backgroundColor =_textColor?kDeepBlueColor:kBlueColor;
        cell.messageLabel.textColor = kWhiteColor;
    }else{
        cell.messageLabel.backgroundColor = self.backgroundColor;
        cell.messageLabel.textColor =_textColor?: kMainTxtColor;
    }
    if (model.day) {
        cell.messageLabel.text = model.day;
    }else{
        cell.messageLabel.text = @"";
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CalendarModel *model = self.array[indexPath.row];
    self.selectModel = model;
    [self.collectionView reloadData];
    if (self.selectBlock) {
        self.selectBlock(model);
    }
}


- (void)setArray:(NSArray *)array{
    _array = array;
    if (_isInit) {
        _isInit = NO;
        for (CalendarModel *model in _array) {
//            if (model.dayType == Today) {
//                self.selectModel = model;
//            }
        }
    }
    [self.collectionView reloadData];
}
-(void)setSelectString:(NSString *)selectString{
    _selectString = selectString;
    if (_selectString.length) {
    NSArray *array =  [_selectString componentsSeparatedByString:@","];
        if (array.count) {
            for (NSString *s in array) {
                for (CalendarModel *model in self.array) {
                    if (model.day.integerValue == s.integerValue) {
                        model.isSelected = YES;
                    }else{
                    }
                }
            }
            
            [self.collectionView reloadData];
        }
        
    }
    
}
-(void)setSelectArray:(NSArray *)selectArray{
   _selectArray  = selectArray;
    if (_selectArray.count) {
               for (NSDictionary *d in _selectArray) {
                   for (CalendarModel *model in self.array) {
                       NSString *s = [d objectForKey:@"days"];
                       if (model.day.integerValue == s.integerValue) {
                           model.isSelected = YES;
                       }else{
                       }
                   }
               }
               
               [self.collectionView reloadData];
           }
}
@end
