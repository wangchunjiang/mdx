//
//  HSGiftShowManager.m
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/27.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSGiftShowManager.h"
#import "HSGiftShowView.h"
#import "HSGiftOperation.h"
#import "HSGiftModel.h"




//距离底部的间距
#define Bottom_Margin(margin) ((margin)+Tabbar_heightMargen)
static const NSInteger giftMaxNum = 99;
@interface HSGiftShowManager()
/** 队列 */
@property(nonatomic,strong) NSOperationQueue *giftQueue1;
@property(nonatomic,strong) NSOperationQueue *giftQueue2;
/** showgift */
@property(nonatomic,strong) HSGiftShowView *giftShowView1;
@property(nonatomic,strong) HSGiftShowView *giftShowView2;
/** 操作缓存 */
@property (nonatomic,strong) NSCache *operationCache;

@property(nonatomic,copy) completeBlock finishedBlock;
/** 当前礼物的keys */
@property(nonatomic,strong) NSMutableArray *curentGiftKeys;
/** showgif */
@property(nonatomic,copy)completeShowGifImageBlock completeShowGifImageBlock;
@end


@implementation HSGiftShowManager
- (NSOperationQueue *)giftQueue1{
    
    
    
    if (!_giftQueue1) {
        
        _giftQueue1 = [[NSOperationQueue alloc] init];
        _giftQueue1.maxConcurrentOperationCount = 1;
    }
    return _giftQueue1;
}

- (NSOperationQueue *)giftQueue2{
    
    if (!_giftQueue2) {
        
        _giftQueue2 = [[NSOperationQueue alloc] init];
        _giftQueue2.maxConcurrentOperationCount = 1;
    }
    return _giftQueue2;
}

- (NSMutableArray *)curentGiftKeys{
    
    if (!_curentGiftKeys) {
        
        _curentGiftKeys = [NSMutableArray array];
    }
    return _curentGiftKeys;
}

- (HSGiftShowView *)giftShowView1{
    
    if (!_giftShowView1) {
        CGFloat itemW = Screen_width/4.0;
        CGFloat itemH = itemW*105/93.8;
        
        __weak typeof(self) weakSelf = self;
        CGFloat showViewW = 10+showGiftView_UserIcon_LT+showGiftView_UserIcon_WH+showGiftView_UserName_L+showGiftView_UserName_W+showGiftView_GiftIcon_W+showGiftView_XNum_L+showGiftView_XNum_W;
        CGFloat showViewY = Screen_height-Bottom_Margin(44)-2*itemH-showGiftView_GiftIcon_H-10-15;
        _giftShowView1 = [[HSGiftShowView alloc] initWithFrame:CGRectMake(-showViewW, showViewY, showViewW, showGiftView_GiftIcon_H)];
        [_giftShowView1 setShowViewKeyBlock:^(HSGiftModel *giftModel) {
            [weakSelf.curentGiftKeys addObject:giftModel.giftKey];
            if (weakSelf.completeShowGifImageBlock) {
                weakSelf.completeShowGifImageBlock(giftModel);
            }
        }];
    }
    return _giftShowView1;
}

- (HSGiftShowView *)giftShowView2 {
    
    if (!_giftShowView2) {
        CGFloat itemW = Screen_width/4.0;
        CGFloat itemH = itemW*105/93.8;
        
        __weak typeof(self) weakSelf = self;
        CGFloat showViewW = 10+showGiftView_UserIcon_LT+showGiftView_UserIcon_WH+showGiftView_UserName_L+showGiftView_UserName_W+showGiftView_GiftIcon_W+showGiftView_XNum_L+showGiftView_XNum_W;
        CGFloat showViewY = Screen_height-Bottom_Margin(44)-2*itemH-showGiftView_GiftIcon_H*2-2*10-15;
        _giftShowView2 = [[HSGiftShowView alloc] initWithFrame:CGRectMake(-showViewW, showViewY, showViewW, showGiftView_GiftIcon_H)];
        [_giftShowView2 setShowViewKeyBlock:^(HSGiftModel *giftModel) {
            [weakSelf.curentGiftKeys addObject:giftModel.giftKey];
            if (weakSelf.completeShowGifImageBlock) {
                weakSelf.completeShowGifImageBlock(giftModel);
            }
        }];
    }
    return _giftShowView2;
}


