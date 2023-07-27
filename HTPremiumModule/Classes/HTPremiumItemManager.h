//
//  HTPremiumVipItemManager.h
//  Moshfocus
//
//  Created by 李雪健 on 2023/6/7.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTPremiumItemManager : NSObject

+ (UIView *)lgjeropj_line;

+ (UILabel *)lgjeropj_vipLabel;

+ (UIImageView *)lgjeropj_trialImage;

+ (UILabel *)lgjeropj_discountLabel;

+ (UILabel *)lgjeropj_symbolLabel;

+ (UILabel *)lgjeropj_priceLabel;

+ (UILabel *)lgjeropj_monLabel;

+ (UILabel *)lgjeropj_thenLabel;

+ (UILabel *)lgjeropj_disLabel;

+ (UILabel *)lgjeropj_countLabel;

+ (UIButton *)lgjeropj_payButton:(id)target action:(SEL)action;

+ (NSMutableAttributedString *)lgjeropj_getAttributeWithString:(NSString *)str;

+ (NSMutableAttributedString *)lgjeropj_getVipAttributeWithString:(NSString *)str font:(UIFont *)font color:(UIColor *)textColor;

+ (CGFloat)lgjeropj_getScale;

@end

NS_ASSUME_NONNULL_END
