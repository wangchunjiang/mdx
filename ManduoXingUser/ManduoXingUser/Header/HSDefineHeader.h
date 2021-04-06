//
//  HSDefineHeader.h
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/25.
//  Copyright © 2021 wkym. All rights reserved.
//

#ifndef HSDefineHeader_h
#define HSDefineHeader_h



#define KKeyWindow  [UIApplication sharedApplication].keyWindow

#define Screen_width [UIScreen mainScreen].bounds.size.width
#define Screen_height [UIScreen mainScreen].bounds.size.height

#define kFont(font)        [UIFont systemFontOfSize:(font* RatioW)]
#define kBFont(font)       [UIFont boldSystemFontOfSize:(font* RatioW)]
#define kFontMedium(font)  [UIFont systemFontOfSize:(font * RatioW) weight:UIFontWeightMedium]


//CGRect
#define RatioW Screen_width / 375.0
#define RatioH Screen_height /812.0

/* 有小数点 */
#define RatioNumW(num) (num * (Screen_width/375.0))
#define RatioNumH(num) (num * (Screen_height/812.0))


// 导航栏
#define Status_height [[UIApplication sharedApplication] statusBarFrame].size.height
#define Status_heightNomal (Status_height > 20 ? 44 : 20)
#define XSNavBarHeight 44.0
#define Navi_heightAll (Status_height > 20 ? 88 : 64)
#define Tabbar_heightAll (Status_height > 20 ? 83 : 49)
#define Tabbar_heightMargen (Status_height > 20 ? 34 : 0)
#define Navi_heightMargen (Status_height > 20 ? 24 : 0)
#define Navi_heightNomal 64
#define Tabbar_heightNomal 49


#define NetFailUpToken @"Token过期，请刷新Token"
#define NetFailOutLogin @"登录过期，请重新登录"


#define APPDELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define PlaceHolderImage  [UIImage imageNamed:@"placeHolderImg"]
#define HSSetImage(imageName) [UIImage imageNamed:imageName]



#ifdef DEBUG
#define  NSLog(FORMAT, ...) fprintf(stderr, "%s:%zd\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);

#else
#define NSLog(FORMAT, ...) nil
#endif


#endif /* HSDefineHeader_h */
