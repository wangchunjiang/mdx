//
//  HSBindPhoneVC.m
//  HappyLive
//
//  Created by wangchunjiang on 2021/3/29.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSBindPhoneVC.h"
#import "HSLoginCodeView.h"
@interface HSBindPhoneVC ()
@property(nonatomic,strong)HSLoginCodeView *  bindMainView;
@end

@implementation HSBindPhoneVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.bindMainView];
    
    [self.bindMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
}
-(HSLoginCodeView*)bindMainView{
    
    if (!_bindMainView) {
        _bindMainView = [[HSLoginCodeView alloc]initWithFrame:CGRectZero];
        [_bindMainView.loginBtn setTitle:@"完成" forState:(UIControlStateNormal)];
        _bindMainView.otherLogin.hidden = YES;
    }
    
    
    return _bindMainView;
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
