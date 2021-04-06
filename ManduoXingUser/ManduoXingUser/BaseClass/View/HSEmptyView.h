//
//  HSEmptyView.h
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/25.
//  Copyright © 2021 wkym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^HSEmptyButtonBlock)(void);
@interface HSEmptyView : UIView
/// 图片距离顶部间距
@property (nonatomic, assign)CGFloat iconToTop;

/// 图文间距
@property (nonatomic, assign)CGFloat iconToText;

/// 文字 按钮间距
@property (nonatomic, assign)CGFloat textToButton;

/// 按钮大小
@property (nonatomic, assign)CGSize buttonSize;


/// 空文字
@property(nonatomic,strong)UILabel *emptyLabel;

/// 空图片
@property(nonatomic,strong)UIImageView *emptyImageView;

/// 底部按钮
@property(nonatomic,strong)UIButton *emptyButton;

/// 按钮点击回调
@property(nonatomic,copy)HSEmptyButtonBlock emptyButtonBlock;




#pragma mark  -----  以下两个初始化方法，可直接生成可用的空数据视图（最初小姐姐就是这么写的保留下来了）

/**
 创建空页面

 @param frame 空页面位置大小
 @param imageViewTop 顶部图片距顶部距离
 @param imageViewSize 图片大小
 @param imageName 图片名称
 @param labelTop 文字距图片位置大小
 @param labelText 提示文字
 @param buttonTop 按钮距顶部大小
 @param buttonSize 按钮大小
 */
- (instancetype)initWithFrame:(CGRect)frame imageViewTop:(CGFloat)imageViewTop imageViewSize:(CGSize)imageViewSize imageName:(NSString *)imageName labelTop:(CGFloat)labelTop labelText:(NSString *)labelText buttonTop:(CGFloat)buttonTop buttonSize:(CGSize)buttonSize buttonTitle:(NSString *)buttonTitle;

/// 不带按钮的空背景
- (instancetype)initWithFrame:(CGRect)frame imageViewTop:(CGFloat)imageViewTop imageViewSize:(CGSize)imageViewSize imageName:(NSString *)imageName labelTop:(CGFloat)labelTop labelText:(NSString *)labelText;
@end

NS_ASSUME_NONNULL_END
