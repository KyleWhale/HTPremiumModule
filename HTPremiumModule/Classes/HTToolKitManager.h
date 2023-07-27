//
//  HTToolKitManager.h
//  Ziven
//
//  Created by 李雪健 on 2023/5/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTToolKitManager : NSObject

// 单例
+ (HTToolKitManager *)shared;

#pragma mark - strip_product
// 保存strip_product
- (void)lgjeropj_save_strip_product:(NSDictionary *)dic;

// strip_product
- (NSDictionary *)lgjeropj_strip_product;

// 假商品列表
- (NSDictionary *)lgjeropj_server_products;

// 需要隐藏的正式产品
- (NSArray *)lgjeropj_hidden_products;

// 引导文案相关
- (NSDictionary *)lgjeropj_strip_p1;

// 引导文案相关
- (NSDictionary *)lgjeropj_strip_p2;

// Vip活动页是否展示
// 0=不显示 1=显示
// [0, '', '']
// [1, '', 'month']
- (NSArray *)lgjeropj_strip_k3;

// 总开关 是否走投屏工具包
// 0=否 1=是
- (NSInteger)lgjeropj_strip_k12;

// 工具包购买完成回来后是否强制登录
// 0=否 1=是
- (NSInteger)lgjeropj_strip_k13;

#pragma mark - toolkit
// 保存 airplay
- (void)lgjeropj_save_airplay:(NSDictionary *)dic;

// airplay
- (NSDictionary *)lgjeropj_airplay;

- (BOOL)lgjeropj_installed;

@end

NS_ASSUME_NONNULL_END
