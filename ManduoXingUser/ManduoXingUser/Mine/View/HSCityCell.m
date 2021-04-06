//
//  HSCityCell.m
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/29.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSCityCell.h"

@implementation HSCityCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = 0;
        [self config];
    }
    
    return self;
}

-(void)config{
    
    [self.contentView addSubview:self.cityNameLbl];
    [self.cityNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(17);
    }];
    
    
}

-(UILabel*)cityNameLbl{
    if (!_cityNameLbl) {
        _cityNameLbl = [UILabel new];
        _cityNameLbl.font = kFont(15);
        
    }
    
    return _cityNameLbl;
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
