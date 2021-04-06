//
//  HSCustomButton.h
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/25.
//  Copyright © 2021 wkym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 *  按钮中图片的位置
 */
typedef NS_ENUM(NSUInteger, HSImageAlignment) {
    /**
     *  图片在左，默认
     */
    HSImageAlignmentLeft = 0,
    /**
     *  图片在上
     */
    HSImageAlignmentTop,
    /**
     *  图片在下
     */
    HSImageAlignmentBottom,
    /**
     *  图片在右
     */
    HSImageAlignmentRight,
};
@interface HSCustomButton : UIButton
/**
 *  按钮中图片的位置
 */
@property(nonatomic,assign)HSImageAlignment imageAlignment;
/**
 *  按钮中图片与文字的间距
 */
@property(nonatomic,assign)CGFloat spaceBetweenTitleAndImage;
@end

NS_ASSUME_NONNULL_END
