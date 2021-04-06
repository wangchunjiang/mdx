//
//  HSBaseShowView.m
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/25.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSBaseShowView.h"

@implementation HSBaseShowView
- (instancetype)initWithFrame:(CGRect)frame
{
    //如果size为0使用全屏大小
    if (frame.size.width == 0)
    {
        frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }
    if (self = [super initWithFrame:frame])
    {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gesureTapBG:)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        self.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:.5];
  
    }
    [self initView];
    return self;
}

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}



- (void)initView
{
    
}
#pragma mark - UserInteraction

- (void)gesureTapBG:(UITapGestureRecognizer *)sender
{
    
    if (self.bNeedClickDissmiss) [self dismiss];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
       
    if(![touch.view isKindOfClass:[HSBaseShowView class]]){
        return NO;
    }
    return YES;
}

- (void)show
{
    [[UIApplication sharedApplication].windows.firstObject addSubview:self];
}

- (void)dismiss
{
    [self removeFromSuperview];     // 从window中移除视图
}

- (void)configViewWithModel:(id)model
{
    
}

- (void)dealloc
{
    NSLog(@"弹窗类视图被销毁了");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
