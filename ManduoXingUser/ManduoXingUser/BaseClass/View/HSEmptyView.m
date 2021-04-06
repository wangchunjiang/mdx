//
//  HSEmptyView.m
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/25.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSEmptyView.h"

@implementation HSEmptyView
- (instancetype)initWithFrame:(CGRect)frame imageViewTop:(CGFloat)imageViewTop imageViewSize:(CGSize)imageViewSize imageName:(NSString *)imageName labelTop:(CGFloat)labelTop labelText:(NSString *)labelText buttonTop:(CGFloat)buttonTop buttonSize:(CGSize)buttonSize buttonTitle:(NSString *)buttonTitle
{
    if (self = [super initWithFrame:frame]) {
        
        self.emptyImageView.image = [UIImage imageNamed:imageName];
        self.emptyLabel.text = labelText;
        [self.emptyButton setTitle:buttonTitle forState:UIControlStateNormal];
        self.iconToTop = imageViewTop;
        self.iconToText = labelTop;
        self.textToButton = buttonTop;
        self.buttonSize = buttonSize;
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame imageViewTop:(CGFloat)imageViewTop imageViewSize:(CGSize)imageViewSize imageName:(NSString *)imageName labelTop:(CGFloat)labelTop labelText:(NSString *)labelText
{
    if (self = [super initWithFrame:frame]) {
        
        self.emptyImageView.image = [UIImage imageNamed:imageName];
        self.emptyLabel.text = labelText;
        self.emptyButton.hidden = YES;
        
        self.iconToTop = imageViewTop;
        self.iconToText = labelTop;
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.iconToTop = 97.0;
        self.iconToText = 15.0;
        self.textToButton = 30.0;
        self.buttonSize = CGSizeMake(150, 40);
        self.backgroundColor = Color_f4f4f4;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self emptyImageView];
    [self emptyLabel];
    [self emptyButton];
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self.emptyLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5; // 设置行间距
    paragraphStyle.alignment = NSTextAlignmentCenter; //设置居中显示
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedStr.length)];
    self.emptyLabel.attributedText = attributedStr;
    
    CGSize size = [self.emptyImageView sizeThatFits:CGSizeZero];
    [self.emptyImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(self.iconToTop);
        make.size.mas_equalTo(CGSizeMake(200, (200 * size.height / size.width)));
    }];
    
    [self.emptyLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.mas_lessThanOrEqualTo(250);
        make.top.equalTo(self.emptyImageView.mas_bottom).offset(self.iconToText);
    }];
    
    if (!self.emptyButton.hidden) {
        [self.emptyButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.emptyLabel.mas_bottom).offset(self.textToButton);
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(self.buttonSize.width-30, self.buttonSize.height));
        }];
        
        NSLog(@"buttonSize===%f",self.buttonSize.width);
        self.emptyButton.layer.cornerRadius = 20;
        self.emptyButton.layer.masksToBounds = YES;
    }
}


- (UILabel *)emptyLabel
{
    if (!_emptyLabel) {
        _emptyLabel = [UILabel new];
        _emptyLabel.textColor = Color_999;
        _emptyLabel.font = kFont(12);
        _emptyLabel.textAlignment = NSTextAlignmentCenter;
        _emptyLabel.numberOfLines = 0;
        [self addSubview:_emptyLabel];
    }
    
    return _emptyLabel;
}

- (UIImageView *)emptyImageView
{
    if (!_emptyImageView) {
        _emptyImageView = [UIImageView new];
        [self addSubview:_emptyImageView];

    }
    
    return _emptyImageView;
}

- (UIButton *)emptyButton
{
    if (!_emptyButton) {
        
        _emptyButton = [UIButton new];
        _emptyButton.titleLabel.font = kFont(15);
        [_emptyButton setTitleColor:Color_white forState:(UIControlStateNormal)];
        _emptyButton.backgroundColor = ThemeColor;
       [_emptyButton addTarget:self action:@selector(emptyButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
        _emptyButton.layer.cornerRadius = 2.0;
        _emptyButton.layer.masksToBounds = YES;
        [self addSubview:_emptyButton];

    }
    
    return _emptyButton;
}


#pragma mark  -----  底部按钮点击事件

- (void)emptyButtonClick
{
    if (self.emptyButtonBlock) {
        self.emptyButtonBlock();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
