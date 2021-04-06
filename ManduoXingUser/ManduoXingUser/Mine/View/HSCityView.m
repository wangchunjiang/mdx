//
//  HSCityView.m
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/29.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSCityView.h"
#import "HSCityCell.h"

//#import "HSCityGroupsModel.h"

@interface HSCityView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray * dataArray;//cell数据
@property(nonatomic,strong)NSMutableArray * rightIndexArr;//右侧索引
@property (nonatomic,strong)NSMutableArray *sectionTitlesArray; // 区头数组
@property (nonatomic,strong)NSMutableArray *hotArray; // 热门城市数组
@end
static NSString * cityGroupID = @"HSCityCell";
static NSString * cityHotID = @"HSHotyCityTableCell";
@implementation HSCityView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self configUI];
    }
    
    return self;
}

-(void)configUI{
  
   
//    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//           HSCityGroupsModel *cityModel = [[HSCityGroupsModel alloc] init];
//           [cityModel setValuesForKeysWithDictionary:obj];
//           [self.cityGroupsArray addObject:cityModel];
//       }];
    
    [self addSubview:self.cityTabView];
    
    self.cityTabView.tableHeaderView = self.headerView;
    
  
    
}


-(void)updateDataArray:(NSMutableArray*)dataArr :(NSMutableArray*)hotArray :(NSMutableArray*)sectionTitleArr :(NSMutableArray*)rightIndexArr{
    
    self.dataArray = dataArr;
    self.hotArray = hotArray;
    self.sectionTitlesArray = sectionTitleArr;
    self.rightIndexArr = rightIndexArr;
    [self.cityTabView reloadData];
    
    
}

#pragma mark - UITableView的数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return self.hotArray.count > 0 ? 1:0;;
    }
   
    return  [self.dataArray[section-1] count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    if (indexPath.section == 0) {
        HSHotyCityTableCell * cell = [tableView dequeueReusableCellWithIdentifier:cityHotID forIndexPath:indexPath];
      //  cell.hotArr = @[@"上海市",@"杭州市",@"北京市",@"广州市"].mutableCopy;
        cell.hotArr = self.hotArray;
        return cell;
    }
    HSCityCell * cell = [tableView dequeueReusableCellWithIdentifier:cityGroupID];
 //   HSCityGroupsModel *cityGroupModel = self.cityGroupsArray[indexPath.section-1];
    NSArray *array = self.dataArray[indexPath.section-1];
    cell.cityNameLbl.text =array[indexPath.row];
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

     static NSString *HeaderIdentifier = @"header";
        UITableViewHeaderFooterView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderIdentifier];
         if( headerView == nil)
         {
             headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:HeaderIdentifier];
             UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
             titleLabel.tag = 1;

             titleLabel.textColor = Color_666;

             [headerView addSubview:titleLabel];
         }
       headerView.contentView.backgroundColor = Color_white;
        UILabel *label = (UILabel *)[headerView viewWithTag:1];
    if (section == 0) {

        label.text = @"热门城市";
    }else{
       
             label.text =  self.rightIndexArr[section-1];;
    }
     
        return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 44;
}


- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.rightIndexArr;
}



-(NSMutableArray*)dataArray{
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
 
    return _dataArray;
}
-(NSMutableArray*)rightIndexArr{
    if (!_rightIndexArr) {
        _rightIndexArr = @[].mutableCopy;
    }
    
    return _rightIndexArr;
}
-(NSMutableArray*)sectionTitlesArray{
    if (!_sectionTitlesArray) {
        _sectionTitlesArray = @[].mutableCopy;
    }
    return _sectionTitlesArray;
}
-(NSMutableArray*)hotArray{
    if (!_hotArray) {
        _hotArray = @[].mutableCopy;
    }
    return _hotArray;
}
-(UITableView*)cityTabView{
    if (!_cityTabView) {
        _cityTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height) style:(UITableViewStylePlain)];
        _cityTabView.sectionIndexColor = [UIColor grayColor];
        _cityTabView.dataSource = self;
        _cityTabView.delegate = self;
        [_cityTabView registerClass:[HSCityCell class] forCellReuseIdentifier:cityGroupID];
        [_cityTabView registerClass:[HSHotyCityTableCell class] forCellReuseIdentifier:cityHotID];
        _cityTabView.estimatedRowHeight = 44;
    }
    
    
    return _cityTabView;
}

-(HSCityHeaderView*)headerView{
    if (!_headerView) {
        _headerView = [[HSCityHeaderView alloc]initWithFrame:CGRectMake(0, 0, Screen_width,100)];
       // _headerView.searchField.delegate = self;
    }
    
    return _headerView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
