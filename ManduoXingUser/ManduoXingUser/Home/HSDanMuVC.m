//
//  HSDanMuVC.m
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/29.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSDanMuVC.h"
#import "HSLiveChatListView.h"
@interface HSDanMuVC ()
@property(nonatomic,strong)HSLiveChatListView * chatView;

@property(nonatomic,strong)NSMutableArray * sourceArr;
@end

@implementation HSDanMuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"聊天列表";
    [self showCustomNavBar];
    
    [self.view addSubview:self.chatView];
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
     btn.backgroundColor = UIColor.redColor;
     [self.view addSubview:btn];
    
    
    MJWeakSelf
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        HSLiveChatModel * model = [HSLiveChatModel new];
        model.name = [NSString stringWithFormat:@"张%d:",arc4random()%2];
        model.content = [NSString stringWithFormat:@"你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好你好==你好%d",arc4random()%2];
        
        [weakSelf.chatView receiveMsg:model];
        
        
        
        
    }];
    
    
    
    
    
}

-(NSMutableArray*)sourceArr{
    if (!_sourceArr) {
        _sourceArr = @[].mutableCopy;
    }
    
    return _sourceArr;
}

-(HSLiveChatListView*)chatView{
    if (!_chatView) {
        _chatView = [[HSLiveChatListView alloc]initWithFrame:CGRectMake(0, Screen_height-Tabbar_heightMargen-400, Screen_width, 300)];
    }
    
    return _chatView;
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
