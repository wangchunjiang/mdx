//
//  HSCityHeaderView.m
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/30.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSCityHeaderView.h"


@implementation HSCityHeaderView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    
    return self;
}
-(void)configUI{
    
    [self addSubview:self.locationImg];
    [self addSubview:self.placeLbl];
    [self addSubview:self.resetBtn];
    
    
//    UIView * searchBgView = [UIView new];
//    searchBgView.backgroundColor = Color_f4f4f4;
//    searchBgView.layer.cornerRadius = 20;
//    searchBgView.layer.masksToBounds = YES;
//    [self addSubview:searchBgView];
//    
//    
//    [self addSubview:self.searchField];
//    [self addSubview:self.cancleBtn];
//    
//    UIView * lineView = [UIView new];
//    lineView.backgroundColor = Color_f4f4f4;
//    [self addSubview:lineView];
//    
    
    UILabel * placeTitle = [XSUIObject createLabelFrame:CGRectZero Text:@"当前定位" font:kFont(14) textColor:Color_666];
    [self addSubview:placeTitle];
    
    
    UIView * placeLine = [UIView new];
    placeLine.backgroundColor = Color_f4f4f4;
    [self addSubview:placeLine];
    
 
    
//
//    [searchBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(10);
//        make.left.mas_equalTo(10);
//        make.right.mas_equalTo(-80);
//        make.height.mas_equalTo(40);
//    }];
//
//    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(0);
//        make.top.mas_equalTo(searchBgView.mas_bottom).offset(10);
//        make.height.mas_equalTo(1);
//    }];
//
    
    [placeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(15);
    }];
    
    
//    [self.searchField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(60);
//        make.centerY.mas_equalTo(searchBgView.mas_centerY);
//        make.height.mas_equalTo(30);
//        make.right.mas_equalTo(searchBgView.mas_right);
//    }];
//
//
//
//    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-10);
//        make.centerY.mas_equalTo(searchBgView);
//        make.size.mas_equalTo(CGSizeMake(60, 20));
//    }];
    
    
    
    [self.locationImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(placeTitle.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(30, 20));
    }];
    
    [self.placeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.locationImg.mas_right).offset(10);
        make.centerY.mas_equalTo(self.locationImg);
        make.height.mas_equalTo(15);
    }];
    
    [self.resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.locationImg);
        make.height.mas_equalTo(15);
    }];
    
    
    [placeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.placeLbl.mas_bottom).offset(20);
        make.height.mas_equalTo(10);
    }];
    
    
   
    
}



-(UIImageView *)locationImg{
    if (!_locationImg) {
        _locationImg = [[UIImageView alloc]init];
        
    }
    
    return _locationImg;
}

-(UILabel*)placeLbl{
    if (!_placeLbl) {
        _placeLbl = [UILabel new];
        _placeLbl.text = @"定位中";
    }
    
    return _placeLbl;
}

-(UIButton*)resetBtn{
    if (!_resetBtn) {
        _resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_resetBtn setTitle:@"重新定位" forState:(UIControlStateNormal)];
        [_resetBtn setTitleColor:Color_666 forState:(UIControlStateNormal)];
        _resetBtn.titleLabel.font = kFont(14);
    }
    
    return _resetBtn;
}

//-(UITextField *)searchField{
//
//    if (!_searchField) {
//        _searchField = [XSUIObject creatTFFrame:CGRectZero withPlaceholder:@"输入城市名或者拼音" withplaceholderCol:Color_666];
//    }
//
//    return _searchField;
//
//}
//
//-(UIButton*)cancleBtn{
//    if (!_cancleBtn) {
//        _cancleBtn = [XSUIObject createBtnFrame:CGRectZero title:@"取消" font:kFont(15) textColor:Color_666 imgName:@""];
//    }
//
//    return _cancleBtn;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
