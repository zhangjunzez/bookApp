//
//  MyXindeTableViewCell.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/9.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//


#import "MyXindeTableViewCell.h"
#import "LXSaveUserInforTool.h"

@interface MyXindeTableViewCell()
@property (nonatomic, strong) UIView *bacView;
@property (nonatomic, strong) UIImageView *headerImg;
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *dateLable;
@property (nonatomic,strong) UILabel *contentLable;

@property (nonatomic,strong) NSMutableArray *imgUiarray;
@property (nonatomic,strong) NSArray*imgArray;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UILabel *oldLabel;
@property (nonatomic,strong) UIButton *commentsBtn;
@property (nonatomic,strong) UIButton *likesBtn;

@end

@implementation MyXindeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig
{   self.selectionStyle = UITableViewCellSelectionStyleNone;

    [self.contentView addSubview:self.bacView];
    [self.bacView addSubview:self.headerImg];
    [self.bacView addSubview:self.nameLabel];
    [self.bacView addSubview:self.dateLable];
    [self.bacView addSubview:self.contentLable];
     self.imgArray = @[@"",@"",@"",@""];
    [self.bacView addSubview:self.oldLabel];
    [self.bacView addSubview:self.commentsBtn];
    [self.bacView addSubview:self.likesBtn];
   
    
}

-(UIView *)bacView{
    if (!_bacView) {
        _bacView = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(0), ScreenWidth , ScaleW(235))];
        _bacView.backgroundColor = kWhiteColor;
    }
    return _bacView;
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
        _contentLable.numberOfLines = 2;
    }
    return _contentLable;
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _contentLable.bottom,ScreenWidth, ScaleW(92))];
        
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
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(10) + i * ScaleW(119), 0, ScaleW(116), ScaleW(91))];
        img.backgroundColor = kGrayBtnBacColor;
        [img sd_setImageWithURL:[NSURL URLWithString:imgArray[i]]];
        [self.scrollView addSubview:img];
        self.scrollView.contentSize = CGSizeMake(img.right + ScaleW(16), 0);
        [self.imgUiarray addObject:img];
    }
    [self.contentView addSubview:self.scrollView];
}
-(UILabel *)oldLabel{
    if (!_oldLabel) {
        _oldLabel = [WLTools allocLabel:@"0~3岁" font:systemFont(ScaleW(12)) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(11), ScaleW(14) + _scrollView.bottom, ScaleW(120), ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _oldLabel;
}
-(UIButton *)commentsBtn{
    if (!_commentsBtn) {
        _commentsBtn = [WLTools allocButtonTitle:@"99" font:systemFont(ScaleW(12)) textColor:kGrayTxtColor image:[UIImage imageNamed:@"pingun"] frame:CGRectMake(0, ScaleW(14) + _scrollView.bottom, ScaleW(60), ScaleW(30)) sel:@selector(commentsBtnAction) taget:self];
        [_commentsBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -ScaleW(5), 0, 0)];
        _commentsBtn.left = ScaleW(236);
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
