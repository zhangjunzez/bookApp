//
//  YIAppleLoginManager.m
//  LXVideoPlayer
//
//  Created by 1 on 2019/12/11.
//  Copyright © 2019 Yi. All rights reserved.
//

#import "YIAppleLoginManager.h"

#import <AuthenticationServices/AuthenticationServices.h>
 
API_AVAILABLE(ios(13.0))

@interface YIAppleLoginManager() <ASAuthorizationControllerDelegate,ASAuthorizationCredential>
 
@property (nonatomic, retain) ASAuthorizationController * authorizationController;
@property (nonatomic, copy) GFAppleLoginSuccessBlock successBlock;
@property (nonatomic, copy) GFAppleLoginFailureBlock failureBlock;
 
@end



@implementation YIAppleLoginManager

- (BOOL)enable {
    return !!NSClassFromString(@"ASAuthorizationController");
}
 
+ (instancetype)sharedManager {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
 
- (void)login:(GFAppleLoginSuccessBlock)successBlock error:(GFAppleLoginFailureBlock)failureBlock {
    if (self.enable) {
        self.successBlock = successBlock;
        self.failureBlock = failureBlock;
        [self.authorizationController performRequests];
    }
}
 
#pragma mark - ASAuthorizationControllerDelegate
 
- (void)authorizationController:(ASAuthorizationController *)controller
   didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0)) {
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]])       {
        ASAuthorizationAppleIDCredential * credential = authorization.credential;
        NSString * user = credential.user;
        NSString * authorizationCode = [[NSString alloc] initWithData:credential.authorizationCode encoding:NSUTF8StringEncoding];
        NSString * identityToken = [[NSString alloc] initWithData:credential.identityToken encoding:NSUTF8StringEncoding];
         
        if (self.successBlock) {
            self.successBlock(user, authorizationCode, identityToken);
        }
    }
}
 
- (void)authorizationController:(ASAuthorizationController *)controller
           didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0)) {
    if (self.failureBlock) {
        self.failureBlock(error); // error.code => ASAuthorizationError
    }
}
 
- (ASAuthorizationController *)authorizationController API_AVAILABLE(ios(13.0)) {
    if (_authorizationController == nil) {
        ASAuthorizationAppleIDProvider * provider = [[ASAuthorizationAppleIDProvider alloc] init];
        ASAuthorizationAppleIDRequest * request = [provider createRequest];
        request.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
         
        _authorizationController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[request]];
        _authorizationController.delegate = self;
    }
    return _authorizationController;
}
 



@end
