//
//  XSObject.m
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/25.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "XSObject.h"

@implementation XSObject
//MARK:-验证码按钮点击后 设置文字开始倒计时
+(void)setCountDown:(UIButton*)btn{
    
    __block int timeout=60; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t LHTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(LHTimer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(LHTimer, ^{
        
        if(timeout<=0){
            
            //倒计时结束，关闭
            dispatch_source_cancel(LHTimer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
                
                btn.userInteractionEnabled = YES;
            });
        }else{
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", timeout];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示
                [btn setTitle:[NSString stringWithFormat:@"%@秒后重发",strTime] forState:UIControlStateNormal];
                btn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(LHTimer);
}

//MARK:-默认显示消息-->center
+ (void)showMassage:(NSString *)msg {
    
    [self showToast:msg location:@"center" showTime:3];
}

//显示消息
+ (void)showToast:(NSString *)message location:(NSString *)aLocationStr showTime:(float)aShowTime
{
    if (!message) {
        message = @"";
    }
    if ([[NSThread currentThread] isMainThread]) {
        toastLabel = [self currentToastLabel];
        [toastLabel removeFromSuperview];
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        [window addSubview:toastLabel];
        
        CGFloat main_width = [[UIScreen mainScreen] bounds].size.width;
        CGFloat main_height = [[UIScreen mainScreen] bounds].size.height;
        
        CGFloat width = [self stringText:message font:16 isHeightFixed:YES fixedValue:40];
        CGFloat height = 0;
        if (width > main_width - 20) {
            width = main_width - 20;
            height = [self stringText:message font:16 isHeightFixed:NO fixedValue:width];
        }else{
            height = 40;
        }
        
        CGRect labFrame;
        if (aLocationStr && [aLocationStr isEqualToString:@"top"]) {
            labFrame = CGRectMake((main_width-width)/2, main_height*0.15, width, height);
        }else if (aLocationStr && [aLocationStr isEqualToString:@"bottom"]) {
            labFrame = CGRectMake((main_width-width)/2, main_height*0.85, width, height);
        }else{
            //default-->center
            labFrame = CGRectMake((main_width-width)/2, main_height*0.5, width, height);
        }
        toastLabel.frame = labFrame;
        toastLabel.text = message;
        toastLabel.alpha = 1;
        [UIView animateWithDuration:aShowTime animations:^{
            toastLabel.alpha = 0;
        } completion:^(BOOL finished) {
        }];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showToast:message location:aLocationStr showTime:aShowTime];
        });
        return;
    }
}

static UILabel *toastLabel = nil;
+ (UILabel *)currentToastLabel {
    @synchronized(self) {
        if (toastLabel == nil) {
            toastLabel = [[UILabel alloc] init];
            toastLabel.backgroundColor = [UIColor darkGrayColor];
            toastLabel.font = [UIFont systemFontOfSize:16];
            toastLabel.textColor = UIColor.whiteColor;
            toastLabel.numberOfLines = 0;
            toastLabel.textAlignment = NSTextAlignmentCenter;
            toastLabel.lineBreakMode = NSLineBreakByCharWrapping;
            toastLabel.layer.masksToBounds = YES;
            toastLabel.layer.cornerRadius = 5.0;
            toastLabel.alpha = 0;
        }
        return toastLabel;
    }
}

static UIView *toastViewLabel = nil;
+ (UIView *)currentToastViewLabel {
    @synchronized(self) {
        if (toastViewLabel == nil) {
            toastViewLabel = [[UIView alloc] init];
            toastViewLabel.backgroundColor = [UIColor darkGrayColor];
            toastViewLabel.layer.masksToBounds = YES;
            toastViewLabel.layer.cornerRadius = 5.0;
            toastViewLabel.alpha = 0;
            
            UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            indicatorView.tag = 10;
            indicatorView.hidesWhenStopped = YES;
            indicatorView.color = UIColor.whiteColor;
            [toastViewLabel addSubview:indicatorView];
            
            UILabel *aLabel = [[UILabel alloc] init];
            aLabel.tag = 11;
            aLabel.backgroundColor = toastViewLabel.backgroundColor;
            aLabel.font = [UIFont systemFontOfSize:16];
            aLabel.textColor = UIColor.whiteColor;
            aLabel.textAlignment = NSTextAlignmentCenter;
            aLabel.lineBreakMode = NSLineBreakByCharWrapping;
            aLabel.layer.masksToBounds = YES;
            aLabel.layer.cornerRadius = 5.0;
            aLabel.numberOfLines = 0;
            [toastViewLabel addSubview:aLabel];
        }
        return toastViewLabel;
    }
}
//MARK:-根据字符串长度获取对应的宽度或者高度
+ (CGFloat)stringText:(NSString *)aText font:(CGFloat)aFont isHeightFixed:(BOOL)isHeightFixed fixedValue:(CGFloat)fixedValue{
   
    CGSize size;
    if (isHeightFixed) {
        size = CGSizeMake(MAXFLOAT, fixedValue);
    } else {
        size = CGSizeMake(fixedValue, MAXFLOAT);
    }
    
    CGSize resultSize = CGSizeZero;
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0) {
        //返回计算出的size
        resultSize = [aText boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:aFont]} context:nil].size;
    }
    
    if (isHeightFixed) {
        return resultSize.width + 20; //增加左右20间隔
    } else {
        return resultSize.height + 20; //增加上下20间隔
    }
}

