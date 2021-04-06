//
//  HSOauthLoginVC.m
//  HappyLive
//
//  Created by wangchunjiang on 2021/3/29.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSOauthLoginVC.h"
#import "HSOauthLoginView.h"
@interface HSOauthLoginVC ()
@property(nonatomic,strong)HSOauthLoginView * oauthLoginView;

@end

@implementation HSOauthLoginVC


//-(void)viewWillAppear:(BOOL)animated{
//    [self hiddenCustomNavBar];
//    
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.oauthLoginView];
    [self.oauthLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    MJWeakSelf
    [[self.oauthLoginView.closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    [[self.oauthLoginView.oauthLoginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    
}
-(HSOauthLoginView*)oauthLoginView{
    
    if (!_oauthLoginView) {
        _oauthLoginView = [[HSOauthLoginView alloc]initWithFrame:CGRectZero];
    }
    
    
    return _oauthLoginView;
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
