//
//  LXGetOrderHeaderView.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/6/30.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXGetOrderHeaderView.h"
#import "LXRunLoopLabel.h"
@interface LXGetOrderHeaderView()<LXRunLoopLabelDelegate>
@property (nonatomic,strong) LXRunLoopLabel *contentLabel;
@property (nonatomic,strong) NSString *contenString;
@end

@implementation LXGetOrderHeaderView

-(instancetype)initWithContentString:(NSString *)contentString
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(40));
        _contenString = contentString;
        [self addSubview:self.contentLabel];
        self.backgroundColor = kBlueBacColor;
    }
    return self;
};
-(LXRunLoopLabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[LXRunLoopLabel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _contentLabel.delegate = self;
        _contentLabel.directionType = LeftType;
        NSString *string = _contenString.length?_contenString:@"*****************************************************************************************************";
        CGFloat width = [self returnWidth:string font:ScaleW(14)];
        UILabel *label = [WLTools allocLabel:string font:systemFont(ScaleW(14)) textColor:kBlueColor frame:CGRectMake(0, 0, width, self.height) textAlignment:(NSTextAlignmentLeft)];
        [_contentLabel addContentView:label];
        [_contentLabel startAnimation];
    }
    return _contentLabel;
}
- (void)operateLabel: (LXRunLoopLabel *)autoLabel animationDidStopFinished: (BOOL)finished
{
    
};
- (void)startAnimation
{
    [self.contentLabel startAnimation];
};
@end
