//
//  HSSearchNavView.m
//  ManduoXingUser
//
//  Created by 王春江 on 2021/2/2.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSSearchNavView.h"

@implementation HSSearchNavView
-(instancetype)initWithFrame:(CGRect)frame{
    
    self =  [super initWithFrame:frame];

    
    [self configUI];
    
    return self;
}


//MARK:-绘制视图
-(void)configUI{
    
    UIView *bgView = [XSUIObject creatViewFrame:CGRectMake(0, 0, self.width, self.height)];
    bgView.backgroundColor = Color_white;
    [self addSubview:bgView];

    UIButton *backBtn = [XSUIObject createFontBtnFrame:CGRectMake(0,Navi_heightAll/2- Status_height/2  , RatioNumW(50), 40)  font:20 textColor:Color_000 imgName:@"\U0000e779"];
    [self addSubview:backBtn];
    self.backBtn = backBtn;
    
    
    UIView * searchBgView = [UIView new];
    searchBgView.backgroundColor = Color_f4f4f4;
    searchBgView.layer.cornerRadius = 5;
    searchBgView.layer.masksToBounds = YES;
    [self addSubview:searchBgView];
    
    UITextField * searchField = [XSUIObject creatTFFrame:CGRectZero withPlaceholder:@"搜索地点" withplaceholderCol:Color_666];
    searchField.returnKeyType =  UIReturnKeySearch;
    searchField.clearButtonMode =  UITextFieldViewModeWhileEditing;
    searchField.backgroundColor = Color_f4f4f4;
    [self addSubview:searchField];
    
    self.searchField = searchField;
    
    
    [searchBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backBtn.mas_right).offset(5);
        make.centerY.mas_equalTo(backBtn);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(30);
    }];
   
    
   
      [searchField mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.mas_equalTo(searchBgView.mas_left).offset(15);
          make.centerY.mas_equalTo(backBtn);
          make.right.mas_equalTo(searchBgView).offset(-5);
          make.height.mas_equalTo(30);
      }];
     
  
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
