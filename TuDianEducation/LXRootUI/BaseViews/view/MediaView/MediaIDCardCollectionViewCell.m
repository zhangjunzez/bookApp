//
//  MediaIDCardCollectionViewCell.m
//  TuDianEducation
//
//  Created by 张本超 on 2020/4/23.
//  Copyright © 2020 郑州大點哥. All rights reserved.
//


#import "MediaIDCardCollectionViewCell.h"
@interface MediaIDCardCollectionViewCell()

@end
@implementation MediaIDCardCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self viewConfig];
    }
    return self;
}

-(void)viewConfig
{
    [self.contentView addSubview:self.contentImgView];
    [self.contentView addSubview:self.messageLabel];
    [self.contentView addSubview:self.deleteBtn];
    [self.contentView addSubview:self.addBtn];
}

-(UIImageView *)contentImgView{
    if (!_contentImgView) {
        _contentImgView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(0), ScaleW(0), self.size.width , self.size.height )];
       // [_contentImgView setBorderWithWidth:1 andColor:kGrayTxtColor];
    }
    return _contentImgView;
}
-(UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(15)) textColor:kWhiteColor frame:CGRectMake(0, self.height - ScaleW(30), self.size.width, ScaleW(30)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _messageLabel;
}

-(UIButton *)deleteBtn
{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn btn:_deleteBtn font:ScaleW(0) textColor:kWhiteColor text:@"" image:[UIImage imageNamed:@""] sel:@selector(deleteAction:) taget:self];
        _deleteBtn.frame = CGRectMake(self.width - ScaleW(20), 0, ScaleW(20), ScaleW(20));
        _deleteBtn.backgroundColor = kRedColor;
    }
    return _deleteBtn;
}
-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn btn:_addBtn font:ScaleW(20) textColor:kMainTxtColor text:@"+" image:nil sel:@selector(addAction:) taget:self];
        _addBtn.frame = CGRectMake(self.width - ScaleW(20), 0, ScaleW(20), ScaleW(20));
        _addBtn.centerX = self.width/2;
        _addBtn.centerY = self.height/2;
        
    }
    return _addBtn;
}
-(void)deleteAction:(UIButton *)sender
{
    !self.deleteBlock?:self.deleteBlock(sender);
}
-(void)addAction:(UIButton *)sender
{
    !self.addBlock?:self.addBlock(sender);
}

@end
