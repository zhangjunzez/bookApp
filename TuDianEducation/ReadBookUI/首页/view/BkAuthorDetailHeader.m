//
//  BkAuthorDetailHeader.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/14.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BkAuthorDetailHeader.h"
@interface BkAuthorDetailHeader()


@property (nonatomic,strong) UIView *authorView;
@property (nonatomic,strong) UIImageView *authorHeaderImg;
@property (nonatomic,strong) UILabel *authorNameLabel;
@property (nonatomic,strong) UILabel *authorAgeLabel;
@property (nonatomic,strong) UILabel *authorSchoolLabel;

@property (nonatomic,strong) UIView *messageView;
@property (nonatomic,strong) UILabel *authorjianli;
@property (nonatomic,strong) UIView *jianliView;
@property (nonatomic,strong) UILabel *jianliLabel;

@property (nonatomic,strong) UILabel *worksLabel;
@property (nonatomic,strong) NSMutableArray *imgUiarray;
@property (nonatomic,strong) NSArray*imgArray;
@property (nonatomic,strong) UIScrollView *scrollView;

@end
@implementation BkAuthorDetailHeader
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(200));
        self.backgroundColor = kSubBacColor;
        [self addSubview:self.authorView];
        UIImageView *img1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"组127"]];
        img1.origin = CGPointMake(ScaleW(30), self.authorView.bottom - ScaleW(8));
        UIImageView *img2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"组127"]];
        img2.origin = CGPointMake(ScaleW(340), self.authorView.bottom - ScaleW(8));
        
        [self addSubview:self.messageView];
        self.imgArray = @[@"",@"",@"",@""];
        self.height = self.messageView.bottom + ScaleW(10);
        [self addSubview:img1];
        [self addSubview:img2];
        
    }
    return self;
}
#pragma mark ----authorView


-(UIView *)authorView{
    if (!_authorView) {
        _authorView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(11), ScaleW(10), self.width - ScaleW(22), ScaleW(138))];
        _authorView.backgroundColor = kWhiteColor;
        _authorView.cornerRadius = ScaleW(10);
        [_authorView addSubview:self.authorHeaderImg];
        [_authorView addSubview:self.authorNameLabel];
        [_authorView addSubview:self.authorAgeLabel];
        [_authorView addSubview:self.authorSchoolLabel];
        
    }
    return _authorView;
}
-(UIImageView *)authorHeaderImg{
    if (!_authorHeaderImg) {
        _authorHeaderImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(11), ScaleW(23), ScaleW(90), ScaleW(90))];
        _authorHeaderImg.backgroundColor = kSubBacColor;
        _authorHeaderImg.cornerRadius = ScaleW(5);
        
    }
    return _authorHeaderImg;
}
-(UILabel *)authorNameLabel{
    if (!_authorNameLabel) {
        _authorNameLabel = [WLTools allocLabel:@"Lorem " font:systemBoldFont(ScaleW(16)) textColor:kMainTxtColor frame:CGRectMake(_authorHeaderImg.right + ScaleW(17), ScaleW(27), ScaleW(250), ScaleW(16)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _authorNameLabel;
}
-(UILabel *)authorAgeLabel{
    if (!_authorAgeLabel) {
        _authorAgeLabel = [WLTools allocLabel:@"出生年月：1996-12-10" font:systemFont(ScaleW(12)) textColor:kGrayTxtColor frame:CGRectMake(_authorHeaderImg.right + ScaleW(17), ScaleW(12) + _authorNameLabel.bottom, ScaleW(250), ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _authorAgeLabel;
}
-(UILabel *)authorSchoolLabel{
    if (!_authorSchoolLabel) {
        _authorSchoolLabel = [WLTools allocLabel:@"毕业院校：北京清华大学" font:systemFont(ScaleW(12)) textColor:kGrayTxtColor frame:CGRectMake(_authorHeaderImg.right + ScaleW(17), ScaleW(7) + _authorAgeLabel.bottom, ScaleW(250), ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _authorSchoolLabel;
}

-(UIView *)messageView{
    if (!_messageView) {
        _messageView = [[UIView alloc]initWithFrame:CGRectMake(_authorView.left, _authorView.bottom + ScaleW(10), _authorView.width, ScaleW(420))];
        _messageView.backgroundColor = kWhiteColor;
        _messageView.cornerRadius = ScaleW(10);
        [_messageView addSubview:self.authorjianli];
        [_messageView addSubview:self.jianliView];
        [self.jianliView addSubview:self.jianliLabel];
        [_messageView addSubview:self.worksLabel];
        [_messageView addSubview:self.scrollView];
    }
    return _messageView;
}

-(UILabel *)authorjianli{
    if (!_authorjianli) {
        _authorjianli = [WLTools allocLabel:@"作者简历" font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(18), ScaleW(32), ScaleW(300), ScaleW(40)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _authorjianli;
}
-(UIView *)jianliView{
    if (!_jianliView) {
        _jianliView = [[UIView alloc]initWithFrame:CGRectMake(_authorjianli.left, _authorjianli.bottom + ScaleW(13), ScaleW(317), ScaleW(89))];
        _jianliView.cornerRadius = ScaleW(5);
        _jianliView.backgroundColor = kSubBacColor;
    }
    return _jianliView;
}

-(UILabel *)jianliLabel{
    if (!_jianliLabel) {
        _jianliLabel = [WLTools allocLabel:@"张三，男，汉族，1975年12月10日出生于河南省郑州市。1991年毕业于清华大学汉语言文学系。文学学士文学创作一级，一级作家。现任清华出版社主任~" font:systemFont(ScaleW(12)) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(17), ScaleW(20), ScaleW(280), ScaleW(50)) textAlignment:(NSTextAlignmentLeft)];
        [_jianliLabel sizeToFit];
    }
    return _jianliLabel;
}
-(UILabel *)worksLabel{
    if (!_worksLabel) {
        _worksLabel = [WLTools allocLabel:@"代表作品" font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(18), ScaleW(35) + _jianliView.bottom, ScaleW(300), ScaleW(40)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _worksLabel;
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, ScaleW(20) + _worksLabel.bottom,ScreenWidth, ScaleW(150))];
        
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
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(9) +i *ScaleW(126), 0, ScaleW(126), ScaleW(148))];
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(9) , 0, ScaleW(108), ScaleW(104))];
        img.backgroundColor = kGrayBtnBacColor;
        [img sd_setImageWithURL:[NSURL URLWithString:imgArray[i]]];
        [view addSubview:img];
        UILabel *label = [WLTools allocLabel:@"初中数学运算能手" font:systemFont(ScaleW(13)) textColor:kSubTxtColor frame:CGRectMake(0, ScaleW(14) + img.bottom, view.width, ScaleW(13)) textAlignment:(NSTextAlignmentCenter)];
        [view addSubview:label];
        [self.scrollView addSubview:view];
        self.scrollView.contentSize = CGSizeMake(view.right + ScaleW(9), 0);
        [self.imgUiarray addObject:img];
    }
    
}
@end
