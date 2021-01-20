//
//  LXMineBottomView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/24.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXMineBottomView.h"
#import "BottomItemView.h"
@interface LXMineBottomView()
@property (nonatomic,strong) NSArray *imgArray;
@property (nonatomic,strong) NSArray *nameArray;
@end

@implementation LXMineBottomView
-(NSArray *)nameArray{
    if (!_nameArray) {
        _nameArray = @[@"我的收益",@"我的积分",@"实名认证",@"我的推荐",@"常用地址",@"学习管理",@"服务管理",@"帮助中心"];
    }
    return _nameArray;
}
-(NSArray *)imgArray{
    if (!_imgArray) {
        _imgArray = @[@"wode_wodeshouyi",@"wode_fuwu",@"wode_renzheng",@"wode_tuijian",@"wode_changyongdizhi",@"wode_xuexi",@"wode_fuwu",@"wode_bangzhu"];
    }
    return _imgArray;
}

-(instancetype)initWithTop:(CGFloat)top imageArray:(NSArray *)imgArray nameArray:(NSArray *)nameArray
{
    if (self = [super init]) {
        self.frame = CGRectMake(ScaleW(15), top, ScaleW(345), ScaleW(153));
        self.backgroundColor = kWhiteColor;
        [self setCornerRadius:ScaleW(5)];
        self.imgArray = imgArray;
        self.nameArray = nameArray;
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig
{
    for (int i = 0; i <self.nameArray.count; i ++) {
        BottomItemView *v = [[BottomItemView alloc]initWithImge:[UIImage imageNamed:self.imgArray[i]] message:self.nameArray[i]];
        v.left = (i%4)*v.width;
        v.top = (i/4)*v.height;
        v.index = i;
        [self addSubview:v];
        WS(weakSelf);
        v.itemClickBlock = ^(NSInteger index) {
            !weakSelf.itemClickedBlock?:weakSelf.itemClickedBlock(index,self.nameArray[i]);
        };
    }
    self.height = (((self.nameArray.count - 1)/4) + 1)*(ScaleW(153/2.f));
}
@end
