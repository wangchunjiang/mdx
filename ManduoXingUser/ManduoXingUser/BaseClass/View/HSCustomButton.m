//
//  HSCustomButton.m
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/25.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSCustomButton.h"

@implementation HSCustomButton
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat space = self.spaceBetweenTitleAndImage;//titleLabel和imageView之间的距离
    CGFloat titleW = CGRectGetWidth(self.titleLabel.bounds);//titleLabel的宽度
    
    
    CGFloat titleH = CGRectGetHeight(self.titleLabel.bounds);//titleLabel的高度
    
    CGFloat imageW = CGRectGetWidth(self.imageView.bounds);//imageView的宽度
    CGFloat imageH = CGRectGetHeight(self.imageView.bounds);//imageView的高度
    
    //    CGFloat btnCenterX = CGRectGetWidth(self.bounds)/2;//按钮中心点X的坐标（以按钮左上角为原点的坐标系）
    //    CGFloat imageCenterX = btnCenterX - titleW/2;//imageView中心点X的坐标（以按钮左上角为原点的坐标系）
    //    CGFloat titleCenterX = btnCenterX + imageW/2;//titleLabel中心点X的坐标（以按钮左上角为原点的坐标系）
    switch (self.imageAlignment)
    {
        case HSImageAlignmentTop:
        {
            self.imageEdgeInsets = UIEdgeInsetsMake(-titleH-space/2.0, 0, 0, -titleW);
            self.titleEdgeInsets  = UIEdgeInsetsMake(0, -imageW, -imageH-space/2.0, 0);
        }
            break;
        case HSImageAlignmentLeft:
        {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case HSImageAlignmentBottom:
        {
            
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, -titleH-space/2.0, -titleW);
            self.titleEdgeInsets = UIEdgeInsetsMake(-imageH-space/2.0, -imageW, 0, 0);
        }
            break;
        case HSImageAlignmentRight:
        {
            
            self.imageEdgeInsets = UIEdgeInsetsMake(0, titleW+space/2.0, 0, -titleW-space/2.0);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageW-space/2.0, 0, imageW+space/2.0);
        }
            break;
        default:
            break;
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
