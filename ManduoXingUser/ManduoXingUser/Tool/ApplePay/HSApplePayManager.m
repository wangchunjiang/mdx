//
//  HSApplePayManager.m
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/30.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSApplePayManager.h"
@interface HSApplePayManager()<SKProductsRequestDelegate,SKPaymentTransactionObserver>
{
    NSString *_purchID;
    IAPCompletionHandleBlock _handle;
}

@end
@implementation HSApplePayManager
+(instancetype)shareIAPManager{
    
    static HSApplePayManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HSApplePayManager alloc]init];
    });
    
    return manager;
}

- (instancetype)init {
    if ([super init]) {
        // 购买监听写在程序入口,程序挂起时移除监听,这样如果有未完成的订单将会自动执行并回调 paymentQueue:updatedTransactions:方法
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    return self;
}
- (void)dealloc{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

//添加内购产品
- (void)addPurchWithProductID:(NSString *)product_id completeHandle:(IAPCompletionHandleBlock)handle {
    //移除上次未完成的交易订单
    
    [SVProgressHUD show];
    [self removeAllUncompleteTransactionBeforeStartNewTransaction];
    if (product_id) {
        if ([SKPaymentQueue canMakePayments]) {
            // 开始购买服务
            _purchID = product_id;
            _handle = handle;
            NSSet *nsset = [NSSet setWithArray:@[product_id]];
            SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
            request.delegate = self;
            [request start];
        }else{
            [SVProgressHUD dismiss];
            [self handleActionWithType:IAPPurchNotArrow data:nil];
        }
    }
}

- (void)handleActionWithType:(IAPPurchType)type data:(NSData *)data{
    
    [SVProgressHUD dismiss];
    switch (type) {
        
        case IAPPurchSuccess:
            // [[NSNotificationCenter defaultCenter]postNotificationName:@"buyResult" object:nil userInfo:@{@"type":[NSString stringWithFormat:@"%@",@"0"]}];
            [XSObject showMassage:@"购买成功"];
            _handle(0,data);
            break;
        case IAPPurchFailed:
           //  [[NSNotificationCenter defaultCenter]postNotificationName:@"buyResult" object:nil userInfo:@{@"type":[NSString stringWithFormat:@"%@",@"1"]}];

              [XSObject showMassage:@"购买失败"];
              _handle(1,data);
            break;
        case IAPPurchCancel:
            // [[NSNotificationCenter defaultCenter]postNotificationName:@"buyResult" object:nil userInfo:@{@"type":[NSString stringWithFormat:@"%@",@"2"]}];
          
             [XSObject showMassage:@"支付取消"];
               _handle(2,data);
            break;
        case IAPPurchVerFailed:
            // [[NSNotificationCenter defaultCenter]postNotificationName:@"buyResult" object:nil userInfo:@{@"type":[NSString stringWithFormat:@"%@",@"3"]}];
         
             [XSObject showMassage:@"订单校验失败"];
               _handle(3,data);
            break;
        case IAPPurchVerSuccess:
           //  [[NSNotificationCenter defaultCenter]postNotificationName:@"buyResult" object:nil userInfo:@{@"type":[NSString stringWithFormat:@"%@",@"4"]}];
    
            [XSObject showMassage:@"订单校验成功"];
             _handle(4,nil);
            
            break;
        case IAPPurchNotArrow:
         //   [[NSNotificationCenter defaultCenter]postNotificationName:@"buyResult" object:nil userInfo:@{@"type":[NSString stringWithFormat:@"%@",@"5"]}];

            [XSObject showMassage:@"不允许程序内付费"];
             _handle(5,nil);
            break;
        default:
            break;
    }
}
#pragma mark - SKProductsRequestDelegate// 交易结束
- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    // Your application should implement these two methods.
    NSString * productIdentifier = transaction.payment.productIdentifier;
    NSData *data = [productIdentifier dataUsingEncoding:NSUTF8StringEncoding];
    NSString *receipt = [data base64EncodedStringWithOptions:0];
    
    NSLog(@"receipt===%@",receipt);
    
    if ([productIdentifier length] > 0) {
        // 向自己的服务器验证购买凭证
        NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:[receiptURL path]]) {
            // 取 receipt 的时候要判空,如果文件不存在,就要从苹果服务器重新刷新下载 receipt 了
            // SKReceiptRefreshRequest 刷新的时候,需要用户输入 Apple ID,同时需要网络状态良好
            SKReceiptRefreshRequest *receiptRefreshRequest = [[SKReceiptRefreshRequest alloc] initWithReceiptProperties:nil];
            receiptRefreshRequest.delegate = self;
            [receiptRefreshRequest start];
            return;
        }
        NSData *data = [NSData dataWithContentsOfURL:receiptURL];
        /** 交易凭证*/
        NSString *receipt_data = [data base64EncodedStringWithOptions:0];
        /** 事务标识符(交易编号)  交易编号(必传:防止越狱下内购被破解,校验 in_app 参数)*/
        NSString *transaction_id = transaction.transactionIdentifier;
        NSString *goodID = transaction.payment.productIdentifier;
        
        //这里缓存receipt_data，transaction_id 因为后端做校验的时候需要用到这两个字段
      //  [JLKJLocalCacheUserInfo savePurchasedInfoWithReceipt_data:receipt_data transaction_id:transaction_id orderId:self.idNo];
        
        NSLog(@"receipt_data==%@",receipt_data);
        NSLog(@"transaction_id===%@",transaction_id);
        
        [self retquestApplePay:receipt_data transaction_id:transaction_id goodsID:goodID];
    }
        
    [self verifyPurchaseWithPaymentTransaction:transaction isTestServer:NO];
    
    
}

