//
//  HSGiftOperation.m
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/27.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSGiftOperation.h"
#import "HSGiftShowView.h"
#import "HSGiftModel.h"

@interface HSGiftOperation ()
@property (nonatomic, getter = isFinished)  BOOL finished;

@property (nonatomic, getter = isExecuting) BOOL executing;
@end
@implementation HSGiftOperation
@synthesize finished = _finished;
@synthesize executing = _executing;
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _executing = NO;
        _finished  = NO;
    }
    return self;
}

+ (instancetype)addOperationWithView:(HSGiftShowView *)giftShowView OnView:(UIView *)backView Info:(HSGiftModel *)model completeBlock:(completeOpBlock)completeBlock {
    
    HSGiftOperation *op = [[HSGiftOperation alloc] init];
    op.giftShowView = giftShowView;
    op.model = model;
    op.backView = backView;
    op.opFinishedBlock = completeBlock;
    return op;

}

- (void)start {
    
    if ([self isCancelled]) {
        _finished = YES;
        return;
    }
    
    _executing = YES;
    NSLog(@"当前队列-- %@",self.model.giftName);
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        [self.backView addSubview:self.giftShowView];
        [self.giftShowView showGiftShowViewWithModel:self.model completeBlock:^(BOOL finished,NSString *giftKey) {
            self.finished = finished;
            if (self.opFinishedBlock) {
                self.opFinishedBlock(finished,giftKey);
            }
        }];
    }];
    
}

#pragma mark -  手动触发 KVO
- (void)setExecuting:(BOOL)executing
{
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)setFinished:(BOOL)finished
{
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

@end
