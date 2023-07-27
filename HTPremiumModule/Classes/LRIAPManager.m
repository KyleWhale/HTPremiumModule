//
//  LRIAPManager.m

//
//  Created by Raymond Lee on 2018/1/13.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "LRIAPManager.h"
#import "HTPayMaiDianManager.h"
#import "HTStripeProduct.h"
#import "HTDBVipModel.h"
#import "HTHttpRequest.h"
#import "SVProgressHUD.h"

@interface LRIAPManager ()

@property (nonatomic, strong) HTStripeProduct *var_stripe_reqeust;
@property (nonatomic, copy) NSString *var_productIdStr;
@property (nonatomic, assign) BOOL var_restoreTips;
@property (nonatomic, assign) BOOL var_verifyflag;
@property (nonatomic, assign) BOOL var_refresh;
@property (nonatomic, assign) BOOL var_isRqinfo;
@property (nonatomic, assign) BOOL var_restorePay;

@end

@implementation LRIAPManager

static LRIAPManager *manager;
+ (instancetype)iapInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LRIAPManager alloc] init];
    });
    
    return manager;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        // 购买监听写在程序入口,程序挂起时移除监听,这样如果有未完成的订单将会自动执行并回调 paymentQueue:updatedTransactions:方法
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        self.var_stripe_reqeust = [[HTStripeProduct alloc] init];
    }
    return self;
}
- (void)dealloc{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}
#pragma mark- 苹果内支付
- (void)lgjeropj_iapRestorePurchaseStatus:(BOOL)var_showTips {
    self.var_productIdStr = nil;
    self.var_verifyflag = YES;
    self.var_restorePay = YES;
    self.var_restoreTips = NO;
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
    if (var_showTips) {
        self.var_restoreTips = var_showTips;
        NSString *var_ghlleeStr = AsciiString(@"Restoring...");// Restoring...
        [SVProgressHUD showInfoWithStatus:[HTCommonConfiguration lgjeropj_shared].BLOCK_switchStateBlock() ? LocalString(@"Restoring...", nil) : var_ghlleeStr];
    }
}
//点击购买
- (void)lgjeropj_purchaseWithPID:(NSString *)var_pidStr andBlock:(BLOCK_PayCheckBlock)block {
    self.var_checkBlock = block;
    [self lgjeropj_iapPurchaseWithID:var_pidStr];

    __weak typeof(self) weakSelf = self;
    [LRIAPManager iapInstance].var_paySuccessBlock = ^(NSString *var_product, BOOL var_flag) {
        weakSelf.var_checkBlock(YES, 1, var_product);
    };
    [LRIAPManager iapInstance].var_payFailedBlock = ^(NSString *errorInfo, BOOL var_flag) {
        weakSelf.var_checkBlock(NO, 1, errorInfo);
    };
}

// Restore
- (void)lgjeropj_restorePurchaseStatusWithBlock:(BLOCK_PayRestoreBlock)block {
    self.var_restoreBlock = block;
    [self lgjeropj_iapRestorePurchaseStatus:YES];

    __weak typeof(self) weakSelf = self;
    [LRIAPManager iapInstance].var_paySuccessBlock = ^(NSString *var_product, BOOL var_flag) {
        weakSelf.var_restoreBlock(YES, 1);
    };
    [LRIAPManager iapInstance].var_payFailedBlock = ^(NSString *errorInfo, BOOL var_flag) {
        weakSelf.var_restoreBlock(NO, 1);
    };
}

- (void)lgjeropj_iapPurchaseWithID:(NSString *)var_pidStr{
    self.var_productIdStr = nil;
    self.var_verifyflag = YES;
    self.var_restorePay = NO;
    if (var_pidStr) {
        [SVProgressHUD show];
        if ([SKPaymentQueue canMakePayments]) {
            self.var_productIdStr = var_pidStr;
            [self lgjeropj_requestProductData:self.var_productIdStr];
        }else{
            [SVProgressHUD dismiss];
            NSString *var_tipStr = [HTCommonConfiguration lgjeropj_shared].BLOCK_switchStateBlock() ? LocalString(@"Your phone is not allowed to purchase by Apple.", nil) : AsciiString(@"Your phone is not allowed to purchase by Apple.");
            [SVProgressHUD showInfoWithStatus:var_tipStr];
            if (self.var_payFailedBlock) {
                self.var_payFailedBlock(var_tipStr,self.var_verifyflag);
            }
        }
    } else {
        // 商品id为空
        if (self.var_payFailedBlock) {
            self.var_payFailedBlock(@"empty",self.var_verifyflag);
        }
    }
}

