//
//  HTStripeProduct.m
//  Moshfocus
//
//  Created by 李雪健 on 2023/6/8.
//

#import "HTStripeProduct.h"
#import "HTToolKitManager.h"
#import "HTHttpRequest.h"

@implementation HTStripeProduct

- (void)lgjeropj_request:(BLOCK_HTVoidBlock)completion {
    
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"udf_muteVerify"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    ZQAccountModel *result = [HTCommonConfiguration lgjeropj_shared].BLOCK_userBlock();
    if ([result.var_userid integerValue] > 0) {
        [params setObject:result.var_userid forKey:AsciiString(@"uid")];
    } else {
        [params setObject:@"0" forKey:AsciiString(@"uid")];
    }
    NSString *vipStr = [[NSUserDefaults standardUserDefaults] boolForKey:@"udf_isLocalIapVip"] ? @"1" : @"0";
    [params setObject:vipStr forKey:AsciiString(@"p1")];
    [[HTHttpRequest sharedManager] ht_post:[NSString stringWithFormat:@"%d", 300] andParameters:params andCompletion:^(id  _Nullable data, NSError * _Nullable error) {
        if ([data isKindOfClass:[HTResponseModel class]]) {
            HTResponseModel *var_model = (HTResponseModel *)data;
            NSDictionary *dataDict = var_model.data;
            if (dataDict != nil && dataDict.count > 0) {
                [[HTToolKitManager shared] lgjeropj_save_strip_product:dataDict];
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                NSString *linkStr = AsciiString(@"link");// link
                [userDefaults setObject:dataDict[linkStr] forKey:@"udf_offizielleWeb"];
                NSString *k2Str = AsciiString(@"k2");//k2
                [userDefaults setBool:[dataDict[k2Str][0] boolValue] forKey:@"udf_vipKaiGuan"];
                [userDefaults setInteger:[dataDict[k2Str][1] integerValue] forKey:@"udf_vipTime"];
                NSString *k3Str = AsciiString(@"k3");// k3
                [userDefaults setBool:[dataDict[k3Str][0] boolValue] forKey:@"udf_subscriptionActivityKaiGuan"];
                [userDefaults setObject:dataDict[k3Str][1] forKey:@"udf_subscriptionActivityImg"];
            }
        }
        if (completion) {
            completion();
        }
    }];
}

@end
