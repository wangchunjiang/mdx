//
//  HSSearchCityResultView.m
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/30.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSSearchCityResultView.h"
#import "HSCityCell.h"

static NSString * cityResultID= @"HSCityCell";
@implementation HSSearchCityResultView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self configUI];
    }
    
    return self;
}

-(void)configUI{
  

    [self addSubview:self.searchTableView];
    
    
}

-(void)setReslutArray:(NSMutableArray *)reslutArray{
    
    _reslutArray = reslutArray;
    [self.searchTableView reloadData];
    
}


#pragma mark - UITableView的数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
  
    return  self.reslutArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
   
    HSCityCell * cell = [tableView dequeueReusableCellWithIdentifier:cityResultID];
    cell.cityNameLbl.text =self.reslutArray[indexPath.row];
    return cell;
}


-(UITableView*)searchTableView{
    if (!_searchTableView) {
        _searchTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height) style:(UITableViewStylePlain)];
        _searchTableView.sectionIndexColor = [UIColor grayColor];
        _searchTableView.dataSource = self;
        _searchTableView.delegate = self;
        [_searchTableView registerClass:[HSCityCell class] forCellReuseIdentifier:cityResultID];
    
        _searchTableView.estimatedRowHeight = 44;
    }
    
    
    return _searchTableView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
