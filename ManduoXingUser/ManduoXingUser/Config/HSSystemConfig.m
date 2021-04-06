//
//  HSSystemConfig.m
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/25.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSSystemConfig.h"

static NSString *DebugKey = @"DebugKey";
@implementation HSSystemConfig
+(instancetype)share {
    static HSSystemConfig *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[HSSystemConfig alloc] init];
    });
    return _instance;
}


/**
 *  app主题色
 */
-(UIColor *)appColor{
   
    return UIColorHex(#FD6742);
}
/**
 *  微信key 没有资料请return空字符串
 */
-(NSString *)weChatAppKey{
    return @"wxed207d62d1e6c33b";
}
/**
 *  微信Secret 没有资料请return空字符串
 */
-(NSString *)weChatAppSecret{
    return @"";
}
/**
*  微信通用连链接
*/
-(NSString*)weChatUniversalLink{
    
    return @"https://api.rancll-php.pincll.net";

}
/**
 *  qq分享 qqID 没有资料请return空字符串 有资料则在info 里配置URL Schemes 如 QQ41de8d7c 和 tencent1105104252 两个都必须配置
 */
-(NSString *)qqAppID{
    return @"";
}
/**
 *  qq分享key 没有资料请return空字符串 可以不用填写
 */
-(NSString *)qqAppKey{
    return @"";
}

-(NSString*)txLiveLicenceURL{
    
    return @"";
}

-(NSString*)txLiveLicenceKey{
    
    return @"";
    
}

/**
 高德地图key
 
 */

-(NSString*)aMapKey{
    
    return @"cde6c1886434310d23c6aec1d546999d";
}

/**
 *  app价格颜色
 */
-(UIColor *)appPriceColor{
    return UIColorHex(#ff5000);
}


/**
 *  友盟key
 */
-(NSString *)scUmengAppKey{
    return @"";
}

/**
 *  是否有启动广告
 */
-(BOOL)advertisement{
    return NO;
}
/**
 *  是否引导页  默认没有引导页
 */
-(BOOL)isLead{
    return YES;
}
/**
 *  代码库位置
 */
- (NSString *)codeAddress{
    return @"https://github.com/pincll-outsource-product/manduoxing-user-iOS";
}
/**
 *  域名
 */
- (NSString *)directoryUrl{
    
    return @"";
}

- (BOOL)defineDebug {
#ifdef  DEBUG
    return YES;
#else
    return NO;
#endif
}
@end
