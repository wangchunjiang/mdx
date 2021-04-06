//
//  HSMainTabBarController.m
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/25.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSMainTabBarController.h"
#import "HSMineVC.h"
#import "HSHomeVC.h"
#import "HSVideoHomeVC.h"
#import "HSLiveHomeVC.h"
#import "CYLCustomPlusButton.h"
@interface HSMainTabBarController ()

@end

@implementation HSMainTabBarController
- (instancetype)initWithContext:(NSString *)context {
    /**
     * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
     * 等 效于在 `-tabBarItemsAttributesForController` 方法中不传 `CYLTabBarItemTitle` 字段。
     * 更推荐后一种做法。
     */
    UIEdgeInsets imageInsets = UIEdgeInsetsZero;//UIEdgeInsetsMake(4.5, 0, -4.5, 0);
    UIOffset titlePositionAdjustment = UIOffsetMake(0,0);
    if (self = [super initWithViewControllers:[self viewControllersForTabBar]
                        tabBarItemsAttributes:[self tabBarItemsAttributesForTabBar]
                                  imageInsets:imageInsets
                      titlePositionAdjustment:titlePositionAdjustment
                                      context:context
                ]) {
       [self customizeTabBarAppearanceWithTitlePositionAdjustment:titlePositionAdjustment];
        self.delegate = self;
        self.navigationController.navigationBar.hidden = YES;
    }
    return self;
}




