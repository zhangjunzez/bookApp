//
//  LXTitleImgeArrayItemView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/30.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXTitleImgeArrayItemView.h"
#import "MediaCollectionView.h"
#import "MediaModel.h"
@interface LXTitleImgeArrayItemView()
@property (nonatomic,assign) CGFloat top;
@property (nonatomic,strong) NSString *titleString;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UILabel *redPointLabel;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) MediaCollectionView *mediaView;

@end
@implementation LXTitleImgeArrayItemView
-(instancetype)initWithTop:(CGFloat) top title:(NSString *)title imgeArray:(NSArray *)imageArray redHidden:(BOOL)redHidden;
{
    if (self = [super init]) {
        self.top = top;
        self.titleString = title;
        NSMutableArray *a = [NSMutableArray array];
        for (id obj  in imageArray) {
            if([obj isKindOfClass:[NSString class]]){
                UIImage *img = [UIImage imageNamed:obj];
                MediaModel *model = [[MediaModel alloc]init];
                model.img = img;
                [a addObject:model];
            }else
            {
                [a addObjectsFromArray:imageArray];
            }
        }
        [self.dataArray addObjectsFromArray:a];
        [self viewConfig];
        self.redPointLabel.hidden = redHidden;
    }
    return self;
};
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(void)viewConfig{
    self.frame = CGRectMake(0, _top, ScreenWidth, ScaleW(115));
    self.backgroundColor = kWhiteColor;
    [self addSubview:self.redPointLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.mediaView];
    
}
-(UILabel *)redPointLabel{
    if (!_redPointLabel) {
        _redPointLabel = [WLTools allocLabel:@"*" font:systemFont(ScaleW(14)) textColor:kRedColor frame:CGRectMake(ScaleW(12), ScaleW(15), ScaleW(15), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _redPointLabel;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:_titleString font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(28), ScaleW(15), ScreenWidth - ScaleW(56), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _titleLabel;
}
-(MediaCollectionView *)mediaView{
    if (!_mediaView) {
        _mediaView = [[MediaCollectionView alloc]initWithFrame:CGRectMake(ScaleW(15),  ScaleW(10) + _titleLabel.bottom, ScaleW(320), ScaleW(50))];
        WS(weakSelf);
        _mediaView.limitCount = _limitCount?:5;
        _mediaView.row = 5;
        _mediaView.dataSource = self.dataArray;
        
        _mediaView.showCurrentIndexBlock = ^(NSInteger currentIndex) {
            //[weakSelf selectedIndex:currentIndex];
        };
        _mediaView.addCurrentBlock = ^{
           
        };
    }
    return _mediaView;
}
-(NSArray *)urlsArray{
    if (!_mediaView.dataSource.count) {
        _urlsArray = @[];
    }else{
        NSMutableArray *array = [NSMutableArray array];
        for (MediaModel *model in _mediaView.dataSource) {
            if (model.imgUrl.length) {
                NSMutableString *string = [[NSMutableString alloc]initWithString:model.imgUrl];
                [array addObject:string];
            }
        }
        _urlsArray = array;
    }
    return _urlsArray;
}
-(NSString *)urlsString{
    if (!self.urlsArray.count) {
        _urlsString = @"";
    }else{
        _urlsString = self.urlsArray.firstObject;
    }
    return _urlsString;
}
-(void)setLimitCount:(NSInteger)limitCount
{
    _limitCount = limitCount;
    self.mediaView.limitCount = _limitCount;
}
-(void)setSetUrlsArray:(NSArray *)setUrlsArray{
    _setUrlsArray = setUrlsArray;
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *url in _setUrlsArray) {
        if (url.length) {
            MediaModel *model = [[MediaModel alloc]init];
            model.imgUrl = [WLTools imageURLWithURL:url];
            [array addObject:model];
        }
        
    }
    if (!array.count) {
        MediaModel *firstModel = [[MediaModel alloc]init];
        firstModel.img = [UIImage imageNamed:@""];
        [array addObjectsFromArray:@[firstModel]];
    }
    _mediaView.dataSource = array;
}
-(void)setSetServerArray:(NSArray *)setServerArray{
    _setServerArray = setServerArray;
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *url in _setServerArray) {
        MediaModel *model = [[MediaModel alloc]init];
        model.imgUrl = [WLTools imageURLWithURL:url];
        [array addObject:model];
    }
    MediaModel *model = [[MediaModel alloc]init];
    [array addObject:model];
    _mediaView.dataSource = array;
}
@end
