//
//  HSMineVC.m
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/25.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSMineVC.h"
#import "HSGiftViewController.h"
#import "HSSignInApple.h"
#import "HSSelectCityVC.h"
@interface HSMineVC ()
@property (nonatomic, strong) HSSignInApple *signInApple;
@end

@implementation HSMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.hiddenBack = YES;
   UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = UIColor.redColor;
    [btn setTitle:@"礼物" forState:(UIControlStateNormal)];
    [self.view addSubview:btn];
       MJWeakSelf
          [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
              HSGiftViewController * vc = [HSGiftViewController new];
              [weakSelf.navigationController pushViewController:vc animated:YES];
          }];
    
    
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
       btn1.frame = CGRectMake(220, 100, 100, 100);
       btn1.backgroundColor = UIColor.redColor;
       [btn1 setTitle:@"城市选择" forState:(UIControlStateNormal)];
       [self.view addSubview:btn1];
    
    [[btn1 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
               HSSelectCityVC * vc = [HSSelectCityVC new];
               [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
     
     
    
    
    
    // 使用系统提供的按钮，要注意不支持系统版本的处理
    if (@available(iOS 13.0, *)) {
        // Sign In With Apple Button
        ASAuthorizationAppleIDButton *appleIDBtn = [ASAuthorizationAppleIDButton buttonWithType:ASAuthorizationAppleIDButtonTypeDefault style:ASAuthorizationAppleIDButtonStyleWhiteOutline];
        appleIDBtn.frame = CGRectMake(Screen_width/2-100, Screen_height-Tabbar_heightAll-100, 32, 32);
      
        appleIDBtn.cornerRadius = 15.f;
        [appleIDBtn addTarget:self action:@selector(didAppleIDBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:appleIDBtn];
    }
}

- (void)didAppleIDBtnClicked{
    // 封装Sign In with Apple 登录工具类，使用这个类时要把类对象设置为全局变量，或者直接把这个工具类做成单例，如果使用局部变量，和IAP支付工具类一样，会导致苹果回调不会执行
//    self.signInApple = [[SignInApple alloc] init];
    [self.signInApple handleAuthorizationAppleIDButtonPress];
}

- (HSSignInApple *)signInApple {
    if (!_signInApple) {
        _signInApple = [[HSSignInApple alloc]init];
    }
    return _signInApple;
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
