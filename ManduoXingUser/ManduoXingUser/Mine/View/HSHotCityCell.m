//
//  HSHotCityCell.m
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/30.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSHotCityCell.h"

@implementation HSHotCityCell
-(instancetype)initWithFrame:(CGRect)frame{

    if (self =[super initWithFrame:frame] ) {
        
        [self configUI];
    }
    
    return self;
}

-(void)configUI{
    
    [self.contentView addSubview:self.hotLbl];
    [self.hotLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
}

-(UILabel*)hotLbl{
    if (!_hotLbl) {
        _hotLbl = [XSUIObject createLabelFrame:CGRectZero Text:@"杭州" font:kFont(14) textColor:Color_666];
        _hotLbl.layer.cornerRadius = 2;
        _hotLbl.layer.masksToBounds = YES;
        _hotLbl.backgroundColor = Color_f4f4f4;
        _hotLbl.textAlignment = NSTextAlignmentCenter;
    }
    
    return _hotLbl;
}
@end
