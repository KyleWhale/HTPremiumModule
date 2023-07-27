//
//  HTDBVipModel.h
//  Hucolla
//
//  Created by mac on 2022/9/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTDBVipModel : NSObject<YYModel>

@property (nonatomic, strong) NSString    * var_uuid;
@property (nonatomic, strong) NSString    * var_price;
@property (nonatomic, strong) NSString    * var_discount;
@property (nonatomic, strong) NSString    * var_vipId;
// 是否首次充值
@property (nonatomic, assign) BOOL          var_isFirst;
@property (nonatomic, strong) NSString    * var_start;
@property (nonatomic, strong) NSString    * var_end;

// 是否会员，购买立即生效，当前时间大于结束时间，会员失效
- (BOOL)ht_isVip;

@end

NS_ASSUME_NONNULL_END