- (NSCache *)operationCache
{
    if (_operationCache==nil) {
        _operationCache = [[NSCache alloc] init];
    }
    return _operationCache;
}

+ (instancetype)sharedManager {
    
    static HSGiftShowManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HSGiftShowManager alloc] init];
    });
    return manager;
}

- (void)showGiftViewWithBackView:(UIView *)backView info:(HSGiftModel *)giftModel completeBlock:(completeBlock)completeBlock {
    
    [self showGiftViewWithBackView:backView info:giftModel completeBlock:completeBlock completeShowGifImageBlock:nil];
}

- (void)showGiftViewWithBackView:(UIView *)backView info:(HSGiftModel *)giftModel completeBlock:(completeBlock)completeBlock completeShowGifImageBlock:(completeShowGifImageBlock)completeShowGifImageBlock {
    
    self.completeShowGifImageBlock = completeShowGifImageBlock;
    
    if (self.curentGiftKeys.count && [self.curentGiftKeys containsObject:giftModel.giftKey]) {
        //有当前的礼物信息
        if ([self.operationCache objectForKey:giftModel.giftKey]) {
            
            //当前存在操作
            HSGiftOperation *op = [self.operationCache objectForKey:giftModel.giftKey];
            //限制一次礼物的连击最大值
            if (op.giftShowView.currentGiftCount >= giftMaxNum) {
                //移除操作
                [self.operationCache removeObjectForKey:giftModel.giftKey];
                //清空唯一key
                [self.curentGiftKeys removeObject:giftModel.giftKey];
            }else {
                //赋值当前礼物数
                op.giftShowView.giftCount = giftModel.sendCount;
            }

        }else {
            
            NSOperationQueue *queue;
            HSGiftShowView *showView;

            if (self.giftQueue1.operations.count <= self.giftQueue2.operations.count) {
                queue = self.giftQueue1;
                showView = self.giftShowView1;
            }else {
                queue = self.giftQueue2;
                showView = self.giftShowView2;
            }
          
            //当前操作已结束 重新创建
            HSGiftOperation *operation = [HSGiftOperation addOperationWithView:showView OnView:backView Info:giftModel completeBlock:^(BOOL finished,NSString *giftKey) {
                if (self.finishedBlock) {
                    self.finishedBlock(finished);
                }
                //移除操作
                [self.operationCache removeObjectForKey:giftKey];
                //清空唯一key
                [self.curentGiftKeys removeObject:giftKey];
            }];
            operation.model.defaultCount += giftModel.sendCount;
            //存储操作信息
            [self.operationCache setObject:operation forKey:giftModel.giftKey];
            //操作加入队列
            [queue addOperation:operation];
        }

    }else {
        //没有礼物的信息
        if ([self.operationCache objectForKey:giftModel.giftKey]) {
            
            //当前存在操作
            HSGiftOperation *op = [self.operationCache objectForKey:giftModel.giftKey];
            //限制一次礼物的连击最大值
            if (op.model.defaultCount >= giftMaxNum) {
                //移除操作
                [self.operationCache removeObjectForKey:giftModel.giftKey];
                //清空唯一key
                [self.curentGiftKeys removeObject:giftModel.giftKey];
            }else {
                //赋值当前礼物数
                op.model.defaultCount += giftModel.sendCount;
            }

        }else {
            
            NSOperationQueue *queue;
            HSGiftShowView *showView;
            if (self.giftQueue1.operations.count <= self.giftQueue2.operations.count) {
                queue = self.giftQueue1;
                showView = self.giftShowView1;
            }else {
                queue = self.giftQueue2;
                showView = self.giftShowView2;
            }

         
            HSGiftOperation *operation = [HSGiftOperation addOperationWithView:showView OnView:backView Info:giftModel completeBlock:^(BOOL finished,NSString *giftKey) {
                if (self.finishedBlock) {
                    self.finishedBlock(finished);
                }
                if ([self.giftShowView1.finishModel.giftKey isEqualToString:self.giftShowView2.finishModel.giftKey]) {
                    return ;
                }
                //移除操作
                [self.operationCache removeObjectForKey:giftKey];
                //清空唯一key
                [self.curentGiftKeys removeObject:giftKey];
            }];
            operation.model.defaultCount += giftModel.sendCount;
            //存储操作信息
            [self.operationCache setObject:operation forKey:giftModel.giftKey];
            //操作加入队列
            [queue addOperation:operation];
        }
    }
}
@end
