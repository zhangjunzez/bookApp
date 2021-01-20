//
//  Configuration.h
//  TuDianEducation
//
//  Created by zpz on 2020/5/8.
//  Copyright © 2020 郑州大點哥. All rights reserved.
//

#ifndef Configuration_h
#define Configuration_h


///导航栏右侧按钮字体大小
#define kNavFont [UIFont systemFontOfSize:14]

///媒体资料本地地址
#define kMediaPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"td_media"]

///课题相关配置
#define kTaskMaxImageNum 5
#define kTaskMaxWidth [UIScreen mainScreen].bounds.size.width * 0.5
#define kTaskMaxHeight 200
#define kTaskMaxData 5000*1024

///身份证最大大小
#define kIDCardMaxData 1000*1024

///头像最大大小
#define kHeadMaxData 1000*1024

///提交按钮高度
#define kCommitBtnHeight 40
///提交按钮圆角
#define kCommitBtnRadius 20

///默认头像
#define kDefaultHeadImage [UIImage imageWithColor:[UIColor lightGrayColor]]
///默认头像
#define kMineHeadImage [UIImage imageNamed:@"base_defaulthead"]

#define kPublishBtnTag 10000000

#define kBiggerPublishTag 10000001
#endif /* Configuration_h */
