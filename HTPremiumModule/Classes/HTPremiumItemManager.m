//
//  HTPremiumVipItemManager.m
//  Moshfocus
//
//  Created by 李雪健 on 2023/6/7.
//

#import "HTPremiumItemManager.h"

@implementation HTPremiumItemManager

+ (UIView *)lgjeropj_line {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    return view;
}

+ (UILabel *)lgjeropj_vipLabel {
    
    return [HTKitCreate ht_labelWithText:@"" andFont:[UIFont systemFontOfSize:14*[self lgjeropj_getScale] weight:(UIFontWeightBold)] andTextColor:[UIColor colorWithHexString:@"#685034"] andAligment:NSTextAlignmentLeft andNumberOfLines:1];
}

+ (UIImageView *)lgjeropj_trialImage {
    
    UIImageView *view = [[UIImageView alloc] init];
    [view sd_setImageWithURL:[LKFPrivateFunction lgjeropj_imageUrlFromNumber:192]];
    return view;
}

+ (UILabel *)lgjeropj_discountLabel {
    
    return [HTKitCreate ht_labelWithText:@"" andFont:[UIFont systemFontOfSize:12*[self lgjeropj_getScale] weight:(UIFontWeightRegular)] andTextColor:[UIColor colorWithHexString:@"#685034"] andAligment:NSTextAlignmentRight andNumberOfLines:1];
}

+ (UILabel *)lgjeropj_symbolLabel {
    
    return [HTKitCreate ht_labelWithText:@"$" andFont:[UIFont systemFontOfSize:14*[self lgjeropj_getScale] weight:(UIFontWeightRegular)] andTextColor:[UIColor colorWithHexString:@"#685034"] andAligment:NSTextAlignmentCenter andNumberOfLines:1];
}

+ (UILabel *)lgjeropj_priceLabel {
    
    return [HTKitCreate ht_labelWithText:@"" andFont:[UIFont systemFontOfSize:32*[self lgjeropj_getScale] weight:(UIFontWeightBold)] andTextColor:[UIColor colorWithHexString:@"#685034"] andAligment:NSTextAlignmentLeft andNumberOfLines:1];
}

+ (UILabel *)lgjeropj_monLabel {
    
    return [HTKitCreate ht_labelWithText:@"" andFont:[UIFont systemFontOfSize:12*[self lgjeropj_getScale] weight:(UIFontWeightRegular)] andTextColor:[UIColor colorWithHexString:@"#685034"] andAligment:NSTextAlignmentLeft andNumberOfLines:2];
}

+ (UILabel *)lgjeropj_thenLabel {
    
    return [HTKitCreate ht_labelWithText:@"" andFont:[UIFont systemFontOfSize:12*[self lgjeropj_getScale] weight:(UIFontWeightRegular)] andTextColor:[UIColor colorWithHexString:@"#685034"] andAligment:NSTextAlignmentLeft andNumberOfLines:2];
}

+ (UILabel *)lgjeropj_disLabel {
    
    return [HTKitCreate ht_labelWithText:@"" andFont:[UIFont systemFontOfSize:10*[self lgjeropj_getScale] weight:(UIFontWeightBold)] andTextColor:[UIColor colorWithHexString:@"#FFFFFF"] andAligment:NSTextAlignmentCenter andNumberOfLines:1];
}

+ (UILabel *)lgjeropj_countLabel {
    
    return [HTKitCreate ht_labelWithText:AsciiString(@"Discount") andFont:[UIFont systemFontOfSize:10*[self lgjeropj_getScale] weight:(UIFontWeightRegular)] andTextColor:[UIColor colorWithHexString:@"#222222"] andAligment:NSTextAlignmentCenter andNumberOfLines:1];
}

+ (UIButton *)lgjeropj_payButton:(id)target action:(SEL)action {
    
    UIButton *view = [HTKitCreate ht_buttonWithImage:nil andTitle:LocalString(@"Get Premium", nil) andFont:[UIFont systemFontOfSize:16*[self lgjeropj_getScale] weight:(UIFontWeightBold)] andTextColor:[UIColor whiteColor] andState:UIControlStateNormal];
    view.cornerRadius = 16*[self lgjeropj_getScale];
    [view addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    view.backgroundColor = [UIColor colorWithHexString:@"#685034"];
    return view;
}

+ (NSMutableAttributedString *)lgjeropj_getAttributeWithString:(NSString *)str {
    
    CGFloat scale = [self lgjeropj_getScale];
    HTAttributedManager *manager = [[HTAttributedManager alloc] initWithText:str andFont:HTPingFangRegularFont(12*scale) andForegroundColor:[UIColor colorWithHexString:@"#685034"]];
    manager.strikethrough = @1;
    manager.strikethroughColor = [UIColor colorWithHexString:@"#685034"];
    return manager.contentMutableAttributed;
}

+ (NSMutableAttributedString *)lgjeropj_getVipAttributeWithString:(NSString *)str font:(UIFont *)font color:(UIColor *)textColor {
    
    HTAttributedManager *manager = [[HTAttributedManager alloc] initWithText:str andFont:font andForegroundColor:textColor];
    return manager.contentMutableAttributed;
}

+ (CGFloat)lgjeropj_getScale {
    
    CGFloat itemWid = 162;
    if ( isPad ) {
        itemWid = (kScreenWidth - 16*2 - 10*2)/3;
    }
    CGFloat scale = itemWid/162;
    return scale;
}

@end
