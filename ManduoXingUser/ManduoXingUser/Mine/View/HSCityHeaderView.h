//
//  HSCityHeaderView.h
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/30.
//  Copyright © 2021 wkym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSHotCityCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface HSCityHeaderView : UIView 
@property(nonatomic,strong)UIImageView * locationImg;
@property(nonatomic,strong)UILabel * placeLbl;
@property(nonatomic,strong)UIButton * resetBtn;//重新定位

//@property(nonatomic,strong)UITextField * searchField;//搜索
//@property(nonatomic,strong)UIButton * cancleBtn;//取消
//

@end

NS_ASSUME_NONNULL_END
