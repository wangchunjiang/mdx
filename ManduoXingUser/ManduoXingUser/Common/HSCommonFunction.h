//
//  HSCommonFunction.h
//  ManduoXingUser
//
//  Created by wangchunjiang on 2021/4/2.
//  Copyright © 2021 wkym. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSCommonFunction : NSObject
/**
 获得当前活动窗口的根视图
 */
+ (UIViewController *)findCurrentShowingViewController;

/**
 退出登录
 */

+(void)loginOut;

/**
 计算字符串宽高
 */
+ (CGSize)sizeText:(NSString*)text font:(UIFont *)font customSize:(CGSize)customSize;

/**
 字符串是否为空
 */
+ (BOOL)isBlankString:(NSString *)string;

/**
 *  验证是否只是数字
 */
+ (BOOL)validateIsOnlyNumber:(NSString *)string;

/**
 *  字典转json 字符串
 */
+(NSString*)dictionaryToJson:(NSDictionary *)dic;

/**
 
 判断是否是手机号
 
 */

+(BOOL)isMobile:(NSString*)str;

/**
 
 去掉字符串空格
 
 */

+(NSString*)spaceFormattingString:(NSString*)str;


/**
 
 手机号匿名 : xxx **** xxxx
 
 */

+(NSString*)anonymousPhoneFormate:(NSString*)str;


@end

NS_ASSUME_NONNULL_END