#pragma mark- 商品信息请求&回调
- (void)lgjeropj_getIapProductsListWithRefresh:(BOOL)var_refresh {
    self.var_refresh = var_refresh;
    self.var_isRqinfo = YES;
    // 请求所有产品信息
    NSArray *var_product = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%@_%@", HT_IPA_Mosh, HT_IPA_Month], HT_IPA_Month, HT_IPA_Week, HT_IPA_Year, [NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Week], [NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Month], [NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Year], nil];
    NSSet *var_nsset = [NSSet setWithArray:var_product];
    SKProductsRequest *var_request = [[SKProductsRequest alloc] initWithProductIdentifiers:var_nsset];
    var_request.delegate = self;
    [var_request start];
}
- (void)lgjeropj_requestProductData:(NSString *)type{
    self.var_isRqinfo = NO;
    // 请求对应的产品信息
    NSArray *var_product = [[NSArray alloc] initWithObjects:type,nil];
    
    NSSet *var_nsset = [NSSet setWithArray:var_product];
    SKProductsRequest *var_request = [[SKProductsRequest alloc] initWithProductIdentifiers:var_nsset];
    var_request.delegate = self;
    [var_request start];
}
//收到产品返回信息
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    NSArray *var_product = response.products;
    if([var_product count] <= 0){
        // 没有商品
        [SVProgressHUD dismiss];
        if (self.var_payFailedBlock) {
            self.var_payFailedBlock(@"empty",self.var_verifyflag);
        }
        return;
    }
    
    if (self.var_isRqinfo) {
        // 所有商品信息
        for (SKProduct *var_pro in var_product) {
            NSMutableDictionary *var_productDic = [NSMutableDictionary dictionary];
            [var_productDic setValue:var_pro.productIdentifier forKey:@"id"];
            if (![[NSUserDefaults standardUserDefaults] boolForKey:@"udf_isIAPDiscount"]) {
                [var_productDic setValue:[LRIAPManagerTwo localizedTrialDuraion:var_pro] forKey:AsciiString(@"discount")];
            }
            NSNumberFormatter *var_formatter = [[NSNumberFormatter alloc]init];
            var_formatter.locale = var_pro.priceLocale;
            var_formatter.numberStyle = NSNumberFormatterDecimalStyle;
            var_formatter.decimalSeparator = @".";
            [var_productDic setValue:[var_formatter stringFromNumber:var_pro.price] forKey:AsciiString(@"price")];
            var_formatter.numberStyle = NSNumberFormatterCurrencyStyle;
            [var_productDic setValue:var_formatter.currencySymbol forKey:AsciiString(@"unit")];
            if ([var_pro.productIdentifier containsString:AsciiString(@"week")]) {
                [var_productDic setValue:[NSString stringWithFormat:@"%d", 7] forKey:AsciiString(@"count")];
            } else if ([var_pro.productIdentifier containsString:AsciiString(@"month")]) {
                [var_productDic setValue:[NSString stringWithFormat:@"%d", 30] forKey:AsciiString(@"count")];
            } else if ([var_pro.productIdentifier containsString:AsciiString(@"year")]) {
                [var_productDic setValue:[NSString stringWithFormat:@"%d", 365] forKey:AsciiString(@"count")];
            }
            [self.var_productArray addObject:var_productDic];
        }
        [[NSUserDefaults standardUserDefaults] setObject:self.var_productArray.copy forKey:@"udf_iap_products"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if (self.var_refresh) {
            self.var_refresh = NO;
            self.var_verifyflag = NO;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NTFCTString_UpdateVIPStatusAndProductsInfo" object:nil];
    }else {
        SKProduct *var_p = nil;
        for (SKProduct *var_pro in var_product) {
            if([var_pro.productIdentifier isEqualToString:self.var_productIdStr]){
                var_p = var_pro;
            }
        }
        // 发送购买请求
        if (var_p != nil) {
            SKMutablePayment *var_sharGrey = [SKMutablePayment paymentWithProduct:var_p];
            if (var_sharGrey) {
                [[SKPaymentQueue defaultQueue] addPayment:var_sharGrey];
            } else {
                // 没有符合商品
                [SVProgressHUD dismiss];
                if (self.var_payFailedBlock) {
                    self.var_payFailedBlock(@"empty",self.var_verifyflag);
                }
                return;
            }
        } else {
            // 没有符合商品
            [SVProgressHUD dismiss];
            if (self.var_payFailedBlock) {
                self.var_payFailedBlock(@"empty",self.var_verifyflag);
            }
            return;
        }
    }
}

//请求失败
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    [self lgjeropj_muteVerify];
    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    if (self.var_payFailedBlock) {
        self.var_payFailedBlock(error.localizedDescription,self.var_verifyflag);
    }
}
- (void)requestDidFinish:(SKRequest *)request{

}
- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error{
    
    [SVProgressHUD dismiss];
    ZQAccountModel *var_model = [HTCommonConfiguration lgjeropj_shared].BLOCK_userBlock();
    if ([var_model.var_userid integerValue] > 0) {
        // 如果restore失败且登录则走接口验证
        [self lgjeropj_iapVerifyWithReceipt:nil andflag:NO];
        return;
    }
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"udf_muteVerify"]) {
        self.var_payVerifyBlock([[NSUserDefaults standardUserDefaults] integerForKey:@"udf_muteVerify"]);
    } else if (self.var_restorePay) {
        if (self.var_restoreTips) {
            [SVProgressHUD showInfoWithStatus:[HTCommonConfiguration lgjeropj_shared].BLOCK_switchStateBlock() ? LocalString(@"Failed Restore, please contact us by email.", nil) : AsciiString(@"Failed Restore, please contact us by email.")];
        } else {
            [self lgjeropj_iapVerifyWithReceipt:nil andflag:NO];
        }
    } else {
        [SVProgressHUD showInfoWithStatus:[HTCommonConfiguration lgjeropj_shared].BLOCK_switchStateBlock() ? LocalString(@"Failed purchase, does not incur costs.", nil) : AsciiString(@"Failed purchase, does not incur costs.")];
    }
    if (self.var_payFailedBlock) {
        self.var_payFailedBlock(error.localizedDescription, self.var_verifyflag);
    }
}
- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue {
    if (!self.var_restoreTips) {
        [self lgjeropj_iapVerifyWithReceipt:nil andflag:NO];
    } else if (![self lgjeropj_receipt]) {
        [self lgjeropj_muteVerify];
    }
}

