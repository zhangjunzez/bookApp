//
//  BkFaceDetailHeader.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/12.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BkFaceDetailHeader.h"
#import "LXSaveUserInforTool.h"

@interface BkFaceDetailHeader(){
    CGFloat imgTop;
}

@property (nonatomic, strong) UIImageView *headerImg;
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *dateLable;
@property (nonatomic,strong) UILabel *contentLable;

@property (nonatomic,strong) NSMutableArray *imgUiarray;
@property (nonatomic,strong) NSArray*imgArray;

@property (nonatomic,strong) UILabel *oldLabel;
@property (nonatomic,strong) UIButton *commentsBtn;
@property (nonatomic,strong) UIButton *likesBtn;

@end

@implementation BkFaceDetailHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(200));
        [self addSubview:self.headerImg];
        [self addSubview:self.nameLabel];
        [self addSubview:self.dateLable];
        [self addSubview:self.contentLable];
         self.imgArray = @[@"",@"",@"",@""];

        [self addSubview:self.commentsBtn];
        [self addSubview:self.likesBtn];
        self.height = self.likesBtn.bottom + ScaleW(20);
        self.backgroundColor = kWhiteColor;
    }
    return self;
}



-(UIImageView *)headerImg{
    if (!_headerImg) {
        _headerImg = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(11), ScaleW(15), ScaleW(35), ScaleW(35))];
        [_headerImg setCornerRadius:_headerImg.height/2.f];
        _headerImg.backgroundColor = kGrayTxtColor;
 
    }
    return _headerImg;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:@"首届星洲" font:systemBoldFont(ScaleW(13)) textColor:kMainTxtColor frame:CGRectMake(_headerImg.right + ScaleW(11), _headerImg.top + ScaleW(12), ScaleW(300), ScaleW(13)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _nameLabel;
}


-(UILabel *)dateLable{
    if (!_dateLable) {
        _dateLable = [WLTools allocLabel:@"1天前" font:systemFont(ScaleW(11)) textColor:kGreenColor frame:CGRectMake(_nameLabel.left, _nameLabel.top, _nameLabel.width,ScaleW(11)) textAlignment:(NSTextAlignmentRight)];
        
       
    }
    return _dateLable;
}
-(UILabel *)contentLable{
    if (!_contentLable) {
        _contentLable = [WLTools allocLabel:@"一次很好的购物体验，服务周到，物流快速，配送也很周到，卖家态度也很好~ 下次还回购~" font:systemFont(ScaleW(12)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(10), ScaleW(11) + _headerImg.bottom, ScaleW(355), ScaleW(42)) textAlignment:(NSTextAlignmentLeft)];
        _contentLable.numberOfLines = 0;
    }
    return _contentLable;
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
    imgTop = _contentLable.bottom + ScaleW(18);
    for (int i = 0; i < _imgArray.count; i ++) {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(12) , imgTop, self.width - ScaleW(24), ScaleW(91))];
        img.backgroundColor = kGrayBtnBacColor;
        [img sd_setImageWithURL:[NSURL URLWithString:imgArray[i]]];
        
        [self.imgUiarray addObject:img];
        imgTop +=img.height + 5;
        [self addSubview:img];
    }
    
}

-(UIButton *)commentsBtn{
    if (!_commentsBtn) {
        _commentsBtn = [WLTools allocButtonTitle:@"99" font:systemFont(ScaleW(12)) textColor:kGrayTxtColor image:[UIImage imageNamed:@"pingun"] frame:CGRectMake(0, ScaleW(14) + imgTop, ScaleW(60), ScaleW(30)) sel:@selector(commentsBtnAction) taget:self];
        [_commentsBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -ScaleW(5), 0, 0)];
        _commentsBtn.left = 0;
    }
    return _commentsBtn;
}
-(void)commentsBtnAction
{
    
}
-(UIButton *)likesBtn{
    if (!_likesBtn) {
        _likesBtn = [WLTools allocButtonTitle:@"99" font:systemFont(ScaleW(12)) textColor:kGrayTxtColor image:[UIImage imageNamed:@"点赞_d"] frame:CGRectMake(_commentsBtn.right, _commentsBtn.top, ScaleW(60), ScaleW(30)) sel:@selector(likesBtnAction:) taget:self];
        [_likesBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -ScaleW(5), 0, 0)];
    }
    return _likesBtn;
}
-(void)likesBtnAction:(UIButton *)sender
{
    
}

//-(void)setDataDic:(NSDictionary *)dataDic{
//    _dataDic = dataDic;
//    [_headerImg sd_setImageWithURL:[NSURL URLWithString:[LXSaveUserInforTool sharedUserTool].persionalDic[@"avatar"]]];
//    _nameLabel.text = [LXSaveUserInforTool sharedUserTool].persionalDic[@"nickname"];
//    _dateLable.text = _dataDic[@"createDate"];
//    _contentLable.text = _dataDic[@"content"];
//    self.imgArray = _dataDic[@"images"];
////    "collectCount":"",//收藏数量
////                "shareCount":"",//分享数量
////                "commentCount":"",//评论数量
//    [self.commentsBtn setTitle:_dataDic[@"commentCount"] forState:(UIControlStateNormal)];
//    [self.shareBtn setTitle:_dataDic[@"shareCount"] forState:(UIControlStateNormal)];
//    [self.likesBtn setTitle:_dataDic[@"collectCount"] forState:(UIControlStateNormal)];
//    NSDictionary * member = _dataDic[@"member"];
//    _nameLabel.text = member[@"nickname"];
//    [_headerImg sd_setImageWithURL:[NSURL URLWithString:member[@"avatar"]]];
//    NSString *focused = _dataDic[@"focused"];
//    NSString *beFocused = _dataDic[@"beFocused"];
//    NSString *statue= @"关注";
//    if (focused.intValue&&beFocused.intValue) {
//        statue = @"相互关注";
//    }else{
//        if (focused.intValue) {
//            statue = @"已关注";
//        }
//        if (beFocused.intValue) {
//            statue = @"已被关注";
//        }
//        if (!beFocused.intValue&&!focused.intValue) {
//            statue = @"关注";
//        }
//    }
//    [self.statusBtn setTitle:statue forState:(UIControlStateNormal)];
//
//}
//-(UIButton *)statusBtn{
//    if (!_statusBtn) {
//        _statusBtn = [WLTools allocButtonTitle:@"相互关注" font:systemFont(ScaleW(13)) textColor:kMainTxtColor image:nil frame:CGRectMake(ScaleW(284), ScaleW(5) + _headerImg.top, ScaleW(80), ScaleW(28)) sel:@selector(statusBtnAction:) taget:self];
//        [_statusBtn setCornerRadius:_statusBtn.height/2.f];
//        [_statusBtn setBorderWithWidth:1 andColor:kGrayTxtColor];
//    }
//    return _statusBtn;
//}
//-(void)statusBtnAction:(UIButton *)sender{
//    !self.focusBlock?:self.focusBlock(sender);
//}
@end
