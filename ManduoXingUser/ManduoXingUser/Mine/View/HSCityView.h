//
//  HSCityView.h
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/29.
//  Copyright © 2021 wkym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSCityHeaderView.h"
#import "HSHotyCityTableCell.h"
#import "HSCityModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HSCityView : UIView
@property(nonatomic,strong)UITableView * cityTabView;
@property(nonatomic,strong)HSCityHeaderView * headerView;

-(void)updateDataArray:(NSMutableArray*)dataArr :(NSMutableArray*)hotArray :(NSMutableArray*)sectionTitleArr :(NSMutableArray*)rightIndexArr;
@end

NS_ASSUME_NONNULL_END
