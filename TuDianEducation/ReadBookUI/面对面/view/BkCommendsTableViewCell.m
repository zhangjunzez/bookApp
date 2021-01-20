//
//  BkCommendsTableViewCell.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/12.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//

#import "BkCommendsTableViewCell.h"
#import "LXSaveUserInforTool.h"

@interface BkCommendsTableViewCell()
@property (nonatomic, strong) UIView *bacView;
@property (nonatomic, strong) UIImageView *headerImg;
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *dateLable;
@property (nonatomic,strong) UILabel *contentLable;

@property (nonatomic,strong) UILabel *oldLabel;
@property (nonatomic,strong) UIButton *detailBtn;
@property (nonatomic,strong) UIButton *likesBtn;

@end

@implementation BkCommendsTableViewCell

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
    [self.bacView addSubview:self.likesBtn];
  
    [self.bacView addSubview:self.contentLable];

    [self.bacView addSubview:self.oldLabel];
    [self.bacView addSubview:self.dateLable];
    [self.bacView addSubview:self.detailBtn];
    
   
    
}

-(UIView *)bacView{
    if (!_bacView) {
        _bacView = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(0), ScreenWidth , ScaleW(143))];
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

-(UIButton *)likesBtn{
    if (!_likesBtn) {
        _likesBtn = [WLTools allocButtonTitle:@"99" font:systemFont(ScaleW(12)) textColor:kGrayTxtColor image:[UIImage imageNamed:@"点赞_d"] frame:CGRectMake(ScaleW(289), _headerImg.top, ScaleW(60), ScaleW(30)) sel:@selector(likesBtnAction:) taget:self];
        [_likesBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -ScaleW(5), 0, 0)];
        _likesBtn.right = self.bacView.width;
    }
    return _likesBtn;
}
-(void)likesBtnAction:(UIButton *)sender
{
    
}

-(UILabel *)contentLable{
    if (!_contentLable) {
        _contentLable = [WLTools allocLabel:@"一次很好的购物体验，服务周到，物流快速，配送也很周到，卖家态度也很好~ 下次还回购~" font:systemFont(ScaleW(12)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(10), ScaleW(11) + _headerImg.bottom, ScaleW(355), ScaleW(42)) textAlignment:(NSTextAlignmentLeft)];
        _contentLable.numberOfLines = 2;
    }
    return _contentLable;
}
-(UILabel *)dateLable{
    if (!_dateLable) {
        _dateLable = [WLTools allocLabel:@"1天前" font:systemFont(ScaleW(11)) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(15), _contentLable.bottom +ScaleW(15), ScaleW(50),ScaleW(11)) textAlignment:(NSTextAlignmentCenter)];
        _dateLable.cornerRadius = _dateLable.height/2.f;
        _dateLable.backgroundColor = kSubBacColor;
       
    }
    return _dateLable;
}


-(UIButton *)detailBtn{
    if (!_detailBtn) {
        _detailBtn = [WLTools allocButtonTitle:@"" font:systemFont(ScaleW(12)) textColor:kGrayTxtColor image:[UIImage imageNamed:@"更多_d"] frame:CGRectMake(0, ScaleW(14) + _contentLable.bottom, ScaleW(60), ScaleW(30)) sel:@selector(detailBtnAction) taget:self];
        [_detailBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -ScaleW(5), 0, 0)];
        _detailBtn.right = self.bacView.width;
    }
    return _detailBtn;
}
-(void)detailBtnAction
{
    !self.moreBlock?:self.moreBlock();
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
//    [self.detailBtn setTitle:_dataDic[@"commentCount"] forState:(UIControlStateNormal)];
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
