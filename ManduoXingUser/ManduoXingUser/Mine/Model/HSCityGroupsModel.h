//
//  HSCityGroupsModel.h
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/29.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HSCityGroupsModel : HSBaseModel
/** 城市数组*/
@property (nonatomic, strong) NSArray *cities;

/** 分类标题*/
@property (nonatomic, copy) NSString *title;
@end

NS_ASSUME_NONNULL_END
