//
//  HSSearchPlaceVC.h
//  ManduoXingUser
//
//  Created by 王春江 on 2021/2/2.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSBaseViewController.h"
#import "POIAnnotation.h"
#import "AMapTipAnnotation.h"
NS_ASSUME_NONNULL_BEGIN

@protocol HSSearchPlaceVCDelegate<NSObject>

-(void)selectPlace:(AMapTipAnnotation*)annotation;

@end

@interface HSSearchPlaceVC : HSBaseViewController
@property(nonatomic,strong)NSString * currentCity;//当前城市
@property(nonatomic,weak) id <HSSearchPlaceVCDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
