//
//  HSLoginCodeView.m
//  HappyLive
//
//  Created by wangchunjiang on 2021/3/27.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSLoginCodeView.h"
@interface HSLoginCodeView()
@property(nonatomic,strong)UIImageView * Logo;
@property(nonatomic,strong)UILabel * titleLbl ;
@property(nonatomic,strong)UIImageView * phoneImg;
@property(nonatomic,strong)UIImageView * codeImg;


@end
@implementation HSLoginCodeView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = Color_white;
        [self configUI];
    }
    
    return self;
}

-(void)configUI{
    [self addSubview:self.closeBtn];
    [self addSubview:self.Logo];
    [self addSubview:self.titleLbl];
    [self addSubview:self.phoneImg];
    [self addSubview:self.phoneField];
    [self addSubview:self.codeImg];
    [self addSubview:self.codeField];
    [self addSubview:self.getCodeBtn];
    [self addSubview:self.loginBtn];
    [self addSubview:self.otherLogin];
    
    UIView * phoneLine = [UIView new];
    phoneLine.backgroundColor = Color_Line;
    [self addSubview:phoneLine];
    
    UIView * codeLine = [UIView new];
    codeLine.backgroundColor = Color_Line;
    [self addSubview:codeLine];
    
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Status_heightNomal+RatioNumH(12));
        make.left.mas_equalTo(RatioNumW(16));
        make.size.mas_equalTo(CGSizeMake(RatioNumH(20), RatioNumH(20)));
    }];
    
    
    [self.Logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.closeBtn.mas_bottom).offset(RatioNumH(20));
        make.size.mas_equalTo(CGSizeMake(RatioNumH(88),RatioNumH(88)));
        
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.Logo.mas_bottom).offset(RatioNumH(20));
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(RatioNumH(20));
    }];
    
    [self.phoneImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(RatioNumW(30));
        make.top.mas_equalTo(self.titleLbl.mas_bottom).offset(RatioNumH(58));
        make.size.mas_equalTo(CGSizeMake(RatioNumW(16), RatioNumH(20)));
        
    }];
    
    
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.phoneImg.mas_right).offset(RatioNumW(10));
        make.centerY.mas_equalTo(self.phoneImg.mas_centerY);
        make.right.mas_equalTo(-RatioNumW(30));
        make.height.mas_equalTo(RatioNumH(20));
        
    }];
    
    [phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneField.mas_bottom).offset(RatioNumH(6));
        make.left.mas_equalTo(self.phoneImg.mas_left);
        make.right.mas_equalTo(self.phoneField.mas_right);
        make.height.mas_equalTo(RatioNumH(0.5));
    }];
    
    
    [self.codeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneLine.mas_bottom).offset(RatioNumH(30));
        make.left.mas_equalTo(self.phoneImg.mas_left);
        make.size.mas_equalTo(CGSizeMake(RatioNumW(16), RatioNumH(20)));
        
    }];
    
    [self.codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.codeImg.mas_right).offset(RatioNumW(10));
        make.centerY.mas_equalTo(self.codeImg.mas_centerY);
        make.right.mas_equalTo(self.getCodeBtn.mas_left).offset(-RatioNumW(10));
        make.height.mas_equalTo(RatioNumH(20));
    }];
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-RatioNumW(28));
        make.centerY.mas_equalTo(self.codeField.mas_centerY);
        make.width.mas_equalTo(RatioNumW(85));
        make.height.mas_equalTo(RatioNumH(20));
       // make.left.mas_equalTo(self.codeField.mas_right).offset(RatioNumW(10));
    }];
    
    
    [codeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeImg.mas_bottom).offset(RatioNumH(6));
        make.left.mas_equalTo(self.codeImg.mas_left);
        make.right.mas_equalTo(self.getCodeBtn.mas_right);
        make.height.mas_equalTo(RatioNumH(0.5));
    }];
    
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(codeLine.mas_bottom).offset(RatioNumH(30));
        make.left.mas_equalTo(RatioNumW(16));
        make.right.mas_equalTo(RatioNumW(-16));
        make.height.mas_equalTo(RatioNumH(40));
    }];
    
    [self.otherLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginBtn.mas_bottom).offset(RatioNumH(20));
        make.left.mas_equalTo(self.loginBtn.mas_left);
        make.right.mas_equalTo(self.loginBtn.mas_right);
        make.height.mas_equalTo(self.loginBtn.mas_height);
    }];
    
    
    
    
}

-(UIButton*)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [XSUIObject createFontBtnFrame:CGRectZero font:20 textColor:Color_333 imgName:@"\U0000e627"];
        
    }
    
    return _closeBtn;
    
}

-(UIImageView*)Logo{
    if (!_Logo) {
        _Logo = [XSUIObject createImageViewFrame:CGRectZero imageName:@"Logo"];
    }
    
    return _Logo;
    
}

-(UILabel*)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [XSUIObject createLabelFrame:CGRectZero Text:@"相约明星名家上蛮多星" font:kFont(16) textColor:Color_3030];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
    }
    
    return _titleLbl;
}

-(UIImageView*)phoneImg{
    if (!_phoneImg) {
        _phoneImg = [XSUIObject createImageViewFrame:CGRectZero imageName:@""];
        _phoneImg.image = [XSObject setFontImg:@"\U0000e71f" wFont:16 wColor:Color_000];
    }
    
    return _phoneImg;
    
}
-(UITextField*)phoneField{
    if (!_phoneField) {
        _phoneField = [XSUIObject creatTFFrame:CGRectZero withPlaceholder:@"输入手机号" withplaceholderCol:Color_999];
        _phoneField.text = @"18238770746";
    }
    return _phoneField;
    
}

-(UIImageView*)codeImg{
    if (!_codeImg) {
        _codeImg = [XSUIObject createImageViewFrame:CGRectZero imageName:@""];
        _codeImg.image = [XSObject setFontImg:@"\U0000e619" wFont:16 wColor:Color_000];
    }
    
    return _codeImg;
}

-(UITextField*)codeField{
    if (!_codeField) {
        _codeField = [XSUIObject creatTFFrame:CGRectZero withPlaceholder:@"输入验证码" withplaceholderCol:Color_999];
        _codeField.text = @"123456";
    }
    return _codeField;
    
}
-(UIButton*)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [XSUIObject createBtnFrame:CGRectZero title:@"登录" font:kFont(14) textColor:Color_white imgName:@""];
        _loginBtn.layer.cornerRadius = RatioNumH(20);
        _loginBtn.clipsToBounds = YES;
        _loginBtn.backgroundColor = ThemeColor;
    }
    
    return _loginBtn;
}

-(UIButton*)otherLogin{
    if (!_otherLogin) {
        _otherLogin = [XSUIObject createBtnFrame:CGRectZero title:@"使用手机号一建登录" font:kFont(14) textColor:Color_3030 imgName:@""];
        _otherLogin.layer.cornerRadius = RatioNumH(20);
        _otherLogin.clipsToBounds = YES;
        _otherLogin.backgroundColor = Color_f4f4f4;
    }
    
    return _otherLogin;
}

-(UIButton*)getCodeBtn{
    if (!_getCodeBtn) {
        _getCodeBtn = [XSUIObject createBtnFrame:CGRectZero title:@"获取验证码" font:kFont(14) textColor:UIColor.orangeColor imgName:@""];
        _getCodeBtn.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
    }
    
    
    return _getCodeBtn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
