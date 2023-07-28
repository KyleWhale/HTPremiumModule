//
//  HTVipActivityView.m
//  Moshfocus
//
//  Created by 李雪健 on 2023/6/27.
//

#import "HTVipActivityView.h"
#import "HTToolKitManager.h"
#import "HTPremiumPointManager.h"
#import "LRIAPManager.h"

@interface HTVipActivityView ()

@property (nonatomic, strong) NSMutableDictionary *sourceDict;
@property (nonatomic, strong) UIButton *iconImage;

@end

@implementation HTVipActivityView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self lgjeropj_addSubViews];
    }
    return self;
}

- (void)lgjeropj_addSubViews {
 
    self.iconImage = [UIButton buttonWithType:UIButtonTypeCustom];
    self.iconImage.frame = CGRectMake((kScreenWidth - kWidthScale(272))/2, (kScreenHeight - kWidthScale(400))/2, kWidthScale(272), kWidthScale(400));
    self.iconImage.layer.cornerRadius = 12;
    self.iconImage.layer.masksToBounds = YES;
    [self.iconImage addTarget:self action:@selector(lgjeropj_buyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.iconImage];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(CGRectGetWidth(self.iconImage.frame) - 40, 0, 34, 34);
    [closeBtn setImage:[UIImage imageNamed:@"icon_wdfork_white"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(lgjeropj_closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.iconImage addSubview:closeBtn];
    
    UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
    view.frame = CGRectMake(0, CGRectGetMaxY(self.iconImage.frame) + 10, kScreenWidth, 36);
    view.titleLabel.font = [UIFont systemFontOfSize:kScale*15];
    [view setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    NSString *moreStr = LocalString(@"Choose more plans", nil);
    [view setTitle:moreStr forState:UIControlStateNormal];
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:moreStr];
    NSRange contentRange = {0, moreStr.length};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    [content addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:contentRange];
    [view setAttributedTitle:content forState:UIControlStateNormal];
    [view addTarget:self action:@selector(lgjeropj_moreProductBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:view];
}

- (void)lgjeropj_closeBtnClick {
    //埋点
    [self lgjeropj_maidianVipClick:@"8"];
    if (self.block) {
        self.block(nil);
    }
    [self lgjeropj_dismiss];
}

- (void)lgjeropj_moreProductBtnClick {

    if (self.block) {
        self.block(self.sourceDict);
    }
    [self lgjeropj_dismiss];
    //埋点
    [self lgjeropj_maidianVipClick:@"16"];
}

- (void)lgjeropj_buyBtnAction {
    
    if ([[HTToolKitManager shared] lgjeropj_strip_k12] == 1) {
        // 工具包
        NSString *var_activity_product = nil;
        NSArray *var_k3 = [[HTToolKitManager shared] lgjeropj_strip_k3];
        if (var_k3.count > 0) {
            NSInteger var_activity = [[var_k3 firstObject] integerValue];
            if (var_activity == 1) {
                // 有活动
                if (var_k3.count > 2) {
                    var_activity_product = [NSString stringWithFormat:@"%@", [var_k3 objectAtIndex:2]];
                }
            }
        }
        if (var_activity_product.length > 0) {
            if ([var_activity_product containsString:AsciiString(@"week")]) {
                var_activity_product = @"1";
            } else if ([var_activity_product containsString:AsciiString(@"month")]) {
                var_activity_product = @"2";
            } else if ([var_activity_product containsString:AsciiString(@"year")]) {
                var_activity_product = @"3";
            }
        }
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setValue:@"1" forKey:AsciiString(@"type")];
        // 1:个人周 2:个人月 3:个人年 4:家庭周 5:家庭月 6:家庭年
        [params setValue:var_activity_product ?: @"2" forKey:AsciiString(@"product")];
        [params setValue:var_activity_product ?: @"0" forKey:AsciiString(@"activityProduct")];
        // var_shopLink var_targetBundle var_targetLink
        NSDictionary *data = [[HTToolKitManager shared] lgjeropj_airplay];
        NSString *var_appleId = data[AsciiString(@"appleid")];
        NSString *var_shopLink = [NSString stringWithFormat:@"%@%@", AsciiString(@"https://apps.apple.com/app/id"), var_appleId];
        [params setValue:var_shopLink forKey:@"var_shopLink"];
        [params setValue:[data objectForKey:AsciiString(@"bundleid")] forKey:@"var_targetBundle"];
        [params setValue:[data objectForKey:AsciiString(@"l1")] forKey:@"var_targetLink"];
        [params setValue:[data objectForKey:AsciiString(@"k2")] forKey:@"var_dynamicK2"];
        [params setValue:[data objectForKey:AsciiString(@"c4")] forKey:@"var_dynamicC4"];
        [params setValue:[data objectForKey:AsciiString(@"c5")] forKey:@"var_dynamicC5"];
        [params setValue:[data objectForKey:AsciiString(@"logo")] forKey:@"var_dynamicLogo"];
        [[UIApplication sharedApplication] openURL:[HTCommonConfiguration lgjeropj_shared].BLOCK_deepLinkBlock(params) options:@{} completionHandler:^(BOOL success) {}];
        return;
    }
    [LRIAPManager iapInstance].var_isPaying = YES;
    [[LRIAPManager iapInstance] lgjeropj_purchaseWithPID:self.sourceDict[@"id"] andBlock:^(BOOL result, NSInteger source, NSString * _Nonnull urlStr) {
        [LRIAPManager iapInstance].var_isPaying = NO;
        if (result == YES) {
            if (self.block) {
                self.block(nil);
            }
            [self lgjeropj_dismiss];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NTFCTString_IPASuccess" object:nil];
        }
    }];
    //埋点
    NSString *var_id = self.sourceDict[AsciiString(@"id")];
    NSInteger dayCount = [self.sourceDict[AsciiString(@"count")] integerValue];
    BOOL trial = [self.sourceDict[AsciiString(@"trial")] boolValue];
    if ([var_id isEqualToString:[NSString stringWithFormat:@"%@_%@", HT_IPA_Mosh, HT_IPA_Month]]) {
        [self lgjeropj_maidianVipClick:@"34"];
    } else if (trial) {
        [self lgjeropj_maidianVipClick:@"9"];
    } else if (dayCount == 7) {
        [self lgjeropj_maidianVipClick:@"7"];
    } else if (dayCount == 30) {
        [self lgjeropj_maidianVipClick:@"2"];
    } else if (dayCount >= 360) {
        [self lgjeropj_maidianVipClick:@"3"];
    }
}

- (NSMutableDictionary *)sourceDict {
    
    if (!_sourceDict) {
        _sourceDict = [NSMutableDictionary dictionary];
        NSMutableArray *array = [LRIAPManagerTwo lgjeropj_makeIapSingleData];
        NSDictionary *itemM = nil;
        NSDictionary *itemD = nil;
        for (NSDictionary *dict in array) {
            if ([dict[AsciiString(@"type")] integerValue] == 1) {
                itemD = dict;
            }
            if ([dict[AsciiString(@"count")] integerValue] == 30) {
                itemM = dict;
            }
        }
        if (itemD.count > 0) {
            [_sourceDict addEntriesFromDictionary:itemD];
        } else if (itemM.count > 0) {
            [_sourceDict addEntriesFromDictionary:itemM];
        }
    }
    return _sourceDict;
}

- (void)lgjeropj_maidianVipShow {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(self.source) forKey:@"source"];
    [params setObject:@"2" forKey:AsciiString(@"type")];
    [params setValue:@"vip_sh" forKey:@"pointname"];
    [HTPremiumPointManager lgjeropj_maidianRequestWithParams:params];
}

- (void)lgjeropj_maidianVipClick:(NSString *)kidStr {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:kidStr forKey:AsciiString(@"kid")];
    [params setObject:@"2" forKey:AsciiString(@"type")];
    [params setObject:@(self.source) forKey:@"source"];
    [params setObject:@"vip_cl" forKey:@"pointname"];
    [HTPremiumPointManager lgjeropj_maidianRequestWithParams:params];
}

- (void)lgjeropj_showInView:(UIView *)view {
    
    [self.iconImage setImage:self.var_image forState:UIControlStateNormal];
    [self lgjeropj_maidianVipShow];
    [HTCommonConfiguration lgjeropj_shared].BLOCK_stopAdBlock(YES);
    if ([self isDescendantOfView:view] == NO) {
        [view addSubview:self];
    }
    [view bringSubviewToFront:self];
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    self.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        [self layoutIfNeeded];
    }];
}

- (void)lgjeropj_dismiss {
    
    [HTCommonConfiguration lgjeropj_shared].BLOCK_stopAdBlock(NO);
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end
