//
//  HTPremiumViewManager.m
//  Moshfocus
//
//  Created by 李雪健 on 2023/6/7.
//

#import "HTPremiumViewManager.h"
#import "HTPremiumPointManager.h"
#import "HTPremiumManager.h"

@implementation HTPremiumViewManager

+ (UILabel *)lgjeropj_removeLabel
{
    return [HTKitCreate ht_labelWithText:LocalString(@"Premium", nil) andFont:HTPingFangFont(16) andTextColor:[UIColor colorWithHexString:@"#ffffff"] andAligment:NSTextAlignmentCenter andNumberOfLines:1];
}

+ (UICollectionView *)lgjeropj_collectionView:(id)target {
    
    UICollectionView *view = [HTKitCreate ht_collectionViewWithDelegate:target andIsVertical:YES andLineSpacing:10 andColumnSpacing:0 andItemSize:CGSizeZero andIsEstimated:NO andSectionInset:UIEdgeInsetsZero];
    [view registerClass:[HTPremiumNewCardCell class] forCellWithReuseIdentifier:NSStringFromClass([HTPremiumNewCardCell class])];
    [view registerClass:[HTPremiumViewInfoCell class] forCellWithReuseIdentifier:NSStringFromClass([HTPremiumViewInfoCell class])];
    [view registerClass:[HTPremiumHeaderCell class] forCellWithReuseIdentifier:NSStringFromClass([HTPremiumHeaderCell class])];
    [view registerClass:[HTPremiumEmptyCell class] forCellWithReuseIdentifier:NSStringFromClass([HTPremiumEmptyCell class])];
    return view;
}

+ (NSArray *)lgjeropj_hintArray {
    
    NSString *s1 = LocalString(@"Subscription automatically renews unless auto-renewal is disabled at least 24 hours before the end of the current period.", nil);
    NSString *s2 = LocalString(@"Subscriptions can be managed by the user and automatic renewal can be disabled by going to the User Account Settings after purchase.", nil);
    NSString *s3 = LocalString(@"You must confirm and pay the VIP subscription through the iTunes account in the purchase confirmation.", nil);
    NSString *s4 = LocalString(@"Any unused portion of a free trial period, if offered, will be forfeited when the user purchases a subscription to that publication, where applicable.", nil);
    NSString *s5 = LocalString(@"The VIP subscription is automatically renewed.", nil);
    NSString *s6 = LocalString(@"Subscriptions length: Weekly,Monthly,Annually.", nil);
    NSString *s7 = [NSString stringWithFormat:@"%@%@", [NSString stringWithFormat:@"%@:", LocalString(@"Terms of Service", nil)], TermService];
    NSString *s8 = [NSString stringWithFormat:@"%@%@", [NSString stringWithFormat:@"%@:", LocalString(@"Privacy Policy", nil)], PrivacyPolicy];
    NSMutableArray *array = [[NSMutableArray alloc] init];

    if ([s1 rangeOfString:LocalString(@"Subscription automatically renews", nil)].location != NSNotFound) {
        NSMutableAttributedString *att1 = [self lgjeropj_getAttributeWithString:s1 range:[s1 rangeOfString:LocalString(@"Subscription automatically renews", nil)] link:nil];
        [array addObject:att1];
    }
    if ([s2 rangeOfString:LocalString(@"automatic renewal can be disabled", nil)].location != NSNotFound) {
        NSMutableAttributedString *att2 = [self lgjeropj_getAttributeWithString:s2 range:[s2 rangeOfString:LocalString(@"automatic renewal can be disabled", nil)] link:nil];
        [array addObject:att2];
    }
    NSMutableAttributedString *att3 = [self lgjeropj_getAttributeWithString:s3 range:NSMakeRange(0, 0) link:nil];
    [array addObject:att3];
    NSMutableAttributedString *att4 = [self lgjeropj_getAttributeWithString:s4 range:NSMakeRange(0, 0) link:nil];
    [array addObject:att4];
    NSMutableAttributedString *att5 = [self lgjeropj_getAttributeWithString:s5 range:NSMakeRange(0, s5.length) link:nil];
    [array addObject:att5];
    NSMutableAttributedString *att6 = [self lgjeropj_getAttributeWithString:s6 range:NSMakeRange(0, 0) link:nil];
    [array addObject:att6];
    if ([s7 rangeOfString:TermService].location != NSNotFound) {
        NSMutableAttributedString *att7 = [self lgjeropj_getAttributeWithString:s7 range:[s7 rangeOfString:TermService] link:TermService];
        [array addObject:att7];
    }
    if ([s8 rangeOfString:PrivacyPolicy].location != NSNotFound) {
        NSMutableAttributedString *att8 = [self lgjeropj_getAttributeWithString:s8 range:[s8 rangeOfString:PrivacyPolicy] link:PrivacyPolicy];
        [array addObject:att8];
    }
    return array;
}

