//
//  XSUIObject.h
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/25.
//  Copyright © 2021 wkym. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XSUIObject : NSObject
#pragma mark - 创建View
+(UIView *)creatViewFrame:(CGRect)frame;

#pragma mark 创建imageView
+(UIImageView*)createImageViewFrame:(CGRect)frame imageName:(NSString*)imageName;

#pragma mark 创建label
+(UILabel *)createLabelFrame:(CGRect)frame Text:(NSString*)text font:(UIFont *)font textColor:(UIColor*)color;

#pragma mark 创建button
+(UIButton *)createBtnFrame:(CGRect)frame title:(NSString*)title font:(UIFont *)font textColor:(UIColor*)color imgName:(NSString *)imgName;

/* 创建阿里图片的按钮 */
+(UIButton *)createFontBtnFrame:(CGRect)frame font:(NSInteger)font textColor:(UIColor*)color imgName:(NSString *)imgName;

#pragma mark - 创建UItextfiled
+(UITextField *)creatTFFrame:(CGRect)frame withPlaceholder:(NSString *)placeholder  withplaceholderCol:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
