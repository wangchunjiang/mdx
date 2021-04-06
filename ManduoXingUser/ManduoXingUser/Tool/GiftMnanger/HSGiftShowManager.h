//
//  HSGiftShowManager.h
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/27.
//  Copyright © 2021 wkym. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class HSGiftModel;
typedef void(^completeBlock)(BOOL finished);
typedef void(^completeShowGifImageBlock)(HSGiftModel *giftModel);

@interface HSGiftShowManager : NSObject
+ (instancetype)sharedManager;
/**
 送礼物(不处理第一次展示当前礼物逻辑)
 
 @param backView 礼物动效展示父view
 @param giftModel 礼物的数据
 @param completeBlock 展示完毕回调
 */

- (void)showGiftViewWithBackView:(UIView *)backView
                            info:(HSGiftModel *)giftModel
                   completeBlock:(completeBlock)completeBlock;

/**
 送礼物(回调第一次展示当前礼物的逻辑)

 @param backView 礼物动效展示父view
 @param giftModel 礼物的数据
 @param completeBlock 展示完毕回调
 @param completeShowGifImageBlock 第一次展示当前礼物的回调(为了显示gif)
 */
- (void)showGiftViewWithBackView:(UIView *)backView
                            info:(HSGiftModel *)giftModel
                   completeBlock:(completeBlock)completeBlock
       completeShowGifImageBlock:(completeShowGifImageBlock)completeShowGifImageBlock;
@end

NS_ASSUME_NONNULL_END
