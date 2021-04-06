//
//  HSOtherLoginView.h
//  HappyLive
//
//  Created by wangchunjiang on 2021/3/27.
//  Copyright © 2021 wkym. All rights reserved.
// 第三方

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol  HSOtherLoginViewDelegate<NSObject>
//服务条款
-(void)pushServiceClause;
//隐私协议
-(void)pushPrivacyPolicy;

@end

@interface HSOtherLoginView : UIView
@property(nonatomic,strong)UIButton * weChatLogin;
@property(nonatomic,strong)UIButton * appleLogin;
@property(nonatomic,strong)UIButton * seletedBtn;//勾选隐私协议
@property(nonatomic,strong)YYLabel *protocolL;//协议L
@property(nonatomic,weak)id <HSOtherLoginViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
