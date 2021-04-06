//
//  HSGiftViewController.m
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/27.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSGiftViewController.h"
#import "HSGiftModel.h"
#import "HSGiftShowManager.h"
@interface HSGiftViewController ()

@end

@implementation HSGiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(100, 600, 50, 50);
    btn1.backgroundColor = UIColor.redColor;
    btn1.tag = 101;
    [btn1 setTitle:@"user1" forState:(UIControlStateNormal)];
    [self.view addSubview:btn1];
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    
    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
      btn2.frame = CGRectMake(160, 600, 50, 50);
      btn2.backgroundColor = UIColor.redColor;
      [btn2 setTitle:@"user2" forState:(UIControlStateNormal)];
      btn2.tag = 102;
      [self.view addSubview:btn2];
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
       
    
    
    UIButton * btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(220, 600, 50, 50);
    btn3.backgroundColor = UIColor.redColor;
     btn3.tag = 103;
    [btn3 setTitle:@"user3" forState:(UIControlStateNormal)];
    [self.view addSubview:btn3];
    
    [btn3 addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
       
    
    UIButton * btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
     btn4.frame = CGRectMake(280, 600, 50, 50);
      btn4.tag = 104;
     btn4.backgroundColor = UIColor.redColor;
     [btn4 setTitle:@"user4" forState:(UIControlStateNormal)];
     [self.view addSubview:btn4];
    
    [btn4 addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
       
    
}

-(void)btnClick:(UIButton*)btn{
     HSGiftModel *giftModel = [[HSGiftModel alloc] init];
    if (btn.tag == 101) {
   
          giftModel.userIcon = @"";
           giftModel.userName = @"user1";
           giftModel.giftName = @"礼物1";
           giftModel.giftImage = @"";
           giftModel.giftGifImage = @"";
           giftModel.giftId = @"1";
           giftModel.defaultCount = 0;
           giftModel.sendCount = 1;
           
    }else if (btn.tag == 102){
        giftModel.userIcon = @"";
        giftModel.userName = @"user2";
        giftModel.giftName = @"礼物2";
        giftModel.giftImage = @"";
        giftModel.giftGifImage = @"";
        giftModel.giftId = @"2";
        giftModel.defaultCount = 0;
        giftModel.sendCount = 2;
        
        
    }else if (btn.tag == 103){
        giftModel.userIcon = @"";
               giftModel.userName = @"user3";
               giftModel.giftName = @"礼物3";
               giftModel.giftImage = @"";
               giftModel.giftGifImage = @"";
               giftModel.giftId = @"3";
               giftModel.defaultCount = 0;
               giftModel.sendCount = 3;
        
        
        
    }else if (btn.tag == 104){
        giftModel.userIcon = @"";
               giftModel.userName = @"user4";
               giftModel.giftName = @"礼物4";
               giftModel.giftImage = @"";
               giftModel.giftGifImage = @"";
               giftModel.giftId = @"4";
               giftModel.defaultCount = 0;
               giftModel.sendCount = 4;
        
        
        
    }
    
    [[HSGiftShowManager sharedManager] showGiftViewWithBackView:self.view info:giftModel completeBlock:^(BOOL finished) {
               //结束
               }
    ];
    
    
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
