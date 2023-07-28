//
//  HTGuidePaymentViewManager.h
//  Moshfocus
//
//  Created by 李雪健 on 2023/6/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTGuidePaymentViewManager : NSObject

+ (UIButton *)lgjeropj_cancelButton:(id)target action:(SEL)action;

+ (UIButton *)lgjeropj_buyButton:(id)target action:(SEL)action;

+ (UIButton *)lgjeropj_chooseMoreButton:(id)target action:(SEL)action;

+ (UIImageView *)lgjeropj_iconView;

+ (UILabel *)lgjeropj_topLabel;

+ (UILabel *)lgjeropj_centerLabel;

+ (UILabel *)lgjeropj_priceLabel;

+ (UIImageView *)lgjeropj_trialView;

@end

NS_ASSUME_NONNULL_END