- (NSString *)lgjeropj_receipt {
    NSString *var_string = [[NSData dataWithContentsOfURL:[[NSBundle mainBundle] appStoreReceiptURL]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return var_string;
}

//监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transaction{
    if (transaction.count > 1) {
        NSArray *var_sortedArray = [transaction sortedArrayUsingComparator:^(id obj1, id obj2) {
            SKPaymentTransaction *var_tran1 = obj1;
            SKPaymentTransaction *var_tran2 = obj2;
            if ([var_tran2.transactionDate timeIntervalSinceDate:var_tran1.transactionDate] >= 0) {
                return NSOrderedAscending;
            } else {
                return NSOrderedDescending;
            }
        }];
        [self lgjeropj_updatedTransaction:var_sortedArray.lastObject];
    } else if (transaction.count == 1) {
        [self lgjeropj_updatedTransaction:transaction.firstObject];
    } else {
        [SVProgressHUD dismiss];
        if (self.var_payFailedBlock) {
            self.var_payFailedBlock(AsciiString(@"no Buy"), self.var_verifyflag);
        }
        [self lgjeropj_iapVerifyWithReceipt:nil andflag:NO];
    }
}

- (void)lgjeropj_updatedTransaction:(SKPaymentTransaction *)var_tran {
    if (var_tran.transactionState == SKPaymentTransactionStatePurchased) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"udf_isIAPDiscount"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[SKPaymentQueue defaultQueue] finishTransaction:var_tran];
        if (![HTCommonConfiguration lgjeropj_shared].BLOCK_switchStateBlock()) {
            [self lgjeropj_iapVerifyWithAppleStoreSandBox:IAP_AppStore];
        } else {
            if (self.var_restorePay == NO) {
                if (self.var_productIdStr) {
                    [self lgjeropj_iapVerifyWithReceipt:var_tran andflag:YES];
                } else {
                    [self lgjeropj_iapVerifyWithReceipt:var_tran andflag:NO];
                }
            }
        }
    } else if (var_tran.transactionState == SKPaymentTransactionStateRestored) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"udf_isIAPDiscount"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[SKPaymentQueue defaultQueue] finishTransaction:var_tran];
        if (![HTCommonConfiguration lgjeropj_shared].BLOCK_switchStateBlock()) {
            [self lgjeropj_iapVerifyWithAppleStoreSandBox:IAP_AppStore];
        } else {
            if ([[NSUserDefaults standardUserDefaults] integerForKey:@"udf_muteVerify"] == 2) {
                [self lgjeropj_iapVerifyWithAppleStoreSandBox:IAP_AppStore];
            }else {
                [self lgjeropj_iapVerifyWithReceipt:var_tran andflag:YES];
            }
        }
    } else if (var_tran.transactionState == SKPaymentTransactionStateFailed) {// 交易失败
        [[SKPaymentQueue defaultQueue] finishTransaction:var_tran];
        [SVProgressHUD dismiss];
        if ([[NSUserDefaults standardUserDefaults] integerForKey:@"udf_muteVerify"] == 2) {
            self.var_payVerifyBlock(2);
        } else if (self.var_restorePay) {
            if (self.var_restoreTips) {
                [SVProgressHUD showInfoWithStatus:[HTCommonConfiguration lgjeropj_shared].BLOCK_switchStateBlock() ? LocalString(@"Failed Restore, please contact us by email.", nil) : AsciiString(@"Failed Restore, please contact us by email.")];
            } else {
                [self lgjeropj_iapVerifyWithReceipt:nil andflag:NO];
            }
        } else {
            [SVProgressHUD showInfoWithStatus:[HTCommonConfiguration lgjeropj_shared].BLOCK_switchStateBlock()?LocalString(@"Failed purchase, does not incur costs.", nil) : AsciiString(@"Failed purchase, does not incur costs.")];
        }
        if (self.var_payFailedBlock) {
            self.var_payFailedBlock(var_tran.error.localizedDescription,self.var_verifyflag);
        }
    } else if (var_tran.transactionState == SKPaymentTransactionStatePurchasing) {
        
    } else {
        [SVProgressHUD dismiss];
        [[SKPaymentQueue defaultQueue] finishTransaction:var_tran];
    }
}

