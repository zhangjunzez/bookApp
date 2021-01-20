//
//  YIAppleLoginManager.h
//  LXVideoPlayer
//
//  Created by 1 on 2019/12/11.
//  Copyright © 2019 Yi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^GFAppleLoginSuccessBlock)(NSString * userId, NSString * authCode, NSString * identityToken);
typedef void (^GFAppleLoginFailureBlock)(NSError * error);


@interface YIAppleLoginManager : NSObject

@property (nonatomic, assign, readonly) BOOL enable;
 
+ (instancetype)sharedManager;

- (void)login:(GFAppleLoginSuccessBlock)successBlock error:(GFAppleLoginFailureBlock)failureBlock;

@end

NS_ASSUME_NONNULL_END
