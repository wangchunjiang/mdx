//
//  HSSystemConfig.h
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/25.
//  Copyright © 2021 wkym. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSSystemConfig : NSObject
+(instancetype)share;


@property (nonatomic, copy) NSString *directoryUrl;

@property (nonatomic, copy) NSString *weChatAppKey;//微信key
@property (nonatomic, copy) NSString *weChatAppSecret;
@property (nonatomic, copy) NSString *weChatUniversalLink;//微信通用链接
@property (nonatomic, copy) NSString *qqAppID;
@property (nonatomic, copy) NSString *qqAppKey;


@property (nonatomic, copy) NSString * txLiveLicenceURL;//直播licence
@property (nonatomic, copy) NSString * txLiveLicenceKey;//直播licence

@property (nonatomic, copy) NSString * aMapKey;//高德地图key

@property (nonatomic, assign) BOOL isLead;//是否有引导页

@property (nonatomic, copy) NSString *codeAddress;//代码库

@property (nonatomic, strong) UIColor *appColor;//主题色

@property (nonatomic, strong) UIColor *appPriceColor;



@end

NS_ASSUME_NONNULL_END
