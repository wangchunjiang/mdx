//
//  HSHotyCityTableCell.m
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/30.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSHotyCityTableCell.h"

static NSString * hotCellID = @"HSHotCityCell";
@implementation HSHotyCityTableCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = 0;
        [self config];
    }
    
    return self;
}

-(void)config{
     
[self.contentView addSubview:self.hotCollectionView];
     
  [self.hotCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(10);
         make.left.mas_equalTo(30);
         make.right.mas_equalTo(-30);
         make.height.mas_equalTo(100);
      make.bottom.mas_equalTo(-10);
     }];
    
}
-(void)setHotArr:(NSMutableArray *)hotArr{
    _hotArr = hotArr;
    [self.hotCollectionView reloadData];
    [self.hotCollectionView  layoutIfNeeded];
    
    CGFloat hotH = self.hotCollectionView.collectionViewLayout.collectionViewContentSize.height;

    NSLog(@"hotH====%f",hotH);
    
    [self.hotCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(hotH);
    }];
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    
    return self.hotArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HSHotCityCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:hotCellID forIndexPath:indexPath];
    cell.hotLbl.text = self.hotArr[indexPath.row];
    
    return cell;
    
}


-(UICollectionView*)hotCollectionView{
    
    if (!_hotCollectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 0;
        CGFloat itemW = (Screen_width-60)/3-10;
        layout.itemSize = CGSizeMake(itemW, 40);
        _hotCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _hotCollectionView.backgroundColor = Color_white;
        _hotCollectionView.delegate = self;
        _hotCollectionView.dataSource = self;
        [_hotCollectionView registerClass:[HSHotCityCell class] forCellWithReuseIdentifier:hotCellID];
        
    }
    
    
    return _hotCollectionView;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
