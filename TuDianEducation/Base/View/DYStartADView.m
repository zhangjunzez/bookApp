//
//  DYStartADView.m
//  XILAIBANG
//
//  Created by ff on 2019/9/12.
//  Copyright © 2019 大點哥. All rights reserved.
//

#import "DYStartADView.h"
#import "UIImage+GIF.h"

@interface DYStartADView ()

@property (nonatomic, copy)ADDoneBlock complate;
@property (nonatomic, strong)UIImageView *backImgv;
@property (nonatomic, strong)UIImageView *adImgv;

@end

@implementation DYStartADView

- (void)show {
    [KEYWINDOW addSubview:self];
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (self.complate) {
            self.complate(@"");
        }
    }];
}

- (instancetype)initWithType:(DYADType)type Para:(NSDictionary *)para complate:(ADDoneBlock)complate {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        _complate = complate;
        [self creatUIWithType:type Para:para];
    }
    return self;
}

- (void)creatUIWithType:(DYADType)type Para:(NSDictionary *)para {
    self.backImgv = [[UIImageView alloc]init];
    _backImgv.contentMode = UIViewContentModeScaleAspectFit;
    _backImgv.image = [self getLaunchImage];
    [self addSubview:self.backImgv];
    [_backImgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
    self.adImgv = [[UIImageView alloc]init];
    _adImgv.contentMode = UIViewContentModeScaleAspectFill;
    _adImgv.clipsToBounds = YES;
//    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[para objectForKey:@"img"]]];
//
//    NSData *imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[para objectForKey:@"img"] ofType:@""]];
    
//    _adImgv.image = [UIImage animatedImageWithImages:[para objectForKey:@"img"] duration:2.0];
    
    _adImgv.animationImages = [para objectForKey:@"img"];
    _adImgv.animationDuration = 2.5;
    _adImgv.animationRepeatCount = 1;
    [_adImgv startAnimating];
    
//    _adImgv.image = [UIImage imageWithGIFData:imageData];
    [self addSubview:self.adImgv];
    if (type == DYADType_FullADScreen) {
        [_adImgv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self);
        }];
    }else if (type == DYADType_SquareADScreen){
        [_adImgv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.width.height.mas_equalTo(SCREEN_WIDTH);
        }];
    }
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)([UIImage durationForGifData:imageData] * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self dismiss];
//    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismiss];
    });
}

- (UIImage *)GIFName:(NSString *)name bundle:(nullable NSBundle *)bundle scale:(NSUInteger)scale {
    NSBundle *bund;
    if (!bundle) {
        bund = [NSBundle mainBundle];
    }else {
        bund = bundle;
    }
    NSString *imagePath = [bund pathForResource:[NSString stringWithFormat:@"%@@%zdx", name, scale] ofType:@"gif"];
    if (!imagePath) {
        (scale + 1 > 3) ? (scale -= 1) : (scale += 1);
        imagePath = [bund pathForResource:[NSString stringWithFormat:@"%@@%zdx", name, scale] ofType:@"gif"];
    }
    if (imagePath) {
        // 传入图片名(不包含@Nx)
        NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
        return [UIImage sd_imageWithGIFData:imageData];
    } else {
        imagePath = [bund pathForResource:name ofType:@""];
        if (imagePath) {
            // 传入的图片名已包含@Nx or 传入图片只有一张 不分@Nx
            NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
            return [UIImage sd_imageWithGIFData:imageData];
        } else {
            // 不是一张GIF图片(后缀不是gif)
            return [UIImage imageNamed:name];
        }
    }
}

- (UIImage *)getLaunchImage{
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString *viewOr = @"Portrait";//垂直
    NSString *launchImage = nil;
    NSArray *launchImages =  [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dict in launchImages) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(viewSize, imageSize) && [viewOr isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            launchImage = dict[@"UILaunchImageName"];
            return [UIImage imageNamed:launchImage];
        }
    }
    return nil;
}

@end
