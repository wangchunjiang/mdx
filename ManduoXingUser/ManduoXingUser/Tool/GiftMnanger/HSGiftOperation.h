//
//  HSGiftOperation.h
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/27.
//  Copyright © 2021 wkym. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class HSGiftModel,HSGiftShowView;
typedef void(^completeOpBlock)(BOOL finished,NSString *giftKey);
@interface HSGiftOperation : NSOperation

/**
 增加一个操作

 @param giftShowView 礼物显示的View
 @param backView 礼物要显示在的父view
 @param model 礼物的数据
 @param completeBlock 回调操作结束
 @return 操作
 */
+ (instancetype)addOperationWithView:(HSGiftShowView *)giftShowView
                              OnView:(UIView *)backView
                                Info:(HSGiftModel *)model
                       completeBlock:(completeOpBlock)completeBlock;


/** 礼物展示的父view */
@property(nonatomic,strong) UIView *backView;
/** ext */
@property(nonatomic,strong) HSGiftModel *model;
/** block */
@property(nonatomic,copy) completeOpBlock opFinishedBlock;
/** showview */
@property(nonatomic,strong) HSGiftShowView *giftShowView;
@end

NS_ASSUME_NONNULL_END
