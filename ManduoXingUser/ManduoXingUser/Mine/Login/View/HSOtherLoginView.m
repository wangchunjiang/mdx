//
//  HSOtherLoginView.m
//  HappyLive
//
//  Created by wangchunjiang on 2021/3/27.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSOtherLoginView.h"
@interface HSOtherLoginView ()
@property(nonatomic,strong)UILabel * titleLbl;
@end
@implementation HSOtherLoginView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self configUI];
    }
    
    return self;
    
}

-(void)configUI{
    
    [self addSubview:self.titleLbl];
    [self addSubview:self.weChatLogin];
    [self addSubview:self.appleLogin];
    [self addSubview:self.protocolL];
    [self addSubview:self.seletedBtn];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(RatioNumH(18));
    }];
    
    [self.weChatLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_centerX).offset(-RatioNumW(50));
        make.top.mas_equalTo(self.titleLbl.mas_bottom).offset(RatioNumH(30));
        make.size.mas_equalTo(CGSizeMake(RatioNumW(55), RatioNumW(55)));
    }];
    
    [self.appleLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_centerX).offset(RatioNumW(50));
        make.top.mas_equalTo(self.titleLbl.mas_bottom).offset(RatioNumH(30));
        make.size.mas_equalTo(CGSizeMake(RatioNumW(55), RatioNumW(55)));
    }];

    
    [self.protocolL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.appleLogin.mas_bottom).offset(RatioNumH(37));
        make.left.mas_equalTo(self.seletedBtn.mas_right).offset(RatioNumW(5));
        make.right.mas_equalTo(RatioNumW(-16));
        make.height.mas_equalTo(RatioNumH(18));
    }];

    [self.seletedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(RatioNumW(16));
     //   make.top.mas_equalTo(self.protocolL.mas_top).offset(RatioNumH(0));
        make.centerY.mas_equalTo(self.protocolL.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(RatioNumW(25), RatioNumH(25)));
        
    }];
}




-(UILabel*)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [XSUIObject createLabelFrame:CGRectZero Text:@"其他登录方式" font:kFont(12) textColor:Color_3030];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
    }
    
    return _titleLbl;
    
}
-(UIButton*)weChatLogin{
    if (!_weChatLogin) {
        _weChatLogin = [XSUIObject createFontBtnFrame:CGRectZero font:25 textColor:UIColorHex(#24DB5A) imgName:@"\U0000e620"];
        _weChatLogin.layer.borderWidth = 1;
        _weChatLogin.layer.borderColor = Color_Line.CGColor;
        _weChatLogin.layer.cornerRadius = RatioNumW(27.5);
        _weChatLogin.clipsToBounds = YES;
    }
    
    return _weChatLogin;
}

-(UIButton*)appleLogin{
    if (!_appleLogin) {
        _appleLogin = [XSUIObject createFontBtnFrame:CGRectZero font:25 textColor:UIColorHex(#2C2C2C) imgName:@"\U0000e614"];
        _appleLogin.layer.borderWidth = 1;
        _appleLogin.layer.borderColor = Color_Line.CGColor;
        _appleLogin.layer.cornerRadius = RatioNumW(27.5);
        _appleLogin.clipsToBounds = YES;
        
    }
    
    return _appleLogin;
}
-(UIButton*)seletedBtn{
    
    if (!_seletedBtn) {
        _seletedBtn = [XSUIObject createFontBtnFrame:CGRectZero font:20 textColor:Color_999 imgName:@"\U0000e6d5"];
        [_seletedBtn setImage:[XSObject setFontImg:@"\U0000e6d6" wFont:20 wColor:ThemeColor] forState:(UIControlStateSelected)];
    }
    
    return _seletedBtn;
}

- (YYLabel *)protocolL {
    if (!_protocolL) {
        _protocolL = [[YYLabel alloc] init];
    //    _protocolL.textColor = Color_999;
      
        _protocolL.font = kFont(12);
        NSString *str1 = @"服务条款";
        NSString *str2 = @"隐私协议";
        NSString *str3 = @"已阅读并同意蛮多星用户端《";
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@》与《%@》",str3,str1,str2]];
        [attributeStr setYy_color:Color_999];
        MJWeakSelf
        [attributeStr yy_setTextHighlightRange:NSMakeRange(str3.length-1, str1.length + 2) color:ThemeColor backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
           
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(pushServiceClause)]) {
                [weakSelf.delegate pushServiceClause];
            }
            
            
        }];
        [attributeStr yy_setTextHighlightRange:NSMakeRange(str3.length + str1.length + 2, str2.length + 2) color:ThemeColor backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {

            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(pushPrivacyPolicy)]) {
                 [weakSelf.delegate pushPrivacyPolicy];
            }
           
        }];
        _protocolL.attributedText = attributeStr;
    }
    return _protocolL;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
