//
//  LXMineRequstOrderListModel.m
//  TuDianEducation
//
//  Created by lixinkeji on 2020/7/10.
//  Copyright © 2020 zhangbenchao. All rights reserved.
//

#import "LXMineRequstOrderListModel.h"

@implementation LXMineRequstOrderListModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
-(CGFloat)offHeight{
    NSString *string  = [NSString stringWithFormat:@"%@--%@",self.industrys,self.equipmentname];
   double height = [string boundingRectWithSize:CGSizeMake(ScaleW(225), CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:systemFont(ScaleW(14))} context:nil].size.height;
    
    return height;
}
@end