+ (NSMutableAttributedString *)lgjeropj_getAttributeWithString:(NSString *)str range:(NSRange)range link:(NSString *)link {
    
    CGFloat scale = [self lgjeropj_getScale];
    
    HTAttributedManager *manager = [[HTAttributedManager alloc] initWithText:str andFont:HTPingFangRegularFont(12*scale) andForegroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.8]];
    [manager ht_addLineSpace:6*scale andFirstLineHeadIndent:0 andAlignment:NSTextAlignmentLeft];
    
    if (range.location != NSNotFound && range.length > 0) {
        HTAttributedManager *subManager = [[HTAttributedManager alloc] initWithText:nil andFont:HTPingFangRegularFont(12*scale) andForegroundColor:[UIColor colorWithHexString:@"#5B98F3"]];
        if (link) {
            subManager.link = link;
            subManager.underline = @1;
            subManager.underlineColor = [UIColor colorWithHexString:@"#5B98F3"];
        }
        [manager ht_setAttributedModel:subManager andRang:range];
    }
    return manager.contentMutableAttributed;
}

+ (CGFloat)lgjeropj_getScale {
    
    CGFloat itemWid = 162;
    if (isPad) {
        itemWid = (kScreenWidth - 16*2 - 10*2)/3;
    }
    CGFloat scale = itemWid/162;
    return scale;
}

// 导量
+ (void)lgjeropj_guideAction {
    NSDictionary *var_dataDict = [HTCommonConfiguration lgjeropj_shared].BLOCK_gdBlock();
    NSString *var_yumingStr = var_dataDict[AsciiString(@"l1")];
    NSURL *var_linkURL = [NSURL URLWithString:var_dataDict[AsciiString(@"link")]];
    if (var_yumingStr && var_yumingStr.length > 0) {
        var_linkURL = [self lgjeropj_createDynamiclink:var_dataDict];
    }
    [[UIApplication sharedApplication] openURL:var_linkURL options:@{} completionHandler:^(BOOL success) {}];
}

+ (NSURL *)lgjeropj_createDynamiclink:(NSDictionary *)data {
    NSMutableDictionary *params = [HTPremiumManager lgjeropj_getVipParams];
    [params setValue:@"2" forKey:AsciiString(@"type")];
    [params setValue:[data objectForKey:AsciiString(@"l2")] forKey:@"var_shopLink"];
    [params setValue:[data objectForKey:AsciiString(@"a1")] forKey:@"var_targetBundle"];
    [params setValue:[data objectForKey:AsciiString(@"l1")] forKey:@"var_targetLink"];
    [params setValue:[data objectForKey:AsciiString(@"k2")] forKey:@"var_dynamicK2"];
    [params setValue:[data objectForKey:AsciiString(@"c4")] forKey:@"var_dynamicC4"];
    [params setValue:[data objectForKey:AsciiString(@"c5")] forKey:@"var_dynamicC5"];
    [params setValue:[data objectForKey:AsciiString(@"logo")] forKey:@"var_dynamicLogo"];
    return [HTCommonConfiguration lgjeropj_shared].BLOCK_deepLinkBlock(params);
}

+ (void)lgjeropj_maidianVipShow:(NSInteger)source {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(source) forKey:@"source"];
    [params setObject:@"1" forKey:AsciiString(@"type")];
    [params setObject:@"vip_sh" forKey:@"pointname"];
    [HTPremiumPointManager lgjeropj_maidianRequestWithParams:params];
}

+ (void)lgjeropj_maidianVipClick:(NSString *)kidStr source:(NSInteger)source {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:kidStr forKey:AsciiString(@"kid")];
    [params setObject:@"1" forKey:AsciiString(@"type")];
    [params setObject:@(source) forKey:@"source"];
    [params setObject:@"vip_cl" forKey:@"pointname"];
    [HTPremiumPointManager lgjeropj_maidianRequestWithParams:params];
}

@end
