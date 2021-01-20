//
//  TDMediaManager.m
//  TuDianEducation
//
//  Created by zpz on 2020/4/25.
//  Copyright © 2020 郑州大點哥. All rights reserved.
//

#import "TDMediaManager.h"
#import "TDMediaModel.h"


@implementation TDMediaManager


+ (TDMediaModel *)saveImageDataWith:(TDImageDataModel *)model{
    
    if (!model.url.length) {
        return nil;
    }
    
    TDMediaModel *mo = [TDMediaModel new];
    mo.url = model.url;
    mo.fileType = @"image";
    mo.link = model.link;
    
    mo.originalName = [self saveImage:model.originalImage];
    mo.middleName = [self saveImage:model.middleImage];
    mo.smallName = [self saveImage:model.smallImage];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:mo];
    }];
    return mo;
}

+ (TDMediaModel *)saveImageWithURL:(NSString *)url image:(UIImage *)img{
    if (!url.length || !img) {
        return nil;
    }
    
    TDMediaModel *mo = [TDMediaModel new];
    mo.url = url;
    mo.fileType = @"image";
    
    mo.originalName = [self saveImage:img];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:mo];
    }];
    return mo;
}

+ (NSString *)saveImage:(UIImage *)img{
    if (!img) {
        return @"";
    }
    NSString *name = [NSString stringWithFormat:@"%@.png", [self return32LittleString]];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", kMediaPath, name];
    BOOL result = [UIImagePNGRepresentation([img changeDirection]) writeToFile:filePath atomically:YES];
    if (result) {
        return name;
    }
    return @"";
}

+ (TDMediaModel *)getImageDataWithUrl:(NSString *)url{
    RLMRealm *realm = [RLMRealm defaultRealm];
    TDMediaModel *res = [TDMediaModel objectInRealm:realm forPrimaryKey:url];
    
    if (!res) {
        return nil;
    }
    return res;
}

+ (TDMediaModel *)getImageDataWithLink:(NSString *)link{
    if (!link.length) {
        return nil;
    }
    RLMResults<TDMediaModel *> *results = [TDMediaModel objectsWhere:@"link = %@", link];
    TDMediaModel *res = results.firstObject;
    if (!res) {
        return nil;
    }
    return res;
}

+ (UIImage *)getImageWithPath:(NSString *)path{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", kMediaPath, path];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    return image;
}

+ (UIImage *)getImageWithURL:(NSString *)url{
    RLMRealm *realm = [RLMRealm defaultRealm];
    TDMediaModel *res = [TDMediaModel objectInRealm:realm forPrimaryKey:url];
    if (!res) {
        return nil;
    }
    return [self getImageWithPath:res.originalName];
}

+ (NSString *)return32LittleString{
    char data[32];
    for (int x=0;x<32;data[x++] = (char)('a'+ (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
}

+ (void)initialize{
   
    NSString *filePath = kMediaPath;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]) {
        [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:NO attributes:nil error:nil];
    }
}

@end
