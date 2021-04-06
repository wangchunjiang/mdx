//
//  HSApplePayManager.h
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/30.
//  Copyright © 2021 wkym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef enum {
    IAPPurchSuccess = 0,//购买成功
    IAPPurchFailed = 1, //购买失败el
    IAPPurchCancel = 2, //取消购买
    IAPPurchVerFailed = 3, //订单校验失败
    IAPPurchVerSuccess = 4, //订单校验成功
    IAPPurchNotArrow = 5, //不允许内购
}IAPPurchType;
typedef void(^IAPCompletionHandleBlock)(IAPPurchType type, NSData *data);

@interface HSApplePayManager : NSObject
+ (instancetype)shareIAPManager;

//添加内购产品
- (void)addPurchWithProductID:(NSString *)product_id completeHandle:(IAPCompletionHandleBlock)handle;
@end

NS_ASSUME_NONNULL_END