//MARK:- 获取阿里图片
+(UIImage *)setFontImg:(NSString *)name wFont:(NSInteger)font wColor:(UIColor *)color{
                       
    return [UIImage iconWithInfo:TBCityIconInfoMake(name, font, color)];

}

//MARK:-字典转换为字符串
+(NSString*)dictionaryToJson:(NSDictionary *)dic{
    
    NSError *parseError = nil;

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];

    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

}

//MARK:-字符串转换为字典
+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {

    if (jsonString == nil) {

    return nil;

    }

    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];

    NSError *err;

    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData

    options:NSJSONReadingMutableContainers

    error:&err];

    if(err) {

    NSLog(@"json解析失败：%@",err);

    return nil;

    }

    return dic;

}

#pragma mark - /* 设置渐变色 */
/* 竖着的渐变 */
+(CAGradientLayer *)setChangeColor:(UIColor *)color1 withColor:(UIColor *)color2 withFream:(CGRect)fream{
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)color1.CGColor, (__bridge id)color2.CGColor];//这里颜色渐变
    gradientLayer.locations = @[@0.0, @1.0];//颜色位置
    gradientLayer.startPoint = CGPointMake(0.0, 1.0);
    gradientLayer.endPoint = CGPointMake(0.0, 0.0);
    gradientLayer.frame = CGRectMake(0, 0, fream.size.width, fream.size.height);
    return gradientLayer;
    
}
//横着的渐变
+(CAGradientLayer *)setChangeHorColor:(UIColor *)color1 withColor:(UIColor *)color2 withFream:(CGRect)fream{
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)color1.CGColor, (__bridge id)color2.CGColor];//这里颜色渐变
    gradientLayer.locations = @[@0.0, @0.8];//颜色位置
    gradientLayer.startPoint = CGPointMake(0.7, 0.0);
    gradientLayer.endPoint = CGPointMake(0.0, 0.0);
    gradientLayer.frame = CGRectMake(0, 0, fream.size.width, fream.size.height);
    return gradientLayer;
    
}


//MARK:-划圆角
+(CAShapeLayer *)creatCornerRatioWithView:(UIView *)subView  withOne:(UIRectCorner)temp1 withTwo:(UIRectCorner)temp2 withSize:(CGSize)size{
    //绘制圆角 要设置的圆角 使用“|”来组合
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:subView.bounds byRoundingCorners:temp1 | temp2 cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    //设置大小
    maskLayer.frame = subView.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    
    return maskLayer;
}


//MARK:-字典转字符串
+(NSString *)convertToJsonData:(NSDictionary *)dict{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];

    NSString *jsonString;

    if (!jsonData) {

        NSLog(@"%@",error);

    }else{

        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];

    }

    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];

    NSRange range = {0,jsonString.length};

    //去掉字符串中的空格

    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];

    NSRange range2 = {0,mutStr.length};

    //去掉字符串中的换行符

    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];

    return mutStr;

}