//交易结束
- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

#pragma mark- 验证
- (void)lgjeropj_verifyProductsInFinishLaunching {
    @weakify(self);
    if ([self lgjeropj_receipt]) {// IAP订单存在
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"udf_muteVerify"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self lgjeropj_iapVerifyWithAppleStoreSandBox:IAP_AppStore];
        [LRIAPManager iapInstance].var_payVerifyBlock = ^(NSInteger type) {
            @strongify(self);
            [self lgjeropj_getStripeProductsList];
            [self lgjeropj_iapRestorePurchaseStatus:NO];
        };
    } else {
        [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"udf_muteVerify"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self lgjeropj_iapRestorePurchaseStatus:NO];
        [LRIAPManager iapInstance].var_payVerifyBlock = ^(NSInteger type) {
            @strongify(self);
            [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"udf_muteVerify"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self lgjeropj_getStripeProductsList];
        };
    }
    //埋点
    [[HTPayMaiDianManager shareInstance] lgjeropj_maidian:1];
}

- (void)lgjeropj_getStripeProductsList {
    
    @weakify(self);
    [self.var_stripe_reqeust lgjeropj_request:^{
        @strongify(self);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NTFCTString_showVipGuide" object:nil];
        [self lgjeropj_getIapProductsListWithRefresh:YES];
    }];
}

