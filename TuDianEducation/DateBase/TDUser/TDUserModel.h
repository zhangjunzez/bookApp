//
//  TDUserModel.h
//  TuDianEducation
//
//  Created by zpz on 2020/4/21.
//  Copyright © 2020 郑州大點哥. All rights reserved.
//

#import "RLMObject.h"
/*
{
       "id": 12,
       "nickname": null,
       "password": "41fa3d236063945b7429417e52a5d580",
       "phone": "17803839848",
       "email": null,
       "wxNum": null,
       "zfbNum": null,
       "headUrl": null,
       "balance": 0,
       "type": 0,
       "cashPassword": null,
       "referralCode": "Liy1",
       "provinceCode": null,
       "cityCode": null,
       "districtCode": null,
       "createTime": 1585640217000,
       "updateTime": 1585640217000,
       "birthday": null,
       "signDays": 0,
       "score": 0,
       "locK": 0,
       "loginTime": 1585634430000,
       "isDelete": 0
}
 
 */


NS_ASSUME_NONNULL_BEGIN

@interface TDUserModel : RLMObject

@property NSString *id;

///用户名
@property NSString *nickname;

///用户头像
@property NSData *userHeadData;

///用户头像url
@property NSString *headUrl;

///用户手机号
@property NSString *phone;

///用户是否设置交易密码
@property BOOL hasTradersPwd;

///用户类型
@property NSString *type;

@end

NS_ASSUME_NONNULL_END
