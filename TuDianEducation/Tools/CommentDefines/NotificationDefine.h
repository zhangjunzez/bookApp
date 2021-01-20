//
//  NotificationDefine.h
//  TuDianEducation
//
//  Created by zpz on 2020/5/8.
//  Copyright © 2020 郑州大點哥. All rights reserved.
//

#ifndef NotificationDefine_h
#define NotificationDefine_h

#define kRemoveObserver [[NSNotificationCenter defaultCenter] removeObserver:self];


///退出登录
#define kObserveNotificationForLoginOut(x) [[NSNotificationCenter defaultCenter] addObserver:self selector:x name:@"kNotificationForLoginOut" object:nil];
#define kSendNotificationForLoginOut [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationForLoginOut" object:nil userInfo:nil];



#endif /* NotificationDefine_h */
