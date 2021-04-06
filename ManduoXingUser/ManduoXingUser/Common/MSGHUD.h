//
//  MSGHUD.h
//  ManduoXingUser
//
//  Created by wangchunjiang on 2021/4/2.
//  Copyright © 2021 wkym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Toast/Toast.h>
NS_ASSUME_NONNULL_BEGIN

@interface MSGHUD : NSObject
+(void)showToast:(NSString *)msg;
@end

NS_ASSUME_NONNULL_END
