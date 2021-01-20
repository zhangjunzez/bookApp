//
//  DYDBUserIM_Conversation.h
//  XILAIBANG
//
//  Created by ff on 2019/9/20.
//  Copyright © 2019 大點哥. All rights reserved.
//

#import "RLMObject.h"
//    JMSGConversation
//    JMSGUser
//    JMSGGroup
//    JMSGChatRoom
//    JMSGMessage
NS_ASSUME_NONNULL_BEGIN

@interface DYDBUserIM_Conversation : RLMObject

// 多用户唯一标识(xlb_uid+unique_id)
@property NSString *DYUsersID;

// 用户唯一标识
@property NSString *xlb_uid;

// 头像
@property NSData *avatar;
// 会话类型
@property NSNumber <RLMInt> *conversationType;
// 名字
@property NSString *name;
// 最新消息的时间戳
@property NSString *latestTimeInterval;
// 未读消息条数
@property NSNumber <RLMInt> *unReadCount;
// 群组消息发消息人
@property NSString *groupSendman;
// 最新消息内容
@property NSString *messageContent;

// 置顶
@property NSNumber <RLMBool> *isReplaceTop;
// 置顶时间戳
@property NSString *replaceTopTimeInterval;
// 免打扰
@property NSNumber <RLMBool> *isNoDisturb;
// 会话对象ID
@property NSString *targetID;

// 另加的

// 更新会话的时间戳
@property NSString *updateTimeInterval;
// 有没有草稿
@property NSNumber <RLMBool> * hasDraft;
// 草稿内容
@property NSString *draftText;
// 是否隐藏(其实就是删除功能,但是当新消息来了以后,无法判断是否静音等操作)
@property NSNumber <RLMBool> *isHide;
// 单聊会话专用(黑名单是需要隐藏会话的)
@property NSNumber <RLMBool> *isBlack;
// 聊天背景
@property NSData *chatBackGroundImage;


@end

NS_ASSUME_NONNULL_END
