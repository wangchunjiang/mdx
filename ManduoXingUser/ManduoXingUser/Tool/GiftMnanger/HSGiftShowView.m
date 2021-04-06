//
//  HSGiftShowView.m
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/27.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSGiftShowView.h"
#import "HSGiftModel.h"
static const NSInteger animationTime = 3;
@implementation HSGiftShowView
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //245 50
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;
        [self createUI];
    }
    return self;
}

#pragma mark -设置UI
- (void)createUI {
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width-showGiftView_XNum_W-showGiftView_XNum_L, showGiftView_GiftIcon_H)];
    self.bgView.backgroundColor = [UIColor grayColor];
    self.bgView.layer.cornerRadius = showGiftView_GiftIcon_H*0.5;
    [self addSubview:self.bgView];
    
    self.userIconView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.bgView.frame)+showGiftView_UserIcon_LT, showGiftView_UserIcon_LT, showGiftView_UserIcon_WH, showGiftView_UserIcon_WH)];
    self.userIconView.layer.cornerRadius = showGiftView_UserIcon_WH*0.5;
    self.userIconView.layer.masksToBounds = YES;
    [self addSubview:self.userIconView];
    
    self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.userIconView.frame)+showGiftView_UserName_L, (showGiftView_GiftIcon_H-2*showGiftView_UserName_H-5)*0.5, showGiftView_UserName_W, showGiftView_UserName_H)];
    self.userNameLabel.text = @"张三";
    self.userNameLabel.textColor = [UIColor whiteColor];
    self.userNameLabel.font = [UIFont systemFontOfSize:11];
    [self addSubview:self.userNameLabel];
    
    self.giftNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.userNameLabel.frame),CGRectGetMaxY(self.userNameLabel.frame)+5, showGiftView_UserName_W*2, showGiftView_UserName_H)];
    self.giftNameLabel.text = @"礼物";
    self.giftNameLabel.textColor = [UIColor colorWithRed:255/255.0 green:214/255.0 blue:84/255.0 alpha:1];
    self.giftNameLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.giftNameLabel];
    
    self.giftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.userNameLabel.frame), 0, showGiftView_GiftIcon_W, showGiftView_GiftIcon_H)];
    [self addSubview:self.giftImageView];
    
    self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.giftImageView.frame)+showGiftView_XNum_L, (showGiftView_GiftIcon_H-showGiftView_XNum_H)*0.5, showGiftView_XNum_W, showGiftView_XNum_H)];
    self.countLabel.textColor = [UIColor redColor];
    self.countLabel.font = [UIFont systemFontOfSize:20];
    self.countLabel.textAlignment = NSTextAlignmentCenter;
    self.countLabel.text = @"";
    [self addSubview:self.countLabel];

}

- (void)showGiftShowViewWithModel:(HSGiftModel *)giftModel completeBlock:(completeShowViewBlock)completeBlock{
    
    self.finishModel = giftModel;
    [self.userIconView sd_setImageWithURL:[NSURL URLWithString:giftModel.userIcon] placeholderImage:[UIImage imageNamed:@""]];
    self.userNameLabel.text = giftModel.userName;
    self.giftNameLabel.text = [NSString stringWithFormat:@"送 %@",giftModel.giftName];
    [self.giftImageView sd_setImageWithURL:[NSURL URLWithString:giftModel.giftImage] placeholderImage:[UIImage imageNamed:@""]];
    self.hidden = NO;
    self.showViewFinishBlock = completeBlock;
    NSLog(@"当前展示的礼物--%@",giftModel.giftName);
    if (self.showViewKeyBlock && self.currentGiftCount == 0) {
        self.showViewKeyBlock(giftModel);
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.frame =CGRectMake(0, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        
        self.currentGiftCount = 0;
        [self setGiftCount:giftModel.defaultCount];
        
    }];}

- (void)hiddenGiftShowView {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame =CGRectMake(-self.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        
        if (self.showViewFinishBlock) {
            self.showViewFinishBlock(YES, self.finishModel.giftKey);
            self.finishModel = nil;
        }
        self.frame =CGRectMake(-self.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height);

        self.hidden = YES;
        self.currentGiftCount = 0;
        self.countLabel.text = @"";
    }];
}

- (void)setGiftCount:(NSInteger)giftCount {
    
    _giftCount = giftCount;
    self.currentGiftCount += giftCount;
    self.countLabel.text = [NSString stringWithFormat:@"x %zd",self.currentGiftCount];
    NSLog(@"累计礼物数 %zd",self.currentGiftCount);
    if (self.currentGiftCount > 1) {
        [self startAnimation:self.countLabel];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hiddenGiftShowView) object:nil];//可以取消成功。
        [self performSelector:@selector(hiddenGiftShowView) withObject:nil afterDelay:animationTime];
        
    }else {
        [self performSelector:@selector(hiddenGiftShowView) withObject:nil afterDelay:animationTime];
    }
}

- (void)startAnimation:(UIView *)view {
    
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.08;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:1.0];
    pulse.toValue= [NSNumber numberWithFloat:2.5];
    [[view layer] addAnimation:pulse forKey:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
