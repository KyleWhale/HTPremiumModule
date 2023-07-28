//
//  HTGuidePaymentViewManager.m
//  Moshfocus
//
//  Created by 李雪健 on 2023/6/6.
//

#import "HTGuidePaymentViewManager.h"

@implementation HTGuidePaymentViewManager

+ (UIButton *)lgjeropj_cancelButton:(id)target action:(SEL)action {
    
    UIButton *view = [HTKitCreate ht_buttonWithImage:[UIImage imageNamed:@"icon_wdfork_white"] andSelectImage:nil];
    [view addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return view;
}

+ (UIImageView *)lgjeropj_iconView {
    
    UIImageView *view = [[UIImageView alloc] init];
    view.contentMode = UIViewContentModeScaleAspectFit;
    return view;
}

+ (UILabel *)lgjeropj_topLabel {
    
    UILabel *view = [[UILabel alloc] init];
    view.font = [UIFont boldSystemFontOfSize:kScale*22];
    view.textAlignment = NSTextAlignmentCenter;
    view.textColor = [UIColor colorWithHexString:@"#E29F4B"];
    view.numberOfLines = 0;
    return view;
}

+ (UILabel *)lgjeropj_centerLabel {
    
    UILabel *view = [[UILabel alloc] init];
    view.font = [UIFont systemFontOfSize:kScale*15];
    view.textAlignment = NSTextAlignmentCenter;
    view.textColor = [UIColor colorWithHexString:@"#B29167"];
    view.numberOfLines = 0;
    return view;
}

+ (UIButton *)lgjeropj_buyButton:(id)target action:(SEL)action {
    
    UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
    [view setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view sd_setBackgroundImageWithURL:[LKFPrivateFunction lgjeropj_imageUrlFromNumber:53] forState:UIControlStateNormal];
    view.titleLabel.font = [UIFont boldSystemFontOfSize:kScale*15];
    view.titleLabel.numberOfLines = 2;
    view.layer.cornerRadius = 10;
    [view.layer setMasksToBounds:YES];
    [view addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return view;
}

+ (UILabel *)lgjeropj_priceLabel {
    
    UILabel *view = [[UILabel alloc] init];
    view.font = [UIFont systemFontOfSize:kScale*13];
    view.textAlignment = NSTextAlignmentCenter;
    view.textColor = [UIColor colorWithHexString:@"#E29F4B"];
    view.numberOfLines = 0;
    return view;
}

+ (UIImageView *)lgjeropj_trialView {
    
    UIImageView *view = [[UIImageView alloc] init];
    [view sd_setImageWithURL:[LKFPrivateFunction lgjeropj_imageUrlFromNumber:72]];
    return view;
}

+ (UIButton *)lgjeropj_chooseMoreButton:(id)target action:(SEL)action {
    
    UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
    view.titleLabel.font = [UIFont systemFontOfSize:kScale*15];
    [view setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    NSString *moreStr = LocalString(@"Choose more plans", nil);
    [view setTitle:moreStr forState:UIControlStateNormal];
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:moreStr];
    NSRange contentRange = {0, moreStr.length};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    [content addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:contentRange];
    [view setAttributedTitle:content forState:UIControlStateNormal];
    [view addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return view;
}

@end
