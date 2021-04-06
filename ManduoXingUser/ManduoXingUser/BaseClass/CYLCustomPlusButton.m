//
//  CYLCustomPlusButton.m
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/25.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "CYLCustomPlusButton.h"
#import "HSLoginVC.h"

@implementation CYLCustomPlusButton
+ (id)plusButton {
    CYLCustomPlusButton *button = [[CYLCustomPlusButton alloc] init];
       UIImage *normalButtonImage = [UIImage imageNamed:@"icon_tabbar_plus"];
     
       [button setImage:normalButtonImage forState:UIControlStateNormal];


       button.imageEdgeInsets = UIEdgeInsetsMake(5, 0, -5, 0);
       button.titleLabel.font = [UIFont systemFontOfSize:9.5];
     //  [button sizeToFit]; // or set frame in this way `button.frame = CGRectMake(0.0, 0.0, 250, 100);`
       button.frame = CGRectMake(0.0, 0.0, Screen_width/5, 59);
       
       // if you use `+plusChildViewController` , do not addTarget to plusButton.
       [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
       return button;
}
+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight{
    
    return  0.25;
}
+ (NSUInteger)indexOfPlusButtonInTabBar{
    
    return 2;
    
}
+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight {
    return -5;
}
- (void)clickPublish {
    UIViewController * currentVC = [HSCommonFunction findCurrentShowingViewController];
    UIViewController * pushVC ;
    HSLoginVC * loginVC = [HSLoginVC new];
    pushVC = loginVC;
    
    HSBaseNav * currentNav = [[HSBaseNav alloc]initWithRootViewController:pushVC];
    currentNav.modalPresentationStyle = UIModalPresentationFullScreen;
    [currentVC presentViewController:currentNav animated:YES completion:nil];
    


}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
