//
//  HSOauthLoginView.h
//  HappyLive
//
//  Created by wangchunjiang on 2021/3/29.
//  Copyright © 2021 wkym. All rights reserved.
// 手机号码一键登录

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSOauthLoginView : UIView
@property(nonatomic,strong)UIButton * closeBtn;//返回按钮
@property(nonatomic,strong)UIButton * oauthLoginBtn;//本机号码登录
@property(nonatomic,strong)UIButton * otherLogin;//其他登录
@property(nonatomic,strong)UILabel * phoneLbl;//本机号码
@property (nonatomic , assign) BOOL isSelect;
@end

NS_ASSUME_NONNULL_END