//MARK:-项目生成id_str
+(NSString *)getId_strWithArray:(NSArray *)array{
    
    NSMutableArray *arryaTemp = [[NSMutableArray alloc]init];
    for (NSString *subStr in array) {
        
        [arryaTemp addObject:[XSObject MD5ForLower32Bate:subStr]];
    }
    
//    ascII码排序
        NSStringCompareOptions comparisonOptions =NSCaseInsensitiveSearch|
        NSWidthInsensitiveSearch|NSForcedOrderingSearch;
        NSComparator sort = ^(NSString *obj1,NSString *obj2){
            NSRange range =NSMakeRange(0,obj1.length);
            return [obj1 compare:obj2 options:comparisonOptions range:range];
        };
        NSArray *resultArray2 = [arryaTemp sortedArrayUsingComparator:sort];
    
    NSLog(@"排序====%@",resultArray2);
    
//    NSMutableArray * testArr = @[   @"147bce82c775f1e627e0260667b891c5",@"1c42b7fcd6dd74824e4f182a5d028ffb"].mutableCopy;
//

//    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
//    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
//    NSArray *myDataArray = arryaTemp;
//    NSArray *resultArray = [myDataArray sortedArrayUsingDescriptors:descriptors];
//    NSLog(@"resultArray1111======%@", resultArray);
//
 
    NSString *arrStr = [resultArray2 componentsJoinedByString:@"@"];
    
    return [XSObject MD5ForLower32Bate:arrStr];
}

#pragma mark - 32位 小写
+(NSString *)MD5ForLower32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return [digest lowercaseString];
}

#pragma mark - 32位 大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    
    return digest;
}

#pragma mark - 16位 大写
+(NSString *)MD5ForUpper16Bate:(NSString *)str{
    
    NSString *md5Str = [self MD5ForUpper32Bate:str];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}


#pragma mark - 16位 小写
+(NSString *)MD5ForLower16Bate:(NSString *)str{
    
    NSString *md5Str = [self MD5ForLower32Bate:str];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}


/*改变电话号码的格式344*/
+(NSString *)changPhoneNum:(NSString *)phoneNum{
    NSString *tenDigitNumber = phoneNum;
    tenDigitNumber = [tenDigitNumber stringByReplacingOccurrencesOfString:@"(\\d{3})(\\d{4})(\\d{4})"
                                                               withString:@"$1 $2 $3"
                                                                  options:NSRegularExpressionSearch
                                                                    range:NSMakeRange(0, [tenDigitNumber length])];
    return tenDigitNumber;
}
/*把改变格式的手机号码的格式改回正常字符串*/
+(NSString *)changBackPhoneNum:(NSString *)phoneNum{
    NSString *tenDigitNumber = phoneNum;
    return [tenDigitNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
}


/** 解析成html的富文本 */
+ (NSAttributedString *)attrHtmlStringFrom:(NSString *)str {
    NSString *htmlStr = [NSString stringWithFormat:@"<head><style>img{max-width:%f !important;height:auto}</style></head>%@", Screen_width, str];
    NSAttributedString *attrStr=  [[NSAttributedString alloc] initWithData:[htmlStr dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:@(NSUTF8StringEncoding)} documentAttributes:nil error:nil];
    return attrStr;
}

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *   url
 *   size  图片宽度
 */
+(UIImage *)createNonInterpolatedUIImageForUrl:(NSString *)url withSize:(CGFloat) size{
    // 1.创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复默认
    [filter setDefaults];
    
    // 3.给过滤器添加数据(正则表达式/账号和密码)
    NSString *dataString = url;
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 4.获取输出的二维码
    CIImage *outputImage = [filter outputImage];
    
    CGRect extent = CGRectIntegral(outputImage.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:outputImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

//界面截图
+(UIImage*)screenSnapshot:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImage * iii = [[UIImage alloc] initWithData: UIImageJPEGRepresentation(image, 0.8)];
    return iii;
}
//手机号码格式化
+(NSString*)mobileFormate:(NSString*)phoneNum{
    if (!phoneNum) {
          return @"";
      }
      NSString * phone=  [phoneNum stringByReplacingOccurrencesOfString:@"(\\d{3})(\\d{4})(\\d{4})"
         withString:@"$1 $2 $3"
            options:NSRegularExpressionSearch
              range:NSMakeRange(0, [phoneNum length])];
      
      return phone;
}


+(NSString*)priceFromate:(NSString*)price{

    if ([HSCommonFunction isBlankString:price]) {
        
        return @"";
    }
    if ([price containsString:@"."]) {//有小数点
        return [NSString stringWithFormat:@"%.2f",price.floatValue];
        
    }else{

        return price;;
    }
    
    
    
}

+(NSString*)anonymousFormate:(NSString*)str{
    
    if ([HSCommonFunction isBlankString:str]) {
        return @"";
    }
     NSString *newStr = str;
    NSInteger startLocation = 0;
 
    for (int i = 0; i < str.length; i++) {

        NSRange range = NSMakeRange(startLocation, 1);

        newStr = [newStr stringByReplacingCharactersInRange:range withString:@"*"];

        startLocation ++;

    }
       return newStr;
    
}


@end
