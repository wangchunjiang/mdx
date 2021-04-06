//
//  HSGiftModel.m
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/27.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSGiftModel.h"

@implementation HSGiftModel
- (NSString *)giftKey {
    
    return [NSString stringWithFormat:@"%@%@",self.giftName,self.giftId];
}
@end
