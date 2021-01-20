//
//  LXClassifyModel.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/7.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXClassifyModel.h"

@implementation LXClassifyModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"typeid"]) {
        self.typeId = value;
    }
}
@end
