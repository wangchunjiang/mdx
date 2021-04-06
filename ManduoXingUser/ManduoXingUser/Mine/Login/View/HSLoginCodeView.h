//
//  HSLoginCodeView.h
//  HappyLive
//
//  Created by wangchunjiang on 2021/3/27.
//  Copyright © 2021 wkym. All rights reserved.
//  验证码登录

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSLoginCodeView : UIView
@property(nonatomic,strong)UIButton * closeBtn;//返回按钮
@property(nonatomic,strong)UIButton * loginBtn;//登录
@property(nonatomic,strong)UIButton * otherLogin;//手机号
@property(nonatomic,strong)UITextField * phoneField;//手机输入
@property(nonatomic,strong)UITextField * codeField;//验证码;
@property(nonatomic,strong)UIButton * getCodeBtn;//获取验证码按钮
@end

NS_ASSUME_NONNULL_END
