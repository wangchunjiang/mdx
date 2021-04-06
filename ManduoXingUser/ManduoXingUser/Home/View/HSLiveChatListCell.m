//
//  HSLiveChatListCell.m
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/29.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSLiveChatListCell.h"

@implementation HSLiveChatListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = 0;
        self.backgroundColor = [UIColor clearColor];
        [self configUI];
    }
    
    return self;
}
-(void)configUI{
    
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.nameLbl];
    [self.bgView addSubview:self.contentLbl];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
        make.right.mas_equalTo(-10);
    }];
    
    
    [self.nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.mas_equalTo(5);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(40);
        
    }];
  //  self.contentLbl.preferredMaxLayoutWidth = Screen_width/2-32;
    [self.contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLbl.mas_right);
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
        make.right.mas_equalTo(-5);
        make.height.mas_equalTo(5);
        
    }];
    
    
}

-(void)setModel:(HSLiveChatModel *)model{
    
    CGFloat w = [HSCommonFunction sizeText:model.name font:kFont(14) customSize:CGSizeMake(Screen_width, 15)].width;
    
    [self.nameLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(w);
    }];
    
    
    CGFloat h = [HSCommonFunction sizeText:model.content font:kFont(14) customSize:CGSizeMake(Screen_width-w-30,MAXFLOAT)].height;
    
    
    NSLog(@"h=====%f",h);
    
    self.nameLbl.text = model.name;
    self.contentLbl.text = model.content;
    
    [self.contentLbl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(h);
    }];
    
    
    
    
}



-(UIView*)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor grayColor];
    }
    
    return _bgView;
}
-(UILabel*)nameLbl{
    if (!_nameLbl) {
        _nameLbl = [UILabel new];
        _nameLbl.font = kFont(14);
        
    }
    
    return _nameLbl;
}

-(UILabel*)contentLbl{
    if (!_contentLbl) {
        _contentLbl = [UILabel new];
       // _contentLbl.backgroundColor = UIColor.redColor;
        _contentLbl.numberOfLines = 0;
        [_contentLbl sizeToFit];
        _contentLbl.font = kFont(14);
    }
    return _contentLbl;
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
