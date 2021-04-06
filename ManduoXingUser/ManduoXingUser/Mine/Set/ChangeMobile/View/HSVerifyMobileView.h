//
//  HSVerifyMobileView.h
//  ManduoXingUser
//
//  Created by wangchunjiang on 2021/4/2.
//  Copyright © 2021 wkym. All rights reserved.
//  验证手机号

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSVerifyMobileView : UIView
@property(nonatomic,strong)UITextField * phoneFidld;
@property(nonatomic,strong)UITextField * codeField;//
@property(nonatomic,strong)UIButton * confirmBtn;//确定
@end

NS_ASSUME_NONNULL_END
