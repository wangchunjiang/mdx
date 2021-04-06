//
//  XSUIObject.m
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/25.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "XSUIObject.h"

@implementation XSUIObject
#pragma mark - 创建View
+(UIView *)creatViewFrame:(CGRect)frame{
    
    UIView *view = [[UIView alloc]initWithFrame:frame];
    
    return view;
}


#pragma mark 创建imageView
+(UIImageView*)createImageViewFrame:(CGRect)frame imageName:(NSString*)imageName{
    
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:frame];
    
    imageView.image=[UIImage imageNamed:imageName];
    
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;//  是否剪切掉超出 UIImageView 范围的图片
    
    //用户交互
    imageView.userInteractionEnabled=YES;
    
    return imageView;
}

#pragma mark 创建label
+(UILabel *)createLabelFrame:(CGRect)frame Text:(NSString*)text font:(UIFont *)font textColor:(UIColor*)color{
    
    UILabel * label = [[UILabel alloc]initWithFrame:frame];
    //设置字体
    label.font = font;
    
    //设置折行方式 NSLineBreakByWordWrapping是按照单词折行
  //  label.lineBreakMode = UILineBreakModeTailTruncation;
    //设置文字
    label.text = text;
    
    if (color) {
        
        label.textColor = color;
    }
    
    //自适应
    //    label.adjustsFontSizeToFitWidth=YES;
    return label;
}

#pragma mark 创建button
+(UIButton *)createBtnFrame:(CGRect)frame title:(NSString*)title font:(UIFont *)font textColor:(UIColor*)color imgName:(NSString *)imgName{
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    if (imgName.length > 0) {
       
        [button setImage:HSSetImage(imgName) forState:UIControlStateNormal];
    }
    
    [button.titleLabel setFont:font];
    
    [button setTitleColor:color forState:UIControlStateNormal];
    
    button.frame = frame;
    
    return button;
}

/* 创建阿里图片的按钮 */
+(UIButton *)createFontBtnFrame:(CGRect)frame font:(NSInteger)font textColor:(UIColor*)color imgName:(NSString *)imgName{
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    
    if (imgName.length > 0) {
        
        [button setImage:[XSObject setFontImg:imgName wFont:font wColor:color] forState:UIControlStateNormal];
    }
    button.frame = frame;
    
    return button;
}



#pragma mark - 创建UItextfiled
+(UITextField *)creatTFFrame:(CGRect)frame withPlaceholder:(NSString *)placeholder  withplaceholderCol:(UIColor *)color{
    
    UITextField *textField=[[UITextField alloc]initWithFrame:frame];
    
    textField.font = kFont(14);

    //清除按钮
    textField.clearButtonMode=YES;
    
    //当再次编辑时候清除
    //textField.clearsOnBeginEditing=YES;

    //提示文字
    textField.placeholder = placeholder;
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:placeholder attributes:

    @{NSForegroundColorAttributeName:color,

                NSFontAttributeName:textField.font }];

    textField.attributedPlaceholder = attrString;
    
    //修改placeholder的颜色
    return textField;
    
}
@end
