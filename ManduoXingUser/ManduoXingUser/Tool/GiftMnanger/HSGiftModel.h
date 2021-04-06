//
//  HSGiftModel.h
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/27.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HSGiftModel : HSBaseModel

/** usericon */
@property(nonatomic,copy)NSString *userIcon;
/** username */
@property(nonatomic,copy)NSString *userName;
/** giftname */
@property(nonatomic,copy)NSString *giftName;
/** giftimage */
@property(nonatomic,copy)NSString *giftImage;
/** gift gifimage */
@property(nonatomic,copy)NSString *giftGifImage;
/** count */
@property(nonatomic,assign) NSInteger defaultCount; //0
/** 发送的数 */
@property(nonatomic,assign) NSInteger sendCount;
/** 礼物ID */
@property(nonatomic,copy)NSString *giftId;
/** 礼物操作的唯一Key */
@property(nonatomic,copy)NSString *giftKey;
@end

NS_ASSUME_NONNULL_END