- (NSArray *)viewControllersForTabBar {
    HSHomeVC * homeVC = [[HSHomeVC alloc] init];
    HSBaseNav * homeNav = [[HSBaseNav alloc] initWithRootViewController:homeVC];
         
        
    HSVideoHomeVC * videoVC = [[HSVideoHomeVC alloc] init];
    HSBaseNav * videoNav = [[HSBaseNav alloc] initWithRootViewController:videoVC];
    
    HSVideoHomeVC * liveVC = [[HSVideoHomeVC alloc] init];
    HSBaseNav * liveNav = [[HSBaseNav alloc] initWithRootViewController:liveVC];
    

         

    HSMineVC * minVC = [[HSMineVC alloc] init];
    HSBaseNav * minNav = [[HSBaseNav alloc] initWithRootViewController:minVC];
           
 
   
    NSArray *viewControllers = @[
                                 homeNav,
                                 videoNav,
                                 liveNav,
                                 minNav,
                                
                                 ];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForTabBar {
   
    UIImage *  homeNorImg  = [[XSObject setFontImg:@"\U0000e783" wFont:20 wColor:TabBarNorColor] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * homeSelImage =  [[XSObject setFontImg:@"\U0000e783" wFont:20 wColor:TabBarSelColor] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    UIImage *  videoNorImg  = [[XSObject setFontImg:@"\U0000e782" wFont:20 wColor:TabBarNorColor] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * videoSelImage =  [[XSObject setFontImg:@"\U0000e782" wFont:20 wColor:TabBarSelColor] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *  liveNorImg  = [[XSObject setFontImg:@"\U0000e781" wFont:20 wColor:TabBarNorColor] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *  liveSelImage =  [[XSObject setFontImg:@"\U0000e781" wFont:20 wColor:TabBarSelColor] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    UIImage * mineNorImg = [[XSObject setFontImg:@"\U0000edd9" wFont:20 wColor:TabBarNorColor] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    UIImage * mineSelImg = [[XSObject setFontImg:@"\U0000edd9" wFont:20 wColor:TabBarSelColor] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    
    
    // lottie动画的json文件来自于NorthSea, respect!
    CGFloat firstXOffset = -12/2;

    
    NSDictionary * homeAttributes = @{
                                                 CYLTabBarItemTitle : @"首页",
                                                 CYLTabBarItemImage : homeNorImg,  /* NSString and UIImage are supported*/
                                                 CYLTabBarItemSelectedImage :homeSelImage,  /* NSString and UIImage are supported*/
                                                 CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(firstXOffset, -3.5)],
                                                 //第一位 右大，下大
//                                                 CYLTabBarLottieURL : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"green_lottie_tab_home" ofType:@"json"]],
//                                                 CYLTabBarLottieSize: [NSValue valueWithCGSize:CGSizeMake(22, 22)]
                                                 };
    CGFloat secondXOffset = (-25+2)/2;
    NSDictionary * videoAttributes = @{
                                                 CYLTabBarItemTitle : @"短视频",
                                                 CYLTabBarItemImage : videoNorImg,  /* NSString and UIImage are supported*/
                                                 CYLTabBarItemSelectedImage :videoSelImage,  /* NSString and UIImage are supported*/
                                                 CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(secondXOffset, -3.5)],
                                                 //第一位 右大，下大
//                                                 CYLTabBarLottieURL : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"green_lottie_tab_home" ofType:@"json"]],
//                                                 CYLTabBarLottieSize: [NSValue valueWithCGSize:CGSizeMake(22, 22)]
                                                 };
    
    NSDictionary * liveAttributes = @{
                                                 CYLTabBarItemTitle : @"直播",
                                                 CYLTabBarItemImage : liveNorImg,  /* NSString and UIImage are supported*/
                                                 CYLTabBarItemSelectedImage :liveSelImage,  /* NSString and UIImage are supported*/
                                                 CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(secondXOffset,-3.5)],
                                                 //第一位 右大，下大
//                                                 CYLTabBarLottieURL : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"green_lottie_tab_home" ofType:@"json"]],
//                                                 CYLTabBarLottieSize: [NSValue valueWithCGSize:CGSizeMake(22, 22)]
                                                 };

    NSDictionary * mineAttributes = @{
                                                  CYLTabBarItemTitle : @"我的",
                                                  CYLTabBarItemImage : mineNorImg,
                                                  CYLTabBarItemSelectedImage :mineSelImg,
                                                  CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(secondXOffset, -3.5)],
//                                                  CYLTabBarLottieURL : [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"green_lottie_tab_discover" ofType:@"json"]],
//                                                  CYLTabBarLottieSize: [NSValue valueWithCGSize:CGSizeMake(33, 33)]
                                                  };
    

    NSArray *tabBarItemsAttributes = @[
                                    homeAttributes,
                                    videoAttributes,
                                    liveAttributes,
                                    mineAttributes,
                                       ];
    return tabBarItemsAttributes;
}


- (void)customizeTabBarAppearanceWithTitlePositionAdjustment:(UIOffset)titlePositionAdjustment {
    // Customize UITabBar height
    // 自定义 TabBar 高度
    // tabBarController.tabBarHeight = CYL_IS_IPHONE_X ? 65 : 40;

    //[self rootWindow].backgroundColor = [UIColor cyl_systemBackgroundColor];
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = TabBarNorColor;
    //normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = TabBarSelColor;
    //selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
   
    // set background color
    // 设置 TabBar 背景
    // 半透明
    [UITabBar appearance].translucent = NO;
  
    if (@available(iOS 13.0, *)) {
        UITabBarItemAppearance *inlineLayoutAppearance = [[UITabBarItemAppearance  alloc] init];
        // fix https://github.com/ChenYilong/CYLTabBarController/issues/456
        inlineLayoutAppearance.normal.titlePositionAdjustment = titlePositionAdjustment;

        // set the text Attributes
        // 设置文字属性
        [inlineLayoutAppearance.normal setTitleTextAttributes:normalAttrs];
        [inlineLayoutAppearance.selected setTitleTextAttributes:selectedAttrs];

        UITabBarAppearance *standardAppearance = [[UITabBarAppearance alloc] init];
        standardAppearance.stackedLayoutAppearance = inlineLayoutAppearance;
        standardAppearance.backgroundColor = [UIColor cyl_systemBackgroundColor];
        //shadowColor和shadowImage均可以自定义颜色, shadowColor默认高度为1, shadowImage可以自定义高度.
        standardAppearance.shadowColor = [UIColor cyl_systemGrayColor];
        standardAppearance.shadowColor = ThemeColor;
        // standardAppearance.shadowImage = [[self class] imageWithColor:[UIColor cyl_systemGreenColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 1)];
        self.tabBar.standardAppearance = standardAppearance;
    } else {
        // Override point for customization after application launch.
        // set the text Attributes
        // 设置文字属性
        UITabBarItem *tabBar = [UITabBarItem appearance];
        [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
        [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
        
        // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
        [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
        [[UITabBar appearance] setShadowImage:[[self class] imageWithColor:[UIColor cyl_systemGreenColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 1)]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [CYLCustomPlusButton registerPlusButton];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
