//
//  HSLiveChatListView.h
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/29.
//  Copyright © 2021 wkym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSLiveChatModel.h"
#import "HSLiveChatListCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface HSLiveChatListView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * chatTableView;
@property(nonatomic,strong)NSMutableArray * sourceArr;
-(void)receiveMsg:(HSLiveChatModel*)model;
@end

NS_ASSUME_NONNULL_END
