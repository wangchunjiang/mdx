//
//  HSLoginVC.m
//  HappyLive
//
//  Created by wangchunjiang on 2021/3/27.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSLoginVC.h"
#import "HSLoginCodeView.h"
#import "HSOtherLoginView.h"
#import "HSOauthLoginVC.h"


#import "HSBindPhoneVC.h"

@interface HSLoginVC ()
@property(nonatomic,strong)HSLoginCodeView * loginCodeView;
@property(nonatomic,strong)HSOtherLoginView * otherLoginView;

@property(nonatomic,assign)BOOL protocolSelected;

@end

@implementation HSLoginVC

//-(void)viewWillAppear:(BOOL)animated{
//    
//    [self hiddenCustomNavBar];
//}
//-(void)viewWillDisappear:(BOOL)animated{
//    
//    [self showCustomNavBar];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [self.view addSubview:self.loginCodeView];
    [self.view addSubview:self.otherLoginView];
    
    MJWeakSelf
    [self.loginCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(0);
    }];
    
    [self.otherLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-Tabbar_heightMargen);
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.loginCodeView.otherLogin.mas_bottom).offset(RatioNumH(119));
        
    }];
    
    //隐私勾选
    [[self.otherLoginView.seletedBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        x.selected = !x.selected;
        weakSelf.protocolSelected = x.isSelected;
    
    }];
    
    //点击登录
    [[self.loginCodeView.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
       
        if (!weakSelf.protocolSelected) {
            [MSGHUD showToast:@"请勾隐私选协议"];
        }else{
            
            [weakSelf checkCanLogin];
        }
        
        
    }];
    
    [[self.loginCodeView.closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
    
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
        
    }];
    
    //验证码按钮
    [[self.loginCodeView.getCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
       
        [XSObject setCountDown:x];
    
        
    }];
    
    //一键登录
    [[self.loginCodeView.otherLogin rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
       
        HSOauthLoginVC * vc = [HSOauthLoginVC new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    }];
    
    
    [[self.otherLoginView.weChatLogin rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
       
        HSBindPhoneVC *  vc  =[HSBindPhoneVC new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
        
        
    }];
    
  
    
}

-(void)checkCanLogin{
    
    
    if (![HSCommonFunction isMobile:self.loginCodeView.phoneField.text]) {
        
        [MSGHUD showToast:@"请输入正确的手机号"];
        return;
    }
    
    if ([HSCommonFunction isBlankString:self.loginCodeView.codeField.text]) {
        
        [MSGHUD showToast:@"请输入验证码"];
        return;
    }

//    MJWeakSelf
//    [HSNetTool getLoginCodeWithPhone:self.loginCodeView.phoneField.text withCode:self.loginCodeView.codeField.text GetListData:^(NSDictionary * _Nonnull response) {
//        [SVProgressHUD showSuccessWithStatus:response[@"msg"]];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [SVProgressHUD dismiss];
//
//
//            [weakSelf loginIM];
//
//            [weakSelf dismissViewControllerAnimated:YES completion:nil];
//        });
//
//
//    } failure:^(id  _Nonnull error) {
//
//        HUD_HIDE_TEXT(error);
//    }];
    
    
    
    
}
//-(void)loginIM{
//    NSString *userID = [HSUserDataDefaults standardUserDefaults].userID;
//    userID = [userID stringByReplacingOccurrencesOfString:@"-" withString:@""];
//
//    NSString *userSig = [GenerateTestUserSig genTestUserSig:userID];
//
//    [HSUserDataDefaults standardUserDefaults].userSig = userSig;
//
//    MLVBLoginInfo *loginInfo = [MLVBLoginInfo new];
//    loginInfo.sdkAppID = SDKAPPID;
//    loginInfo.userID = userID;
//    loginInfo.userName = [HSUserDataDefaults standardUserDefaults].mobile;
//    loginInfo.userAvatar = @"headpic.png";
//    loginInfo.userSig = userSig;
//
//
//
//    IMMsgManager*msgMgr =  [[IMMsgManager alloc] initWithConfig:loginInfo];
//
//    //[[IMMsgManager alloc] initWithConfig:loginInfo];
//   // [msgMgr setDelegate:self];
//
//    MJWeakSelf
//    [msgMgr loginWithCompletion:^(int errCode, NSString *errMsg) {
//        if (errCode == 0) {
//          //  [weakSelf toastTip:@"IM登录成功"];
//            HUD_HIDE_TEXT(@"IM登录成功")
//        }else{
//
//          //  [weakSelf toastTip:@"IM登录失败"];
//            HUD_HIDE_TEXT(@"IM登录失败")
//        }
//
//    }];
//
//
//
//}

-(HSLoginCodeView*)loginCodeView{
    
    if (!_loginCodeView) {
        _loginCodeView = [[HSLoginCodeView alloc]initWithFrame:CGRectZero];
    }
    
    
    return _loginCodeView;
}
-(HSOtherLoginView*)otherLoginView{
    
    if (!_otherLoginView) {
        _otherLoginView = [[HSOtherLoginView alloc]initWithFrame:CGRectZero];
    }
    
    
    return _otherLoginView;
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
