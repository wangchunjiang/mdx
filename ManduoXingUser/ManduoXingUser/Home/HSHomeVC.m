//
//  HSHomeVC.m
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/25.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSHomeVC.h"
#import "HSLivePlayVC.h"
#import "HSDanMuVC.h"
#import "HSApplePayManager.h"
#import "HSLocationVC.h"
@interface HSHomeVC ()
{
    
    UIView * view1;
}

@end

@implementation HSHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hiddenBack = YES;
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = UIColor.redColor;
    [btn setTitle:@"直播" forState:(UIControlStateNormal)];
    [self.view addSubview:btn];
    
    
    
    MJWeakSelf
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        HSLivePlayVC * playVC = [HSLivePlayVC new];
        [weakSelf.navigationController pushViewController:playVC animated:YES];
    }];
    
    
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
       btn1.frame = CGRectMake(230, 100, 100, 100);
       btn1.backgroundColor = UIColor.redColor;
       [btn1 setTitle:@"测试" forState:(UIControlStateNormal)];
       [self.view addSubview:btn1];
    
    
    [[btn1 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
//          HSDanMuVC * vc = [HSDanMuVC new];
//          [weakSelf.navigationController pushViewController:vc animated:YES];
        [MSGHUD showToast:@"保存成功保存成功成功"];
      }];
    
    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(100, 220, 100, 100);
    btn2.backgroundColor = UIColor.redColor;
    [btn2 setTitle:@"内购" forState:(UIControlStateNormal)];
    [self.view addSubview:btn2];
    
    
    
    UILabel * sandBoxlabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 330, Screen_width-20, 100)];
    sandBoxlabel.font = kFont(12);
    sandBoxlabel.text = @"内购沙盒账号:18305814283@qq.com \n Wcj123456";
    sandBoxlabel.numberOfLines = 0;
    [self.view addSubview:sandBoxlabel];
    
    UIButton * btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
     btn3.frame = CGRectMake(230, 220, 100, 100);
     btn3.backgroundColor = UIColor.redColor;
     [btn3 setTitle:@"地图" forState:(UIControlStateNormal)];
     [self.view addSubview:btn3];
   
     [[btn3 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
               HSLocationVC * vc = [ HSLocationVC new];
               [weakSelf.navigationController pushViewController:vc animated:YES];
              
       }];
     
    
    
      [[btn2 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
          [[HSApplePayManager shareIAPManager]addPurchWithProductID:@"com.pincll.manduoxinguserDemo1100" completeHandle:^(IAPPurchType type, NSData * _Nonnull data) {
             
              NSLog(@"IAPPurchType====%d",type);
              
          }];
           
    }];
    
    
    view1 = [[UIView alloc]initWithFrame:CGRectMake(100, 500, 40, 40)];
    //圆角设置
    view1.layer.masksToBounds = YES;
    view1.layer.cornerRadius = 20;
    view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:view1];

    [self AddAniamtionLikeGameCenterBubble];
    
  
   // [SVProgressHUD show];
    
}

-(void)AddAniamtionLikeGameCenterBubble{

    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;  //动画均匀进行
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.repeatCount = INFINITY;
    //线性运动
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.duration = 5.0;

    //除了xy方向的扩大缩小，泡泡的位置按椭圆形轨迹运动
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGRect circleContainer = CGRectInset(view1.frame, view1.bounds.size.width / 2 -10, view1.bounds.size.width / 2 -5);
  //  CGRect circleContainer = CGRectMake(200, 200, 10, 5);
    //该方法 会按给定rect搞出一个内切圆出来，可以是椭圆
    CGPathAddEllipseInRect(curvedPath, NULL, circleContainer);

    pathAnimation.path = curvedPath;
    //在上面通过creat创建出来的，需要释放
    CGPathRelease(curvedPath);
    [view1.layer addAnimation:pathAnimation forKey:@"CircleAnimation"];

//    CAKeyframeAnimation *scaleX = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
//    scaleX.duration = 1;
//    scaleX.values = @[@1.0, @1.1, @1.0];
//    scaleX.keyTimes = @[@0.0, @0.5, @1.0];
//    //无线循环
//    scaleX.repeatCount = INFINITY;
//    scaleX.autoreverses = YES;
//    //运动时间函数 这个是先快后慢再快
//    scaleX.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//
//    [view1.layer addAnimation:scaleX forKey:@"scaleXAnimation"];
//
//
//    CAKeyframeAnimation *scaleY = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
//    scaleY.duration = 1.5;
//    scaleY.values = @[@1.0, @1.1, @1.0];
//    scaleY.keyTimes = @[@0.0, @0.5, @1.0];
//    scaleY.repeatCount = INFINITY;
//    scaleY.autoreverses = YES;
//    scaleX.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    [view1.layer addAnimation:scaleY forKey:@"scaleYAnimation"];
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
