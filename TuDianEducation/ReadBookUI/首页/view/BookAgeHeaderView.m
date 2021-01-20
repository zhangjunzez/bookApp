//
//  BookAgeHeaderView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/12.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//


#import "BookAgeHeaderView.h"
#import "BkAgeItemsView.h"


@interface BookAgeHeaderView()

@property (nonatomic,strong) NSMutableArray *imgUiarray;
@property (nonatomic,strong) NSArray*imgArray;
@property (nonatomic,strong) UIScrollView *scrollView;



@end
@implementation BookAgeHeaderView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(ScaleW(0), 0, ScreenWidth, ScaleW(300));
 
        self.imgArray = @[@"0~3岁",@"3~6岁",@"6~9岁",@"9~12岁",@"影音书"];
        self.height = self.scrollView.bottom + ScaleW(15);
        self.backgroundColor = kWhiteColor;
    }
    return self;
}



-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,self.width, ScaleW(80))];
        
    }
    return _scrollView;
}
-(NSMutableArray *)imgUiarray{
    if (!_imgUiarray) {
        _imgUiarray = [NSMutableArray array];
    }
    return _imgUiarray;
}
-(void)setImgArray:(NSArray *)imgArray{
    _imgArray = imgArray;
    for (UIView *v in self.imgUiarray) {
        [v removeFromSuperview];
    }
    [self.imgUiarray removeAllObjects];
    for (int i = 0; i < _imgArray.count; i ++) {
        BkAgeItemsView *img = [[BkAgeItemsView alloc]initWithFrame:CGRectMake(0 + i * ScaleW(76), 0, ScaleW(76), ScaleW(80))];
        [self.scrollView addSubview:img];
        self.scrollView.contentSize = CGSizeMake(img.right + ScaleW(16), 0);
        [self.imgUiarray addObject:img];
        WS(weakSelf);
        img.messageLabel.text = _imgArray[i];
        img.selectBlock = ^(BkAgeItemsView * _Nonnull sender) {
            [weakSelf setSelctItems:sender];
        };
    }
    [self addSubview:self.scrollView];
}

-(void)setSelctItems:(BkAgeItemsView *)sender
{
    for (BkAgeItemsView *v in self.imgUiarray) {
        if (v == sender) {
            [v setItemsSelct:YES];
        }else{
            [v setItemsSelct:NO];
        }
    }
    NSUInteger index = [self.imgUiarray indexOfObject:sender];
    !self.selctItemBlock?:self.selctItemBlock(index);
}


@end
