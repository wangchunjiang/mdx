//
//  HSCommonFunction.m
//  ManduoXingUser
//
//  Created by wangchunjiang on 2021/4/2.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSCommonFunction.h"

@implementation HSCommonFunction
//获得当前活动窗口的根视图
+ (UIViewController *)findCurrentShowingViewController {
  
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentShowingVC = [self findCurrentShowingViewControllerFrom:vc];
    return currentShowingVC;
}

//注意考虑几种特殊情况：①A present B, B present C，参数vc为A时候的情况
+ (UIViewController *)findCurrentShowingViewControllerFrom:(UIViewController *)vc
{
    //方法1：递归方法 Recursive method
    UIViewController *currentShowingVC;
    if ([vc presentedViewController]) { //注要优先判断vc是否有弹出其他视图，如有则当前显示的视图肯定是在那上面
        // 当前视图是被presented出来的
        UIViewController *nextRootVC = [vc presentedViewController];
        currentShowingVC = [self findCurrentShowingViewControllerFrom:nextRootVC];
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        UIViewController *nextRootVC = [(UITabBarController *)vc selectedViewController];
        currentShowingVC = [self findCurrentShowingViewControllerFrom:nextRootVC];
        
    } else if ([vc isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        UIViewController *nextRootVC = [(UINavigationController *)vc visibleViewController];
        currentShowingVC = [self findCurrentShowingViewControllerFrom:nextRootVC];
        
    } else {
        // 根视图为非导航类
        currentShowingVC = vc;
    }
    
    return currentShowingVC;
    
    /*
    //方法2：遍历方法
    while (1)
    {
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
            
        } else if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
            
        } else if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
            
        //} else if (vc.childViewControllers.count > 0) {
        //    //如果是普通控制器，找childViewControllers最后一个
        //    vc = [vc.childViewControllers lastObject];
        } else {
            break;
        }
    }
    return vc;
    //*/
}
//退出登录
+(void)loginOut{
    
    
    
    
}

//计算字符串宽高
+ (CGSize)sizeText:(NSString*)text font:(UIFont *)font customSize:(CGSize)customSize
{
    if ([HSCommonFunction isBlankString:text]) {
        return CGSizeZero;
    }
    
    CGSize textSize = CGSizeZero;
    CGSize maxSize = customSize;
    
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    
    NSDictionary *attributes = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : style };
    
    CGRect rect = [text boundingRectWithSize:maxSize
                                     options:opts
                                  attributes:attributes
                                     context:nil];
    textSize = CGSizeMake(ceil(rect.size.width), ceil(rect.size.height));
    return textSize;
}

//字符串是否为空
+ (BOOL)isBlankString:(NSString *)string {
 
      if (string == nil || string == NULL) {
 
          return YES;
 
     }
      if ([string isKindOfClass:[NSNull class]]) {

        return YES;

     }
     if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {

        return YES;

     }
     return NO;
 }

//字典转json 字符串
+(NSString*)dictionaryToJson:(NSDictionary *)dic{
    
    NSError *parseError = nil;

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];

    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

}
//判断是否是手机号
+(BOOL)isMobile:(NSString*)str{
    
    str = [HSCommonFunction spaceFormattingString:str];
    NSString *mobile = @"^1(3[0-9]|4[57]|5[0-35-9]|66|7[0135-8]|8[0-9]|9[89]])\\d{8}$";
    NSPredicate *p = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
    return [p evaluateWithObject:str];
}
//去掉字符串空格
+(NSString*)spaceFormattingString:(NSString*)str{
    
    return [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    
}

//手机号匿名
+(NSString*)anonymousPhoneFormate:(NSString*)str{
    
    if ([HSCommonFunction isBlankString:str]) {
        return @"";
    }
     NSString *newStr = str;
    NSInteger startLocation = 3;
    for (int i = 1; i < str.length; i++) {
        if (startLocation ==7) {
            break;
        }
        NSRange range = NSMakeRange(startLocation, 1);

        newStr = [newStr stringByReplacingCharactersInRange:range withString:@"*"];

        startLocation ++;
        

    }
       return newStr;
    
}

@end
