//
//  HSVerifyMobileView.m
//  ManduoXingUser
//
//  Created by wangchunjiang on 2021/4/2.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSVerifyMobileView.h"

@implementation HSVerifyMobileView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self configUI];
    }
    
    return self;
}

-(void)configUI{
    
    
    
    
}

-(UITextField*)phoneFidld{
    if (!_phoneFidld) {
        
    }

    return _phoneFidld;
    
}

-(UITextField*)codeField{
    if (!_codeField) {
        _codeField = [XSUIObject creatTFFrame:CGRectZero withPlaceholder:@"输入更验证码" withplaceholderCol:Color_999];
    }
    
    return _codeField;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
