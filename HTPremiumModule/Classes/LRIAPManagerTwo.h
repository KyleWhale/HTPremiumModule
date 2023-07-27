//
//  LRIAPManagerTwo.h
//  Merriciya
//
//  Created by dn on 2022/9/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LRIAPManagerTwo : NSObject
// 获取单人计划中周的价格,用于计算普通优惠的显示
+ (NSString *)lgjeropj_makeSinglePlanWeekPrice;
// 按照 月年周+是否有trial 调整顺序
+ (NSMutableArray *)lgjeropj_changeArrayOrder:(NSMutableArray *)var_array;
// IAP产品信息
+ (NSMutableArray *)lgjeropj_makeIapSingleData;
+ (NSDictionary *)localizedTrialDuraion:(SKProduct *)var_product;
+ (void)lgjeropj_iapVerifyWithAppleStoreSandBox:(NSString *)var_iapUrlStr andBlock:(void(^)(NSInteger code, NSData *data))block;

@end

NS_ASSUME_NONNULL_END
