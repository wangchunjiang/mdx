//
//  HSBaseViewController.m
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/25.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSBaseViewController.h"

@interface HSBaseViewController ()

@end

@implementation HSBaseViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hiddenCustomNavBar];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.view.backgroundColor = Color_white;
  [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self addLeftBack];
    self.view.backgroundColor = Color_white;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16.0f],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    [self setNeedsStatusBarAppearanceUpdate];
}

-(void)addRightBarButtonItem:(NSString *)title{
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
   
    [saveButton setTitle:title forState:(UIControlStateNormal)];
    [saveButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    saveButton.titleLabel.font =kFont(15) ;
    [saveButton sizeToFit];
    [saveButton addTarget:self action:@selector(rightBarButtonItemAction:) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    self.navigationItem.rightBarButtonItem = barItem;
}

-(void)rightBarButtonItemAction:(UIButton *)item{
    
    NSLog(@"rightBarButtonItemAction");
}

- (void)setHiddenBack:(BOOL)hiddenBack
{
    _hiddenBack = hiddenBack;
    self.navigationItem.leftBarButtonItem = nil;
}

-(void)showCustomNavBar{
    
    self.navigationController.navigationBar.hidden = NO;

    
}
-(void)hiddenCustomNavBar{
    
     self.navigationController.navigationBar.hidden = YES;
}

//  返回方法
- (void)wj_goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark  -----  设置 UI

/// 默认设置 图片 130*130、图文间距 15、文字-按钮间距 30
/// 展示无数据视图，移除界面数据视图
- (void)showEmplyView:(CGRect)rect imgName:(NSString *)imgName title:(NSString *)title buttonTitle:(NSString *)buttonTitle removeDataView:(UIView *)view
{
    if (view) {
        view.hidden = YES;
    }

    self.emptyView.frame = rect;
    self.emptyView.emptyImageView.image = [UIImage imageNamed:imgName];
    self.emptyView.emptyLabel.text = title;

    if (![HSCommonFunction isBlankString:buttonTitle]) {
        [self.emptyView.emptyButton setTitle:buttonTitle forState:(UIControlStateNormal)];
    }
    else
    {
        self.emptyView.emptyButton.hidden = YES;
    }

    [self.view addSubview:self.emptyView];
}

/// 移除 emptyView
- (void)removeEmplyView
{
    [self.emptyView removeFromSuperview];
    _emptyView = nil;
}


#pragma mark  -----  响应方法

#pragma mark  -----  网络请求

#pragma mark  -----  辅助方法

//  关闭右滑返回
- (void)cancelGestureForBack
{
    
}

//  开启右滑返回
- (void)openGestureForBack
{
    
}

//  获取当前可用 VC
- (UIViewController *)curViewController
{
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    if (!window) {
        return nil;
    }
    
    UIView *tempView;
    for (UIView *subview in window.subviews) {
        if ([[subview.classForCoder description] isEqualToString:@"UILayoutContainerView"]) {
            tempView = subview;
            break;
        }
    }
    
    if (!tempView) {
        tempView = [window.subviews lastObject];
    }
    
    id nextResponder = [tempView nextResponder];
    while (![nextResponder isKindOfClass:[UIViewController class]] || [nextResponder isKindOfClass:[UINavigationController class]] || [nextResponder isKindOfClass:[UITabBarController class]]) {
        tempView =  [tempView.subviews firstObject];
        
        if (!tempView) {
            return nil;
        }
        
        nextResponder = [tempView nextResponder];
    }
    
    return  (UIViewController *)nextResponder;
}

#pragma mark  -----  代理方法

#pragma mark  -----  getter

- (HSEmptyView *)emptyView
{
    if (!_emptyView) {
        
        _emptyView = [HSEmptyView new];
    }
    
    return _emptyView;
}


- (HSBaseNav *)curNavC
{
    HSBaseNav *navC = (HSBaseNav *)self.navigationController;
    return navC;
}

- (void)addLeftBack
{
    if (!self.hiddenBack) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        UIButton *leftBack = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBack.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
       // [leftBack setImage:[UIImage imageNamed:@"Nav_back"] forState:(UIControlStateNormal)];
         [leftBack setImage:[[XSObject setFontImg:@"\U0000e779" wFont:20 wColor:Color_000] imageWithRenderingMode:UIImageRenderingModeAutomatic] forState:UIControlStateNormal];
      //  leftBack.wj_normalImg([UIImage imageNamed:@"IMGNoramlBack"]);
        leftBack.adjustsImageWhenHighlighted = NO;
        [leftBack addTarget:self action:@selector(wj_goBack) forControlEvents:(UIControlEventTouchUpInside)];
       // [leftBack sizeThatFits:CGSizeMake(44, 44)];
        leftBack.frame = CGRectMake(0, 0, 44, 44);
        [view addSubview:leftBack];
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:view];
        self.navigationItem.leftBarButtonItem = barItem;
    }
}




/// 更改状态栏颜色
-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)dealloc {
    
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
