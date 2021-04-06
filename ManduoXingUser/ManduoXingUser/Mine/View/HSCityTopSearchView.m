//
//  HSCityTopSearchView.m
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/30.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSCityTopSearchView.h"

@implementation HSCityTopSearchView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    
    return self;
}
-(void)configUI{
    
   
    UIView * searchBgView = [UIView new];
    searchBgView.backgroundColor = Color_f4f4f4;
    searchBgView.layer.cornerRadius = 20;
    searchBgView.layer.masksToBounds = YES;
    [self addSubview:searchBgView];
    
    
    [self addSubview:self.searchField];
    [self addSubview:self.cancleBtn];
    
    UIView * lineView = [UIView new];
    lineView.backgroundColor = Color_f4f4f4;
    [self addSubview:lineView];
    
  
    
    
    [searchBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-80);
        make.height.mas_equalTo(40);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(searchBgView.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
    }];
    
    
   
    [self.searchField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(60);
        make.centerY.mas_equalTo(searchBgView.mas_centerY);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(searchBgView.mas_right);
    }];
    
    
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(searchBgView);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
  
    
}


-(UITextField *)searchField{
    
    if (!_searchField) {
        _searchField = [XSUIObject creatTFFrame:CGRectZero withPlaceholder:@"输入城市名或者拼音" withplaceholderCol:Color_666];
    }
    
    return _searchField;
    
}

-(UIButton*)cancleBtn{
    if (!_cancleBtn) {
        _cancleBtn = [XSUIObject createBtnFrame:CGRectZero title:@"取消" font:kFont(15) textColor:Color_666 imgName:@""];
    }
    
    return _cancleBtn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
