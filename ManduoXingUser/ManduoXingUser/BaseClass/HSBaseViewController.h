//
//  HSBaseViewController.h
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/25.
//  Copyright © 2021 wkym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSBaseViewController : UIViewController



/// 左上返回框是否需要显示
@property (nonatomic, assign)BOOL hiddenBack;

/// 空数据时，占位空视图
@property (nonatomic, strong)HSEmptyView *emptyView;


/// 返回方法
- (void)wj_goBack;

/// 默认设置 图片 130*130、图文间距 15、文字按钮间距 30
/// 展示无数据视图，移除界面数据视图
- (void)showEmplyView:(CGRect)rect imgName:(NSString *)imgName title:(NSString *)title buttonTitle:(NSString *)buttonTitle removeDataView:(UIView *)view;

/// 移除 emptyView
- (void)removeEmplyView;

/// 关闭右滑返回
- (void)cancelGestureForBack;

/// 开启右滑返回
- (void)openGestureForBack;

//显示导航栏
-(void)showCustomNavBar;

//隐藏导航
-(void)hiddenCustomNavBar;

/// 获取当前可用 VC
- (UIViewController *)curViewController;

-(void)addRightBarButtonItem:(NSString *)title;

-(void)rightBarButtonItemAction:(UIButton *)item;
@end

NS_ASSUME_NONNULL_END