- (void)lgjeropj_iapVerifyWithReceipt:(SKPaymentTransaction *)var_transaction andflag:(BOOL)var_bflag {
    ZQAccountModel *var_result = [HTCommonConfiguration lgjeropj_shared].BLOCK_userBlock();
    NSUserDefaults *var_defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *var_params = [NSMutableDictionary dictionary];
    NSString *var_receiptString = nil;
    if (var_bflag) {
        var_receiptString = [self lgjeropj_receipt];
        if (self.var_restorePay) {
            self.var_productIdStr = var_transaction.payment.productIdentifier;
            [var_params setValue:self.var_productIdStr forKey:AsciiString(@"pid")];
            [var_params setValue:@"0" forKey:AsciiString(@"flag")];
        } else {
            if (self.var_productIdStr != nil && ![self.var_productIdStr isEqualToString:@""]) {
                [var_params setValue:self.var_productIdStr forKey:AsciiString(@"pid")];
            } else {
                [var_params setValue:@"0" forKey:AsciiString(@"pid")];
            }
            [var_params setValue:@"1" forKey:AsciiString(@"flag")];
        }
    } else {
        var_receiptString = [var_defaults stringForKey:@"udf_receiptString"];
        NSString *var_identifier = [var_defaults stringForKey:@"udf_productIdentifier"];
        if (var_identifier != nil && ![var_identifier isEqualToString:@""]) {
            [var_params setObject:var_identifier forKey:AsciiString(@"pid")];
        } else {
            [var_params setObject:@"0" forKey:AsciiString(@"pid")];
        }
        [var_params setObject:@"0" forKey:AsciiString(@"flag")];
    }
    if ((var_receiptString == nil || [var_receiptString isEqualToString:@""]) && var_bflag) {
        [var_defaults setBool:NO forKey:@"udf_isLocalIapVip"];
        [self lgjeropj_muteVerify];
        if (self.var_payFailedBlock && var_bflag) {
            self.var_payFailedBlock(AsciiString(@"no Receipt"),self.var_verifyflag);
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NTFCTString_UpdateVIPStatusAndProductsInfo" object:nil];
        return;
    }

    [var_params setObject:(var_result.var_userid ?: @"0") forKey:AsciiString(@"uid")];
    [var_params setObject:(var_result.var_fid ?: @"0") forKey:AsciiString(@"fid")];
    [var_params setObject:(var_receiptString ?: @"") forKey:AsciiString(@"receipt")];

    NSString *var_url = @"";
    if ([[var_params objectForKey:AsciiString(@"flag")] isEqualToString:@"1"]) {
        var_url = [NSString stringWithFormat:@"%d", 325];
    } else {
        var_url = [NSString stringWithFormat:@"%d", 326];
    }
    [var_params setValue:[var_defaults boolForKey:@"udf_isLocalIapVip"]?@"1":@"0" forKey:AsciiString(@"vp")];
    @weakify(self);
    [[HTHttpRequest sharedManager] ht_post:var_url andParameters:var_params andCompletion:^(HTResponseModel *var_model, NSError * _Nonnull error) {
        @strongify(self);
        if ([var_model isKindOfClass:[HTResponseModel class]]) {
            NSDictionary *var_dataDict = var_model.data;
            if ([[var_params objectForKey:AsciiString(@"flag")] isEqualToString:@"1"]) {
                [HTCommonConfiguration lgjeropj_shared].BLOCK_subscribeEventBlock();
            }
            NSDictionary *var_localDic = [var_dataDict objectForKey:AsciiString(@"local")];
            if (var_localDic.count > 0) {
                [var_defaults setBool:[[var_localDic objectForKey:AsciiString(@"auto_renew_status")] boolValue] forKey:@"udf_iap_sub"];
                if (var_bflag) {
                    [var_defaults setObject:var_receiptString forKey:@"udf_receiptString"];
                    [var_defaults setObject:var_transaction.payment.productIdentifier forKey:@"udf_productIdentifier"];
                    [var_defaults setInteger:[[var_localDic objectForKey:AsciiString(@"k7")] integerValue] forKey:@"udf_iap_startTime"];
                    [var_defaults setInteger:[[var_localDic objectForKey:AsciiString(@"k6")] integerValue] forKey:@"udf_iap_expireTime"];
                    [[SKPaymentQueue defaultQueue] finishTransaction:var_transaction];
                } else if (self.var_productIdStr) {
                    [var_defaults setObject:self.var_productIdStr forKey:@"udf_productIdentifier"];
                    [var_defaults setInteger:[[var_localDic objectForKey:AsciiString(@"k7")] integerValue] forKey:@"udf_iap_startTime"];
                    [var_defaults setInteger:[[var_localDic objectForKey:AsciiString(@"k6")] integerValue] forKey:@"udf_iap_expireTime"];
                }
                
                if ([[var_localDic objectForKey:AsciiString(@"value")] integerValue] == 1) {
                    [var_defaults setBool:YES forKey:@"udf_isLocalIapVip"];
                } else {
                    [var_defaults setBool:NO forKey:@"udf_isLocalIapVip"];
                }
                                
                NSString *var_isTrialPeriodStr = [NSString stringWithFormat:@"%@", [var_localDic objectForKey:AsciiString(@"is_trial_period")]];
                NSString *var_isInIntroOfferPeriodStr = [NSString stringWithFormat:@"%@", [var_localDic objectForKey:AsciiString(@"is_in_intro_offer_period")]];
                if ([var_isTrialPeriodStr isEqualToString:@"true"] || [var_isInIntroOfferPeriodStr isEqualToString:@"true"] || [var_defaults boolForKey:@"udf_isIAPDiscount"]) {
                    for (NSMutableDictionary *var_product in self.var_productArray) {
                        if ([var_product objectForKey:AsciiString(@"discount")] != nil) {
                            [var_product removeObjectForKey:AsciiString(@"discount")];
                        }
                    }
                    [var_defaults setObject:self.var_productArray.copy forKey:@"udf_iap_products"];
                }
                [var_defaults synchronize];
            }
            
            NSDictionary *var_severDic = [var_dataDict objectForKey:AsciiString(@"server")];
            if (var_severDic.count > 0) {
                ZQAccountModel *var_result = [HTCommonConfiguration lgjeropj_shared].BLOCK_userBlock();
                if ([var_result.var_userid integerValue] > 0) {
                    if ([[var_severDic objectForKey:@"logout"] integerValue] == 1) {
                        [[LRIAPManager iapInstance] lgjeropj_logoutAndUpdatePurchaseStatus];
                    } else {
                        var_result.var_toolVip = [[var_severDic objectForKey:AsciiString(@"t1")] integerValue] == 2 ? @"1" : @"0";
                        var_result.var_bindPlanState = [var_severDic objectForKey:@"val2"] != nil?[NSString stringWithFormat:@"%@", [var_severDic objectForKey:@"val2"]]:@"0";
                        var_result.var_bindStartTime = [var_severDic objectForKey:AsciiString(@"k7")] != nil ? [NSString stringWithFormat:@"%@", [var_severDic objectForKey:AsciiString(@"k7")]]:@"0";
                        var_result.var_bindEndTime = [var_severDic objectForKey:AsciiString(@"k6")] != nil ?[NSString stringWithFormat:@"%@", [var_severDic objectForKey:AsciiString(@"k6")]]:@"0";
                        var_result.var_bindPid = [var_severDic objectForKey:AsciiString(@"pid")] != nil?[NSString stringWithFormat:@"%@", [var_severDic objectForKey:AsciiString(@"pid")]]:@"0";
                        var_result.var_bindRenewStatus = [NSString stringWithFormat:@"%@", [var_severDic objectForKey:AsciiString(@"auto_renew_status")]];
                        var_result.var_bindAppId = [var_severDic objectForKey:@"app_id"] != nil?[NSString stringWithFormat:@"%@", [var_severDic objectForKey:@"app_id"]]:@"0";
                        var_result.var_bindAppName = [var_severDic objectForKey:@"app_name"] != nil?[NSString stringWithFormat:@"%@", [var_severDic objectForKey:@"app_name"]]:@"";
                        var_result.var_bindAppOs = [var_severDic objectForKey:@"app_os"] != nil?[NSString stringWithFormat:@"%@", [var_severDic objectForKey:@"app_os"]]:@"";
                        var_result.var_bindMail = [var_severDic objectForKey:AsciiString(@"mail")] != nil?[NSString stringWithFormat:@"%@", [var_severDic objectForKey:AsciiString(@"mail")]]:@"";
                        var_result.var_bindShelf = [var_severDic objectForKey:@"shelf"] != nil?[NSString stringWithFormat:@"%@", [var_severDic objectForKey:@"shelf"]]:@"0";
                        var_result.var_bindUbt = [var_severDic objectForKey:@"ubt"] != nil?[NSString stringWithFormat:@"%@", [var_severDic objectForKey:@"ubt"]]:@"0";
                        
                        NSDictionary *var_familyDic = [var_dataDict objectForKey:AsciiString(@"family")];
                        if (var_familyDic.count > 0) {
                            var_result.var_familyPlanState = [var_familyDic objectForKey:AsciiString(@"val")] != nil ? [NSString stringWithFormat:@"%@", [var_familyDic objectForKey:AsciiString(@"val")]]:@"0";
                            var_result.var_identity = [var_familyDic objectForKey:AsciiString(@"master")] != nil?[NSString stringWithFormat:@"%@", [var_familyDic objectForKey:AsciiString(@"master")]]:@"";
                            var_result.var_fid = [var_familyDic objectForKey:AsciiString(@"fid")] != nil?[NSString stringWithFormat:@"%@", [var_familyDic objectForKey:AsciiString(@"fid")]]:@"";
                            var_result.var_pid = [var_familyDic objectForKey:AsciiString(@"pid")] != nil?[NSString stringWithFormat:@"%@", [var_familyDic objectForKey:AsciiString(@"pid")]]:@"";
                            var_result.var_renewStatus = [var_familyDic objectForKey:AsciiString(@"auto_renew_status")] != nil?[NSString stringWithFormat:@"%@", [var_familyDic objectForKey:AsciiString(@"auto_renew_status")]]:@"";
                            var_result.var_vipStartTime = [var_familyDic objectForKey:AsciiString(@"k7")] != nil?[NSString stringWithFormat:@"%@", [var_familyDic objectForKey:AsciiString(@"k7")]]:@"";
                            var_result.var_vipEndTime = [var_familyDic objectForKey:AsciiString(@"k6")] != nil?[NSString stringWithFormat:@"%@", [var_familyDic objectForKey:AsciiString(@"k6")]]:@"";
                        }
                        [HTCommonConfiguration lgjeropj_shared].BLOCK_saveUserBlock(var_result);
                    }
                }
            }
            
            NSDictionary *var_deviceDic = [var_dataDict objectForKey:AsciiString(@"device")];
            [var_defaults setBool:NO forKey:@"udf_isDeviceVip"];
            if (var_deviceDic.count > 0) {
                if ([[var_deviceDic objectForKey:AsciiString(@"val")] integerValue] == 1) {
                    [var_defaults setBool:YES forKey:@"udf_isDeviceVip"];
                    [var_defaults setInteger:[[var_deviceDic objectForKey:@"k7"] integerValue] forKey:@"udf_devicStartTime"];
                    [var_defaults setInteger:[[var_deviceDic objectForKey:@"k6"] integerValue] forKey:@"udf_deviceEndTime"];
                    [var_defaults setObject:[var_deviceDic objectForKey:AsciiString(@"pid")] forKey:@"udf_devicePid"];
                } else {
                    [var_defaults setBool:NO forKey:@"udf_isDeviceVip"];
                }
                NSInteger var_f1 = [[var_deviceDic objectForKey:AsciiString(@"f1")] integerValue] == 1;
                if (var_f1 > 0) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"NTFCTString_RemindAddFamilyMember" object:nil];
                }
                [var_defaults synchronize];
            }
            // 检查是否需要登录
            [self ht_checkLogin];
            HTDBVipModel *model = [[HTDBVipModel alloc] init];
            if (self.var_paySuccessBlock && var_bflag && [model ht_isVip]) {
                self.var_paySuccessBlock(self.var_productIdStr,self.var_verifyflag);
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NTFCTString_UpdateVIPStatusAndProductsInfo" object:nil];
            [self lgjeropj_muteVerify];
            //埋点
            [[HTPayMaiDianManager shareInstance] lgjeropj_maidian:var_bflag ? 3 : 4];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NTFCTString_UpdateVIPStatusAndProductsInfo" object:nil];
            [self lgjeropj_muteVerify];
            if (self.var_payFailedBlock && var_bflag) {
                NSString *d2Str = AsciiString(@"no Internet");//no Internet
                self.var_payFailedBlock(d2Str,self.var_verifyflag);
            }
        }
    }];
}

