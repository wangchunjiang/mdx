//
//  HSLiveChatListCell.h
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/29.
//  Copyright © 2021 wkym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSLiveChatModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HSLiveChatListCell : UITableViewCell
@property(nonatomic,strong)UIView * bgView;
@property(nonatomic,strong)UILabel * nameLbl;
@property(nonatomic,strong)UILabel * contentLbl;
@property(nonatomic,strong)HSLiveChatModel* model;
@end

NS_ASSUME_NONNULL_END