//向自己的服务器验证
- (void)retquestApplePay:(NSString *)receipt_data transaction_id:(NSString *)transaction_id goodsID:(NSString *)goodsId {
    NSMutableDictionary *param = [NSMutableDictionary new];
    
    param[@"transactionId"] = transaction_id;
    param[@"receiptData"] = receipt_data;
   // param[@"orderId"] = self.idNo;
    NSLog(@"param===%@",param);
    
//     [HttpsRequest requestPOSTWithURLString:KConfirmCredentials params:param successful:^(NSDictionary * result) {
//
//         NSLog(@"%@",result);
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"buyResult" object:nil userInfo:@{@"type":@"6"}];//验证成功
//        //验证成功，清除本地缓存
//         [JLKJLocalCacheUserInfo removePurchasedInfo];
//
//     } failure:^(NSError * error) {
//
//     }];
    
}
// 交易失败
- (void)failedTransaction:(SKPaymentTransaction *)transaction{
    if (transaction.error.code != SKErrorPaymentCancelled) {
        [self handleActionWithType:IAPPurchFailed data:nil];
    }else{
        [self handleActionWithType:IAPPurchCancel data:nil];
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)verifyPurchaseWithPaymentTransaction:(SKPaymentTransaction *)transaction isTestServer:(BOOL)flag{
    //交易验证
    NSURL *recepitURL = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receipt = [NSData dataWithContentsOfURL:recepitURL];
    
    if(!receipt){
        // 交易凭证为空验证失败
        [self handleActionWithType:IAPPurchVerFailed data:nil];
        return;
    }
    // 购买成功将交易凭证发送给服务端进行再次校验
    [self handleActionWithType:IAPPurchSuccess data:receipt];
    
    NSError *error;
    NSDictionary *requestContents = @{
                                      @"receipt-data": [receipt base64EncodedStringWithOptions:0]
                                      };
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestContents
                                                          options:0
                                                            error:&error];
    
    if (!requestData) { // 交易凭证为空验证失败
        [self handleActionWithType:IAPPurchVerFailed data:nil];
        return;
    }
    
    //In the test environment, use https://sandbox.itunes.apple.com/verifyReceipt
    //In the real environment, use https://buy.itunes.apple.com/verifyReceipt
    
#ifdef DEBUG
#define serverString @"https://sandbox.itunes.apple.com/verifyReceipt"
#else
#define serverString @"https://buy.itunes.apple.com/verifyReceipt"
#endif
    
    NSURL *storeURL = [NSURL URLWithString:serverString];
    NSMutableURLRequest *storeRequest = [NSMutableURLRequest requestWithURL:storeURL];
    [storeRequest setHTTPMethod:@"POST"];
    [storeRequest setHTTPBody:requestData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [session dataTaskWithRequest:storeRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            // 无法连接服务器,购买校验失败
            [self handleActionWithType:IAPPurchVerFailed data:nil];
        } else {
            NSError *error;
            NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            if (!jsonResponse) {
                // 苹果服务器校验数据返回为空校验失败
                [self handleActionWithType:IAPPurchVerFailed data:nil];
            }
            
            // 先验证正式服务器,如果正式服务器返回21007再去苹果测试服务器验证,沙盒测试环境苹果用的是测试服务器
            NSString *status = [NSString stringWithFormat:@"%@",jsonResponse[@"status"]];
            if (status && [status isEqualToString:@"21007"]) {
                [self verifyPurchaseWithPaymentTransaction:transaction isTestServer:YES];
            }else if(status && [status isEqualToString:@"0"]){
                [self handleActionWithType:IAPPurchVerSuccess data:nil];
            }
            NSLog(@"----验证结果 %@",jsonResponse);
        }
    }];
    
    // 验证成功与否都注销交易,否则会出现虚假凭证信息一直验证不通过,每次进程序都得输入苹果账号
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

#pragma mark - SKProductsRequestDelegate
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    NSArray *product = response.products;
    if([product count] <= 0){
        NSLog(@"--------------没有商品------------------");
        return;
    }
    
    SKProduct *p = nil;
    for(SKProduct *pro in product){
        if([pro.productIdentifier isEqualToString:_purchID]){
            p = pro;
            break;
        }
    }
    
    NSLog(@"productID:%@", response.invalidProductIdentifiers);
    NSLog(@"产品付费数量:%lu",(unsigned long)[product count]);
    NSLog(@"%@",[p description]);
    NSLog(@"%@",[p localizedTitle]);
    NSLog(@"%@",[p localizedDescription]);
    NSLog(@"%@",[p price]);
    NSLog(@"%@",[p productIdentifier]);
    
    SKPayment *payment = [SKPayment paymentWithProduct:p];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

//请求失败
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"------------------错误-----------------:%@", error);
}

- (void)requestDidFinish:(SKRequest *)request{
    NSLog(@"------------反馈信息结束-----------------");
}

#pragma mark - SKPaymentTransactionObserver 监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions{
    for (SKPaymentTransaction *tran in transactions) {
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:tran];
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"商品添加进列表");
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"已经购买过商品");
                // 消耗型不支持恢复购买
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:tran];
                break;
            default:
                break;
        }
    }
}

#pragma mark -- 结束上次未完成的交易 防止串单
-(void)removeAllUncompleteTransactionBeforeStartNewTransaction{
    NSArray* transactions = [SKPaymentQueue defaultQueue].transactions;
    if (transactions.count > 0) {
        //检测是否有未完成的交易
        SKPaymentTransaction* transaction = [transactions firstObject];
        if (transaction.transactionState == SKPaymentTransactionStatePurchased) {
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            return;
        }
    }
}
@end
