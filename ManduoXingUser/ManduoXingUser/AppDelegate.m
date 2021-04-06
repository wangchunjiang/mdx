//
//  AppDelegate.m
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/25.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "AppDelegate.h"
#import "TXLiveBase.h"  //非TRTC
#import <AMapFoundationKit/AMapFoundationKit.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //腾讯直播
    [TXLiveBase setLicenceURL:[HSSystemConfig share].txLiveLicenceURL key:[HSSystemConfig share].txLiveLicenceKey];
    //高德地图
    [AMapServices sharedServices].apiKey = [HSSystemConfig share].aMapKey;
  
    
    [self loadTabbarViewController];
    return YES;
}
//  界面加载至 Tabbar模块
- (void)loadTabbarViewController
{
    HSMainTabBarController * tab = [[HSMainTabBarController alloc]initWithContext:@""];
    tab.selectedIndex =0;
    self.window.rootViewController = tab;
    [self.window makeKeyAndVisible];
    
}

#pragma mark - UISceneSession lifecycle


//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}
//

@end
