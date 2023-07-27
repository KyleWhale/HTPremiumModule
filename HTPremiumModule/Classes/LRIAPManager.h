//
//  LRIAPManager.h

//
//  Created by Raymond Lee on 2018/1/13.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "LRIAPManagerTwo.h"

typedef void(^BLOCK_IapSuccessBlock)(NSString *var_product,BOOL var_flag);
typedef void(^BLOCK_IapFailedBlock)(NSString *errorInfo,BOOL var_flag);
typedef void(^BLOCK_IapVerifyBlock)(NSInteger type);
typedef void(^BLOCK_PayCheckBlock) (BOOL result,NSInteger source,NSString *var_urlStr);
typedef void(^BLOCK_PayRestoreBlock) (BOOL result,NSInteger source);

@interface LRIAPManager : NSObject<SKPaymentTransactionObserver,SKProductsRequestDelegate>

@property (nonatomic, assign) BOOL var_isPaying;
@property (nonatomic, strong) NSMutableArray *var_productArray;
@property (nonatomic, copy) BLOCK_PayCheckBlock var_checkBlock;
@property (nonatomic, copy) BLOCK_PayRestoreBlock var_restoreBlock;
@property (nonatomic, copy) BLOCK_IapSuccessBlock var_paySuccessBlock;
@property (nonatomic, copy) BLOCK_IapFailedBlock var_payFailedBlock;
@property (nonatomic, copy) BLOCK_IapVerifyBlock var_payVerifyBlock;

+ (instancetype)iapInstance;
- (void)lgjeropj_verifyProductsInFinishLaunching;
- (void)lgjeropj_getIapProductsListWithRefresh:(BOOL)var_refresh;
- (void)lgjeropj_purchaseWithPID:(NSString *)var_pidStr andBlock:(BLOCK_PayCheckBlock)block;
- (void)lgjeropj_restorePurchaseStatusWithBlock:(BLOCK_PayRestoreBlock)block;
- (void)lgjeropj_iapVerifyWithReceipt:(SKPaymentTransaction *)var_transaction andflag:(BOOL)var_bflag;
- (void)lgjeropj_logoutAndUpdatePurchaseStatus;
@end
