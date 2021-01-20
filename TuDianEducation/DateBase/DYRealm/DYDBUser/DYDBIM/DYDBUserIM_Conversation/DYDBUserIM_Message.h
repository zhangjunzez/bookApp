//
//  DYDBUserIM_Message.h
//  XILAIBANG
//
//  Created by ff on 2019/10/22.
//  Copyright © 2019 大點哥. All rights reserved.
//

#import "RLMObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface DYDBUserIM_Message : RLMObject

// 用户唯一标识
@property NSString *xlb_uid;

//消息ID：这个 ID 是本地生成的ID，不是服务器端下发时的ID。
@property NSString *msgId;

// @abstract 服务器端下发的消息ID.
// @discussion 一般用于与服务器端跟踪消息.
@property NSString * serverMessageId;

/*!
 * @abstract 消息发送目标
 * @discussion 与 [fromUser] 属性相对应. 根据消息方向不同:
 * - 收到的消息，target 就是我自己。
 * - 发送的消息，target 是我的聊天对象。
 * 单聊是对方用户;
 * 群聊是聊天群组, 也与当前会话的目标一致 [JMSGConversation target]
 */
// 把对象转成字符串存到这(本来是对象的)
@property NSString *target;

/*!
 * @abstract 消息发送目标应用
 * @discussion 这是为了支持跨应用聊天, 而新增的字段.
 * 单聊时目标是 username. 当该用户为默认 appKey 时, 则不填此字段.
 * 群聊时目标是 groupId, 不填写此字段.
 */
@property NSString *targetAppKey;

/*!
 * @abstract 消息来源用户 Appkey
 * @discussion 这是为了支持跨应用聊天, 而新增的字段.
 * 不管群聊还是单聊, from_id 都是发送消息的 username. 当该用户是默认 appKey 时, 则不填写此字段.
 */
@property NSString *fromAppKey;

/*!
 * @abstract 消息来源用户
 * @discussion 与 [target] 属性相对应. 根据消息方向不同:
 * - 收到的消息, fromUser 是发出消息的对方.
 *      单聊是聊天对象, 也与当前会话目标用户一致 [JMSGConversation target],
 *      群聊是该条消息的发送用户.
 * - 发出的消息: fromUser 是我自己.
 */
// JMSGUser 转 str(原来是JMSGUser)
@property NSString *fromUser;

/*!
 * @abstract 消息来源类型
 * @discussion 默认的用户之间互发消息，其值是 "user"。如果是 App 管理员下发的消息，是 "admin"
 */
@property  NSString *fromType;

/*!
 * @abstract 消息的内容类型
 * /// 不知道类型的消息
 kJMSGContentTypeUnknown = 0,
 /// 文本消息
 kJMSGContentTypeText = 1,
 /// 图片消息
 kJMSGContentTypeImage = 2,
 /// 语音消息
 kJMSGContentTypeVoice = 3,
 /// 自定义消息
 kJMSGContentTypeCustom = 4,
 /// 事件通知消息。服务器端下发的事件通知，本地展示为这个类型的消息展示出来
 kJMSGContentTypeEventNotification = 5,
 /// 文件消息
 kJMSGContentTypeFile = 6,
 /// 地理位置消息
 kJMSGContentTypeLocation = 7,
 /// 提示性消息
 kJMSGContentTypePrompt = 8,
 /// 视频消息
 kJMSGContentTypeVideo = 9,
 */
@property NSNumber <RLMInt> *contentType;

/*!
 * @abstract 消息内容对象
 * @discussion 使用时应通过 contentType 先获取到具体的消息类型，然后转型到相应的具体类。
 */
@property NSString * content;

/*!
 * @abstract 消息发出的时间戳
 * @discussion 这是服务器端下发消息时的真实时间戳，单位为毫秒
 */
@property NSNumber <RLMInt>*timestamp;

/*!
 * @abstract 消息中的fromName
 * @discussion 消息的发送方展示名称
 */
@property NSString *fromName;


///----------------------------------------------------
/// @name Message addOn fields 消息附加属性
///----------------------------------------------------
/*!
 * @abstract 聊天类型。当前支持的类型：单聊，群聊
 *   /// 单聊
 kJMSGConversationTypeSingle = 1,
 /// 群聊
 kJMSGConversationTypeGroup = 2,
 /// 聊天室
 kJMSGConversationTypeChatRoom = 3,
 */
@property NSNumber <RLMInt> * targetType;

/*!
 * @abstract 消息状态
 * @discussion 一条发出的消息，或者收到的消息，有多个状态会下。具体定义参考 JMSGMessageStatus 的定义。
 *   /// 发送息创建时的初始状态
 kJMSGMessageStatusSendDraft = 0,
 /// 消息正在发送过程中. UI 一般显示进度条
 kJMSGMessageStatusSending = 1,
 /// 媒体类消息文件上传失败
 kJMSGMessageStatusSendUploadFailed = 2,
 /// 媒体类消息文件上传成功
 kJMSGMessageStatusSendUploadSucceed = 3,
 /// 消息发送失败
 kJMSGMessageStatusSendFailed = 4,
 /// 消息发送成功
 kJMSGMessageStatusSendSucceed = 5,
 /// 接收中的消息(还在处理)
 kJMSGMessageStatusReceiving = 6,
 /// 接收消息时自动下载媒体失败
 kJMSGMessageStatusReceiveDownloadFailed = 7,
 /// 接收消息成功
 kJMSGMessageStatusReceiveSucceed = 8,
 /// 消息已被取消发送
 kJMSGMessageStatusCanceledSend = 9,
 */
@property NSNumber <RLMInt> * status;

/*!
 * @abstract 当前的消息是不是收到的。
 * @discussion 是收到的，则是别人发给我的。UI 上一般展示在左侧。
 * 如果不是收到侧的，则是发送侧的，是我对外发送的。
 * 主要是在聊天界面展示消息列表时，需要使用此方法，来确认展示消息的方式与位置。
 * 展示时需要发送方消息，不管是收到侧还是发送侧，都可以使用 fromUser 对象。
 */
@property NSNumber <RLMBool> * isReceived;

/*!
 * @abstract 消息标志
 * @discussion 这是一个用于表示消息状态的标识字段, App 可自由使用, SDK 不做变更.
 * 默认值为 0, App 有需要时可更新此状态.
 * 使用场景:
 * 1. 语音消息有一个未听标志. 默认 0 表示未读, 已读时 App 更新为 1 或者其他.
 * 2. 某些 App 需要对一条消息做送达, 已读标志, 可借用这个字段.
 */
@property NSNumber <RLMInt> * flag;

/*!
 * @abstract 是否已读(只针对接收的消息)
 * @discussion 该属性与实例方法 [-(void)setMessageHaveRead:] 是对应的。
 * 注意：只有发送方调用 [+sendMessage:optionalContent:] 方法设置 message 需要已读回执，此属性才有意义。
 */
@property NSNumber <RLMBool> * isHaveRead;

// 另加的

// 是否是自己发送的
@property NSNumber <RLMBool> *isMeSend;

@property NSData *fromUserAvatar;

@property NSString *type;

@property NSString *belongConversation;

@property NSString *forSearchText;

@end

NS_ASSUME_NONNULL_END
