//
//  HSOauthLoginView.m
//  HappyLive
//
//  Created by wangchunjiang on 2021/3/29.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSOauthLoginView.h"
@interface HSOauthLoginView ()
@property(nonatomic,strong)UIImageView * Logo;
@property(nonatomic,strong)UILabel * titleLbl ;
@property (nonatomic,strong)YYLabel *yyLabel;
@end
@implementation HSOauthLoginView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    
    return self;
    
}
-(void)configUI{
    [self addSubview:self.closeBtn];
    [self addSubview:self.Logo];
    [self addSubview:self.titleLbl];
    [self addSubview:self.phoneLbl];
    
    [self addSubview:self.oauthLoginBtn];
    [self addSubview:self.otherLogin];
    
    [self addSubview:self.yyLabel];
    
    self.phoneLbl.text = [HSCommonFunction anonymousPhoneFormate:self.phoneLbl.text];
    
    
    
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
    
    [self.phoneLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLbl.mas_bottom).offset(RatioNumH(40));
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(RatioNumH(22));
        
    }];
    
    [self.oauthLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneLbl.mas_bottom).offset(RatioNumH(10));
        make.left.mas_equalTo(RatioNumW(16));
        make.right.mas_equalTo(RatioNumW(-16));
        make.height.mas_equalTo(RatioNumH(40));
    }];
    
    [self.otherLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.oauthLoginBtn.mas_bottom).offset(RatioNumH(20));
        make.left.mas_equalTo(RatioNumW(16));
        make.right.mas_equalTo(RatioNumW(-16));
        make.height.mas_equalTo(RatioNumH(40));
        
    }];
    
    [self.yyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-RatioNumH(20)-Tabbar_heightMargen);
        make.left.mas_equalTo(RatioNumW(16));
        make.right.mas_equalTo(-RatioNumW(16));
        make.height.mas_equalTo(RatioNumH(45));
        
    }];
    
    [self protocolIsSelect:NO];
    
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

-(UILabel*)phoneLbl{
    if (!_phoneLbl) {
        _phoneLbl = [XSUIObject createLabelFrame:CGRectZero Text:@"18238770747" font:kFontMedium(24) textColor:Color_3030];
        _phoneLbl.textAlignment = NSTextAlignmentCenter;
    }
    
    return _phoneLbl;
}


-(UIButton*)oauthLoginBtn{
    if (!_oauthLoginBtn) {
        _oauthLoginBtn = [XSUIObject createBtnFrame:CGRectZero title:@"本机号码一键登录" font:kFont(14) textColor:Color_white imgName:@""];
        _oauthLoginBtn.layer.cornerRadius = RatioNumH(20);
        _oauthLoginBtn.clipsToBounds = YES;
        _oauthLoginBtn.backgroundColor = ThemeColor;
    }
    
    return _oauthLoginBtn;
}

-(UIButton*)otherLogin{
    if (!_otherLogin) {
        _otherLogin = [XSUIObject createBtnFrame:CGRectZero title:@"其他方式登录" font:kFont(14) textColor:Color_3030 imgName:@""];
        _otherLogin.layer.cornerRadius = RatioNumH(20);
        _otherLogin.clipsToBounds = YES;
        _otherLogin.backgroundColor = Color_f4f4f4;
    }
    
    return _otherLogin;
}


- (void)protocolIsSelect:(BOOL)isSelect{
    
//    UIColor *color = self.isSelect ? Color_999 : ThemeColor;
//    NSDictionary *attributes = @{NSFontAttributeName:kFont(12), NSForegroundColorAttributeName: color};
//    
       
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:@"  已阅读并同意蛮多星用户端《服务条款》、《隐私协议》与《运营商账号服务与隐私协议》并授权闪验获取本机手机号"];
    [attributeStr setYy_color:Color_999];
 
    [attributeStr yy_setTextHighlightRange:[[attributeStr string] rangeOfString:@"《服务条款》"] color:ThemeColor backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
           NSLog(@"点击了服务条款");
       }];

    [attributeStr yy_setTextHighlightRange:[[attributeStr string] rangeOfString:@"《隐私协议》"] color:ThemeColor backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
           NSLog(@"点击了隐私协议");

       }];
    
    [attributeStr yy_setTextHighlightRange:[[attributeStr string] rangeOfString:@"《运营商账号服务与隐私协议》"] color:ThemeColor backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSLog(@"运营商账号服务与隐私协议");

    }];
    
       //添加图片
    UIImage * normalImage = [XSObject setFontImg:@"\U0000e6d5" wFont:20 wColor:Color_999];
    UIImage * selectImage = [XSObject setFontImg:@"\U0000e6d6" wFont:20 wColor:ThemeColor];
    
    
    UIImage *image = self.isSelect == NO ? normalImage : selectImage;
    NSMutableAttributedString *attachment = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:CGSizeMake(RatioNumW(20), RatioNumW(20)) alignToFont:kFont(12) alignment:(YYTextVerticalAlignment)YYTextVerticalAlignmentCenter];

    [attributeStr insertAttributedString:attachment atIndex:0];
       //添加图片的点击事件
    [attributeStr yy_setTextHighlightRange:[[attributeStr string] rangeOfString:[attachment string]] color:[UIColor clearColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
           __weak typeof(self) weakSelf = self;
           weakSelf.isSelect = !weakSelf.isSelect;
           [weakSelf protocolIsSelect:weakSelf.isSelect];
           
       }];
       _yyLabel.attributedText = attributeStr;
     //  _yyLabel.textAlignment = NSTextAlignmentCenter;
    
    
}
-(YYLabel*)yyLabel{
    if (!_yyLabel) {
        _yyLabel = [YYLabel new];
        _yyLabel.numberOfLines = 0;
        [_yyLabel setFont:kFont(12)];
        _yyLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        _yyLabel.textAlignment = NSTextAlignmentCenter;
       
    }
    
    
    return _yyLabel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
