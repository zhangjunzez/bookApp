//
//  MediaCollectionViewCell.m
//  tudianjiaoyu
//
//  Created by 张本超 on 2020/4/5.
//  Copyright © 2020 张本超. All rights reserved.
//

#import "MediaCollectionViewCell.h"
#import "LXSaveUserInforTool.h"
@interface MediaCollectionViewCell()

@end
@implementation MediaCollectionViewCell
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
        _contentImgView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(1), ScaleW(1), self.size.width - ScaleW(5), self.size.height - ScaleW(5))];
        
        //_contentImgView.contentMode = UIViewContentModeScaleAspectFit;
        //_contentImgView.backgroundColor = kBlueColor;
    }
    return _contentImgView;
}
-(UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(15)) textColor:kMainTxtColor frame:CGRectMake(0, 0, self.size.width, ScaleW(15)) textAlignment:(NSTextAlignmentCenter)];
    }
    return _messageLabel;
}

-(UIButton *)deleteBtn
{
    if (!_deleteBtn) {
        UIImage *img =  [UIImage imageNamed:@"fabu_shanchu"];
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn btn:_deleteBtn font:ScaleW(0) textColor:kWhiteColor text:@"" image:img sel:@selector(deleteAction:) taget:self];
        _deleteBtn.frame = CGRectMake(self.width - ScaleW(13), 0, ScaleW(13), ScaleW(13));
//        _deleteBtn.backgroundColor = kRedColor;
    }
    return _deleteBtn;
}
-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn btn:_addBtn font:ScaleW(0) textColor:kMainTxtColor text:@"" image:nil sel:@selector(addAction:) taget:self];
        _addBtn.frame = CGRectMake(0, 0, self.width, self.height);
        _addBtn.centerX = self.width/2;
        _addBtn.centerY = self.height/2;
        [_addBtn setBackgroundImage:[UIImage imageNamed:@"fabu_shangchuan"] forState:(UIControlStateNormal)];
        if ([LXSaveUserInforTool sharedUserTool].medaiType == 1) {
            [_addBtn setBackgroundImage:[UIImage imageNamed:@"相机"] forState:(UIControlStateNormal)];
        }
        if ([LXSaveUserInforTool sharedUserTool].medaiType == 2) {
            [_addBtn setBackgroundImage:[UIImage imageNamed:@"zhaoxiangji"] forState:(UIControlStateNormal)];
        }
        
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
