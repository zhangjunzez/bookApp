//
//  BkConmendsTableViewCell.m
//  TuDianEducation
//
//  Created by lixinkeji on 2021/1/14.
//  Copyright © 2021 zhangbenchao. All rights reserved.
//



#import "BkConmendsTableViewCell.h"
#import "LXSaveUserInforTool.h"

@interface BkConmendsTableViewCell()
@property (nonatomic, strong) UIView *bacView;
@property (nonatomic, strong) UIImageView *headerImg;
@property (nonatomic, strong) UILabel *nameLabel;


@property (nonatomic,strong) UILabel *contentLable;

@property (nonatomic,strong) NSMutableArray *imgUiarray;
@property (nonatomic,strong) NSArray*imgArray;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UILabel *dateLabel;


@end

@implementation BkConmendsTableViewCell

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
    [self.bacView addSubview:self.contentLable];
     self.imgArray = @[@"",@"",@"",@""];
    [self.bacView addSubview:self.dateLabel];

   
    
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
-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [WLTools allocLabel:@"评论时间：2020.12.22  10:30" font:systemFont(ScaleW(12)) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(11), ScaleW(14) + _scrollView.bottom, ScaleW(250), ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _dateLabel;
}


@end
