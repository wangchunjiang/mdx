//
//  HSBaseShowView.h
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/25.
//  Copyright © 2021 wkym. All rights reserved.
///灰色半透明弹窗基类

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSBaseShowView : UIView<UIGestureRecognizerDelegate>
@property (nonatomic, assign) BOOL bNeedClickDissmiss;//是否需要点击背景dismiss
@property (nonatomic, strong) NSDictionary *dicList;//数据
@property (nonatomic, strong) UIView *view;//需要赋值默认是nil
@property (nonatomic, assign) CGRect frameAnimation;//动画所需起始位置
//点击背景所用方法
- (void)gesureTapBG:(UITapGestureRecognizer *)sender;



//基本属性
@property (nonatomic, strong) UIView *viewBack;
@property (nonatomic, strong) UIButton *btnCancel;
@property (nonatomic, strong) UIButton *btnConfirm;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblDesc;
@property (nonatomic, strong) UILabel *lblTime;
@property (nonatomic, strong) UIImageView *imgViewDisplay;
- (void)show;
- (void)dismiss;
- (void)initView;


- (void)configViewWithModel:(id)model;
@end

NS_ASSUME_NONNULL_END
