//
//  HTPremiumManager.m
//  Moshfocus
//
//  Created by 李雪健 on 2023/7/27.
//

#import "HTPremiumManager.h"
#import "ZQAccountModel.h"
#import "LKFPrivateFunction.h"
#import "HTCommonMacro.h"
#import "HTCommonConfiguration.h"

@implementation HTPremiumManager

+ (NSMutableDictionary *)lgjeropj_getVipParams {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *var_p1String = @"";
    NSInteger var_p2String = 0;
    NSInteger var_sub1String = 0;
    NSString *var_sub2String = @"0";
    NSString *var_t1String = @"0";
    NSString *var_subidString = @"";
    ZQAccountModel *accountResult = [HTCommonConfiguration lgjeropj_shared].BLOCK_userBlock();
    if ([HTCommonConfiguration lgjeropj_shared].BLOCK_vipBlock()) {
        var_subidString = accountResult.var_bindAppId ?: @"";
        var_t1String = [accountResult.var_bindT1 isEqualToString:@"2"]?@"2":@"1";
        var_p2String = 2;
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"udf_isDeviceVip"]) {
            var_p1String = [[NSUserDefaults standardUserDefaults] stringForKey:@"udf_devicePid"];
            var_t1String = @"2";
        }
        if ([accountResult.var_familyPlanState isEqualToString:@"1"]) {
            var_p1String = accountResult.var_pid ?:@"";
            var_sub2String = accountResult.var_renewStatus;
        }
        if ([accountResult.var_bindPlanState isEqualToString:@"1"]) {
            var_p1String = accountResult.var_bindPid ?:@"";
            var_sub2String = accountResult.var_bindRenewStatus;
        }
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"udf_isLocalIapVip"]) {
            var_p1String = [[NSUserDefaults standardUserDefaults] stringForKey:@"udf_productIdentifier"];
            var_p2String = 1;
            var_sub1String = [[NSUserDefaults standardUserDefaults] boolForKey:@"udf_iap_sub"];
            var_t1String = @"1";
        }
    }
    [params setObject:var_p1String forKey:AsciiString(@"p1")];// 订阅产品ID
    [params setObject:@(var_p2String) forKey:AsciiString(@"p2")];// 0 未订阅 1 本地订阅 2 服务器订阅
    [params setObject:var_t1String forKey:AsciiString(@"t1")];
    [params setObject:@(var_sub1String) forKey:AsciiString(@"sub1")];
    [params setObject:var_sub2String forKey:AsciiString(@"sub2")];
    [params setObject:var_subidString forKey:AsciiString(@"subid")];
    [params setObject:[[NSBundle mainBundle] bundleIdentifier] forKey:AsciiString(@"apk_name")];
    return params;
}

@end
