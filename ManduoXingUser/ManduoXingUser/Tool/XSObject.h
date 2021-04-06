//
//  XSObject.h
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/25.
//  Copyright © 2021 wkym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
NS_ASSUME_NONNULL_BEGIN

@interface XSObject : NSObject
//验证码按钮点击后 设置文字开始倒计时-->
+(void)setCountDown:(UIButton*)btn;

//MARK默认显示消息-->center
+ (void)showMassage:(NSString *)msg;

//显示消息-->default center
+ (void)showToastAction:(NSString *)message;

//获取阿里图片-->
+(UIImage *)setFontImg:(NSString *)name wFont:(NSInteger)font wColor:(UIColor *)color;

//字典转换为字符串-->
+(NSString*)dictionaryToJson:(NSDictionary *)dic;

//字符串转换为字典-->
+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

#pragma mark - /* 设置渐变色 */
/* 竖着的渐变 */
+(CAGradientLayer *)setChangeColor:(UIColor *)color1 withColor:(UIColor *)color2 withFream:(CGRect)fream;

//横着的渐变
+(CAGradientLayer *)setChangeHorColor:(UIColor *)color1 withColor:(UIColor *)color2 withFream:(CGRect)fream;

//MARK:-划圆角
+(CAShapeLayer *)creatCornerRatioWithView:(UIView *)subView  withOne:(UIRectCorner)temp1 withTwo:(UIRectCorner)temp2 withSize:(CGSize)size;

//MARK:-字典转字符串
+(NSString *)convertToJsonData:(NSDictionary *)dict;

//MARK:-MD5加密
/*
*由于MD5加密是不可逆的,多用来进行验证
*/
// 32位小写
+(NSString *)MD5ForLower32Bate:(NSString *)str;
// 32位大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str;
// 16为大写
+(NSString *)MD5ForUpper16Bate:(NSString *)str;
// 16位小写
+(NSString *)MD5ForLower16Bate:(NSString *)str;

//MARK:-项目生成id_str
+(NSString *)getId_strWithArray:(NSArray *)array;

/*改变电话号码的格式344*/
+(NSString *)changPhoneNum:(NSString *)phoneNum;

/*把改变格式的手机号码的格式改回正常字符串*/
+(NSString *)changBackPhoneNum:(NSString *)phoneNum;

/** 解析成html的富文本 */
+ (NSAttributedString *)attrHtmlStringFrom:(NSString *)str;

/*生成二维码*/
+(UIImage *)createNonInterpolatedUIImageForUrl:(NSString *)url withSize:(CGFloat)size;

//界面截图
+(UIImage*)screenSnapshot:(UIView *)view;
//手机号码格式化 344
+(NSString*)mobileFormate:(NSString*)phoneNum;

//价格处理
+(NSString*)priceFromate:(NSString*)price;
//匿名处理
+(NSString*)anonymousFormate:(NSString*)str;


@end

NS_ASSUME_NONNULL_END
