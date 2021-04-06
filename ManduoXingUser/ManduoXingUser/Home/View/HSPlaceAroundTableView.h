//
//  HSPlaceAroundTableView.h
//  ManduoXingUser
//
//  Created by 王春江 on 2021/2/2.
//  Copyright © 2021 wkym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapView.h>
#import <AMapSearchKit/AMapSearchKit.h>
NS_ASSUME_NONNULL_BEGIN
@protocol HSPlaceAroundTableViewDeleagate <NSObject>

- (void)didTableViewSelectedChanged:(AMapPOI *)selectedPoi;

- (void)didLoadMorePOIButtonTapped;

- (void)didPositionCellTapped;

-(void)updateVCTiele:(AMapReGeocode*)regeo;



@end
@interface HSPlaceAroundTableView : UIView<UITableViewDataSource, UITableViewDelegate, AMapSearchDelegate>
@property (nonatomic, weak) id<HSPlaceAroundTableViewDeleagate> delegate;

@property (nonatomic, copy) NSString *currentAddress;

@property (nonatomic, strong) UIButton * searchBtn;

- (instancetype)initWithFrame:(CGRect)frame;

- (AMapPOI *)selectedTableViewCellPoi;
@end

NS_ASSUME_NONNULL_END
