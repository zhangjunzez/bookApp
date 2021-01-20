//
//  MineSignCollectionViewCell.m
//  TuDianEducation
//
//  Created by 张本超 on 2020/4/14.
//  Copyright © 2020 郑州大點哥. All rights reserved.
//


#import "MineSignCollectionViewCell.h"
@interface MineSignCollectionViewCell()

@end

@implementation MineSignCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame])
    {
        [self viewConfig];
    }
    return self;
}

-(void)viewConfig
{  
    [self.contentView addSubview:self.messageLabel];
}
-(UILabel *)messageLabel{
    if (!_messageLabel) {
        double f = MIN(self.height, self.width);
        _messageLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(14)) textColor:kBlueColor frame:CGRectMake(0, 0, f, f) textAlignment:(NSTextAlignmentCenter)];
        _messageLabel.centerY = self.height/2.f;
        _messageLabel.centerX = self.width/2.f;
        [_messageLabel setCornerRadius:f/2.f];
    }
    return _messageLabel;
}
@end