- (void)ht_checkLogin {
    
    [HTCommonConfiguration lgjeropj_shared].BLOCK_checkLoginBlock();
}

- (void)lgjeropj_muteVerify {
    NSUserDefaults *var_defaults = [NSUserDefaults standardUserDefaults];
    if ([var_defaults integerForKey:@"udf_muteVerify"]) {
        self.var_payVerifyBlock([var_defaults integerForKey:@"udf_muteVerify"]);
    }
    [SVProgressHUD dismiss];
}
// 向苹果验证(含沙盒)
- (void)lgjeropj_iapVerifyWithAppleStoreSandBox:(NSString *)var_iapUrlStr {
    __weak typeof(self) weakSelf = self;
    [LRIAPManagerTwo lgjeropj_iapVerifyWithAppleStoreSandBox:var_iapUrlStr andBlock:^(NSInteger code, NSData *data) {
        if (code == 1) {
            [weakSelf lgjeropj_handleAppleStoreAndSandBoxData:data];
        } else {
            [weakSelf lgjeropj_muteVerify];
        }
    }];
}
- (void)lgjeropj_handleAppleStoreAndSandBoxData:(NSData *)data {
    NSUserDefaults *var_defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *var_dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if([[var_dic objectForKey:AsciiString(@"status")] intValue] == 0){
        NSDictionary *var_dicInApp = [[var_dic objectForKey:AsciiString(@"latest_receipt_info")] firstObject];
        [var_defaults setObject:[var_dicInApp objectForKey:AsciiString(@"product_id")] forKey:@"udf_productIdentifier"];
        NSString *var_expireString = [NSString stringWithFormat:@"%@_%@_%@", AsciiString(@"expires"), AsciiString(@"date"), AsciiString(@"ms")];
        [var_defaults setDouble:([[var_dicInApp objectForKey:var_expireString] doubleValue] / 1000) forKey:@"udf_iap_expireTime"];
        double var_nowdate = [[NSDate date] timeIntervalSince1970];
        if ([var_defaults doubleForKey:@"udf_iap_expireTime"] > var_nowdate) {
            [var_defaults setBool:YES forKey:@"udf_isLocalIapVip"];
            if (![HTCommonConfiguration lgjeropj_shared].BLOCK_switchStateBlock() && self.var_paySuccessBlock) {
                self.var_paySuccessBlock(self.var_productIdStr,self.var_verifyflag);
            }
        } else {
            [var_defaults setBool:NO forKey:@"udf_isLocalIapVip"];
        }
        [var_defaults synchronize];
        [self lgjeropj_muteVerify];
    }else if ([[var_dic objectForKey:AsciiString(@"status")] intValue] == 21007) {
        [self lgjeropj_iapVerifyWithAppleStoreSandBox:IAP_SANDBOX];
    }else{
        [self lgjeropj_muteVerify];
    }
}

- (void)lgjeropj_logoutAndUpdatePurchaseStatus {
    
    [HTCommonConfiguration lgjeropj_shared].BLOCK_toLogoutBlock();
    [self lgjeropj_iapVerifyWithReceipt:nil andflag:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NTFCTString_UpdateUserDisplayInformation" object:nil];
}

- (NSMutableArray *)var_productArray {
    if (!_var_productArray) {
        _var_productArray = [NSMutableArray array];
    }
    return _var_productArray;
}

@end
