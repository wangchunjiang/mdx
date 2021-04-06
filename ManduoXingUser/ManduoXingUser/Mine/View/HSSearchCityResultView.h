//
//  HSSearchCityResultView.h
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/30.
//  Copyright © 2021 wkym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSSearchCityResultView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * searchTableView;
@property(nonatomic,strong)NSMutableArray * reslutArray;
@end

NS_ASSUME_NONNULL_END
