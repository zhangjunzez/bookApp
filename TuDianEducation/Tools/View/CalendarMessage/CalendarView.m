//
//  CalendarView.m
//  tudianjiaoyu
//
//  Created by 张本超 on 2020/4/3.
//  Copyright © 2020 张本超. All rights reserved.
//

#import "CalendarView.h"
#import "CalendarHelper.h"
#import "CalendarCollection.h"
@interface CalendarView()
@property (nonatomic, assign) NSInteger currentMouth;
@property (nonatomic, strong) UIView *barView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *weekView;
@property (nonatomic, strong) CalendarCollection *calendar;


@end
@implementation CalendarView
-(instancetype)init{
    if (self = [super init])
    {
        [self viewConfig];
        self.currentMouth = 0;
    }
    return self;
};
-(void)viewConfig
{
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenWidth);
    [self addSubview:self.barView];
    [self addSubview:self.weekView];
    [self addSubview:self.calendar];
    self.height = self.calendar.bottom;
    [self dataConfig];
};

-(void)dataConfig
{
    //init;
    NSArray *array = [CalendarHelper createMonthDataWith:self.currentMouth];
    self.calendar.array = array;
    for (CalendarModel *model in array) {
        if (model.dayType == Today) {
            self.selectModel = model;
        }
    }
   
    [self titleWithArray:array];
}

-(void)titleWithArray:(NSArray *)array
{
    CalendarModel *model = array[0];
       self.titleLabel.text = [NSString stringWithFormat:@"%@-%@",model.year,model.month];
}
-(UIView *)barView
{
    if (!_barView)
    {
        _barView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(40))];
        _barView.backgroundColor = kWhiteColor;
        UIButton *lastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        lastBtn.frame = CGRectMake(0, 0, ScaleW(120), _barView.height);
        [lastBtn btn:lastBtn font:ScaleW(15) textColor:kMainTxtColor text:@"上个月" image:nil sel:@selector(lastMouth:) taget:self];
        [_barView addSubview:lastBtn];
        UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
               nextBtn.frame = CGRectMake(ScreenWidth - ScaleW(120), 0, ScaleW(120), _barView.height);
               [nextBtn btn:nextBtn font:ScaleW(15) textColor:kMainTxtColor text:@"下个月" image:nil sel:@selector(nextMouth:) taget:self];
        [_barView addSubview:nextBtn];
        [_barView addSubview:self.titleLabel];
    }
    return _barView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(15)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(120), 0, ScreenWidth- ScaleW(240), _barView.height) textAlignment:(NSTextAlignmentCenter)];
        
    }
    return _titleLabel;
}

-(UIView *)weekView
{
    if (!_weekView) {
        _weekView = [[UIView alloc]initWithFrame:CGRectMake(0, _barView.bottom, ScreenWidth, ScaleW(40))];
        NSArray *weekArray = [CalendarHelper weeksName];
        
        for (int i = 0; i < 7; i ++) {
          NSString *weekName =  weekArray[i];
            CGFloat left = ScaleW(15) + i *((ScreenWidth-ScaleW(30))/7.f);
            UILabel *l = [WLTools allocLabel:weekName font:systemFont(ScaleW(15)) textColor:kMainTxtColor frame:CGRectMake(left, 0, (ScreenWidth-ScaleW(30))/7.f, ScaleW(40)) textAlignment:(NSTextAlignmentCenter)];
            [_weekView addSubview:l];
        }
         
    }
    return _weekView;
}
-(CalendarCollection *)calendar{
    if (!_calendar) {
        _calendar = [[CalendarCollection alloc]initWithFrame:CGRectMake(0, _weekView.bottom, ScreenWidth, ScreenWidth - ScaleW(80))];
        WS(weakSelf);
        _calendar.selectBlock = ^(CalendarModel * _Nonnull model) {
            !weakSelf.selectBlock?:weakSelf.selectBlock(model);
        };
    }
    return _calendar;
}
-(void)lastMouth:(UIButton *)sender
{
    self.currentMouth --;
    NSArray *array = [CalendarHelper createMonthDataWith:self.currentMouth];
    self.calendar.array = array;
    [self titleWithArray:array];
}
-(void)nextMouth:(UIButton *)sender
{
    self.currentMouth ++;
    NSArray *array = [CalendarHelper createMonthDataWith:self.currentMouth];
    self.calendar.array = array;
    [self titleWithArray:array];
}

@end
