//
//  LXRealNameUploadItemView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/24.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXRealNameUploadItemView.h"
@interface LXRealNameUploadItemView()
@property (nonatomic,assign) CGFloat top;
@property (nonatomic,strong) NSString *nameString;
@property (nonatomic,strong) UILabel *nameLabel;

@end
@implementation LXRealNameUploadItemView

-(instancetype)initWithTop:(CGFloat)top name:(NSString *)name{
    if (self = [super init]) {
        self.top = top;
        self.nameString = name;
        [self viewConfig];
    }
    return self;
}
-(void)viewConfig{
    self.backgroundColor = kWhiteColor;
    self.frame = CGRectMake(0, _top, ScreenWidth, ScaleW(105));
    [self addSubview:self.nameLabel];
    [self addSubview:self.uploadImgeView];
    
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [WLTools allocLabel:_nameString font:systemFont(ScaleW(14)) textColor:kMainTxtColor frame:CGRectMake(ScaleW(28), ScaleW(15), ScreenWidth - ScaleW(30), ScaleW(14)) textAlignment:(NSTextAlignmentLeft)];
    }
    return _nameLabel;
}
-(UIImageView *)uploadImgeView{
    if (!_uploadImgeView) {
        _uploadImgeView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fabu_shangchuan"]];
        _uploadImgeView.left = _nameLabel.left;
        _uploadImgeView.top = ScaleW(15)+ _nameLabel.bottom;
        
        _uploadImgeView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(uploadAction)];
        [_uploadImgeView addGestureRecognizer:tap];
    }
    return _uploadImgeView;
}
-(void)uploadAction{
    !self.uploadBlcok?:self.uploadBlcok();
}

@end
