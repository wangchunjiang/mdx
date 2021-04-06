//
//  MSGHUD.m
//  ManduoXingUser
//
//  Created by wangchunjiang on 2021/4/2.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "MSGHUD.h"

@implementation MSGHUD
+(void)showToast:(NSString *)msg{
    
    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
   // style.messageFont = [UIFont fontWithName:@"Zapfino" size:14.0];
    style.messageColor = [UIColor whiteColor];
    style.messageAlignment = NSTextAlignmentCenter;
    style.backgroundColor = [UIColor blackColor];
   //  style.horizontalPadding = 20;
    style.cornerRadius = 5;

 //   [KKeyWindow makeToast:msg duration:1.5 position:CSToastPositionCenter];
    [KKeyWindow makeToast:msg duration:1.5 position:CSToastPositionCenter style:style];
}
@end
