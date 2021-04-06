//
//  HSSignInApple.h
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/28.
//  Copyright © 2021 wkym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AuthenticationServices/AuthenticationServices.h>
NS_ASSUME_NONNULL_BEGIN

@interface HSSignInApple : NSObject
// 处理授权
- (void)handleAuthorizationAppleIDButtonPress;

// 如果存在iCloud Keychain 凭证或者AppleID 凭证提示用户
- (void)perfomExistingAccountSetupFlows;
@end

NS_ASSUME_NONNULL_END
