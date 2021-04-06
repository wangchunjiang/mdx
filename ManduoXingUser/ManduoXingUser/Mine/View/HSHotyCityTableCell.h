//
//  HSHotyCityTableCell.h
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/30.
//  Copyright © 2021 wkym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSHotCityCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface HSHotyCityTableCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView * hotCollectionView;//热门城市
@property(nonatomic,strong)NSMutableArray * hotArr;
@end

NS_ASSUME_NONNULL_END
