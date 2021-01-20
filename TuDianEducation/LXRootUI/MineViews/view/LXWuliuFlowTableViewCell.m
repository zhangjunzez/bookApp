//
//  LXWuliuFlowTableViewCell.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/14.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXWuliuFlowTableViewCell.h"
@interface LXWuliuFlowTableViewCell()
@end
@implementation LXWuliuFlowTableViewCell

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
    self.contentView.backgroundColor = kMainBgColor;
    [self.contentView addSubview:self.bacView];
    [self.bacView addSubview:self.dateLabel];
    [self.bacView addSubview:self.contentLabel];
    
    
}
-(UIView *)bacView{
    if (!_bacView) {
        _bacView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(10), ScaleW(10), ScreenWidth - ScaleW(30), ScaleW(50))];
        [_bacView setCornerRadius:ScaleW(5)];
        _bacView.backgroundColor = kWhiteColor;
    }
    return _bacView;
}
-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(11)) textColor:kGrayTxtColor frame:CGRectMake(ScaleW(10), ScaleW(10), self.bacView.width - ScaleW(20), ScaleW(11)) textAlignment:(NSTextAlignmentLeft)];
        
    }
    return _dateLabel;
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(12)) textColor:kMainTxtColor frame:CGRectMake(_dateLabel.left, _dateLabel.bottom + ScaleW(5), _dateLabel.width, ScaleW(12)) textAlignment:(NSTextAlignmentLeft)];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}
@end
