//
//  CalendarCollectionViewCell.m
//  tudianjiaoyu
//
//  Created by 张本超 on 2020/4/3.
//  Copyright © 2020 张本超. All rights reserved.
//

#import "CalendarCollectionViewCell.h"
@interface CalendarCollectionViewCell()

@end

@implementation CalendarCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame])
    {
        [self viewConfig];
    }
    return self;
}

-(void)viewConfig
{   self.contentView.backgroundColor = kWhiteColor;
    [self.contentView addSubview:self.messageLabel];
    
}
-(UILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(12)) textColor:kBlueColor frame:CGRectMake(0, 0, self.width, self.height - ScaleW(20)) textAlignment:(NSTextAlignmentCenter)];
        _messageLabel.centerY = self.height/2.f;
        [_messageLabel setCornerRadius:ScaleW(5)];
        [_messageLabel setBorderWithWidth:1 andColor:kBlueColor];
    }
    return _messageLabel;
}

@end
