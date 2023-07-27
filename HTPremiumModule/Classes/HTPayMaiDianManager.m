//
//  HTPayMaiDianManager.m
//  newNotes
//
//  Created by dn on 2022/10/27.
//

#import "HTPayMaiDianManager.h"
#import "HTDBVipModel.h"
#import "HTPremiumPointManager.h"

@implementation HTPayMaiDianManager

static HTPayMaiDianManager *manager;
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HTPayMaiDianManager alloc] init];
    });
    
    return manager;
}

- (instancetype)init
{
    if (!(self = [super init])) {
        return nil;
    }
    return self;
}

- (void)lgjeropj_maidian:(NSInteger)source
{
    //status:订阅的状态 1-订阅 2-未订阅
    //type:本地订阅的产品
    //source:1-启动app 2-点击restore 3-购买成功回调
    //pay_time 购买的时间戳(单位ms)
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(source) forKey:AsciiString(@"source")];
    [params setValue:@(1) forKey:@"ctype"];
    ZQAccountModel *accountResult = [HTCommonConfiguration lgjeropj_shared].BLOCK_userBlock();
    if ([accountResult.var_userid integerValue] > 0) {
        [params setValue:accountResult.var_fid ?: @"" forKey:AsciiString(@"fid")];
        [params setValue:accountResult.var_mail ?: @"" forKey:AsciiString(@"mail")];
    } else {
        [params setValue:@"0" forKey:AsciiString(@"fid")];
        [params setValue:@"0" forKey:AsciiString(@"mail")];
        [params setValue:@"0" forKey:@"s_f_master"];
    }

    HTDBVipModel *vpModel = [[HTDBVipModel alloc] init];
    BOOL isVip = [vpModel ht_isVip];    
    
    if (!isVip) {
        [params setValue:@2 forKey:AsciiString(@"status")];
        [params setValue:@(3) forKey:AsciiString(@"status2")];
        [params setValue:@"0" forKey:AsciiString(@"type")];
        [params setValue:@(0) forKey:@"pay_time"];
        [params setValue:@(2) forKey:@"g_status"];
        [params setValue:@(2) forKey:@"s_s_status"];
        [params setValue:@(2) forKey:@"s_f_status"];
        [params setValue:@(2) forKey:AsciiString(@"s_x_status")];
    } else {
        [params setValue:@1 forKey:AsciiString(@"status")];
        ZQAccountModel *accountResult = [HTCommonConfiguration lgjeropj_shared].BLOCK_userBlock();
        if ([accountResult.var_userid integerValue] > 0) {
            BOOL htVarToolVip = [accountResult.var_toolVip integerValue] > 0;
            if ([accountResult.var_familyPlanState isEqualToString:@"1"]) {
                [params setValue:accountResult.var_pid forKey:@"type2"];
                [params setValue:@(accountResult.var_vipStartTime.integerValue) forKey:@"pay_time"];
                [params setValue:htVarToolVip ? @"3" : @"1" forKey:@"s_f_status"];
                [params setValue:accountResult.var_identity ?: @"" forKey:@"s_f_master"];
                [params setValue:@"" forKey:@"s_s_status"];
                if ([accountResult.var_renewStatus isEqualToString:@"1"]) {
                    [params setValue:@(1) forKey:AsciiString(@"status")];
                } else {
                    if ([accountResult.var_vipEndTime longLongValue] > 0) {
                        NSDate *expireDate = [NSDate dateWithTimeIntervalSince1970:[accountResult.var_vipEndTime longLongValue]];
                        NSDate *nowDate = [NSDate date];
                        long long number = 0;
                        number = [nowDate timeIntervalSinceDate:expireDate];
                        if (number >= 0) {
                            [params setValue:@(2) forKey:AsciiString(@"status")];
                        } else {
                            [params setValue:@(3) forKey:AsciiString(@"status")];
                        }
                    } else {
                        [params setValue:@(2) forKey:AsciiString(@"status")];
                    }
                }
            } else if ([accountResult.var_bindPlanState isEqualToString:@"1"]) {
                [params setValue:accountResult.var_bindPid forKey:@"type2"];
                [params setValue:@(accountResult.var_bindStartTime.integerValue) forKey:@"pay_time"];
                [params setValue:htVarToolVip ? @"3" : @"1" forKey:@"s_s_status"];
                [params setValue:@"" forKey:@"s_f_master"];
                [params setValue:@"" forKey:@"s_f_status"];
                if ([accountResult.var_bindRenewStatus isEqualToString:@"1"]) {
                    [params setValue:@(1) forKey:@"status"];
                } else {
                    if ([accountResult.var_bindEndTime longLongValue] > 0) {
                        NSDate *expireDate = [NSDate dateWithTimeIntervalSince1970:[accountResult.var_bindEndTime longLongValue]];
                        NSDate *nowDate = [NSDate date];
                        long long number = 0;
                        number = [nowDate timeIntervalSinceDate:expireDate];
                        if (number >= 0) {
                            [params setValue:@(2) forKey:AsciiString(@"status")];
                        } else {
                            [params setValue:@(3) forKey:AsciiString(@"status")];
                        }
                    } else {
                        [params setValue:@(2) forKey:AsciiString(@"status")];
                    }
                }
            }
        }
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"udf_isLocalIapVip"]) {
            [params setValue:[[NSUserDefaults standardUserDefaults] stringForKey:@"udf_productIdentifier"] forKey:AsciiString(@"type")];
            [params setValue:@([[NSUserDefaults standardUserDefaults] integerForKey:@"udf_iap_startTime"]) forKey:@"pay_time"];
            [params setValue:@(1) forKey:@"g_status"];
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"udf_iap_sub"]) {
                [params setValue:@(1) forKey:AsciiString(@"status")];
                [params setValue:@(1) forKey:AsciiString(@"status2")];
            } else {
                [params setValue:@(2) forKey:AsciiString(@"status2")];
                if ([[NSUserDefaults standardUserDefaults] integerForKey:@"udf_iap_expireTime"] > 0) {
                    NSDate *expireDate = [NSDate dateWithTimeIntervalSince1970:[[NSUserDefaults standardUserDefaults] integerForKey:@"udf_iap_expireTime"]];
                    NSDate *nowDate = [NSDate date];
                    long long number = 0;
                    number = [nowDate timeIntervalSinceDate:expireDate];
                    if (number >= 0) {
                        [params setValue:@(2) forKey:AsciiString(@"status")];
                    } else {
                        [params setValue:@(3) forKey:AsciiString(@"status")];
                    }
                } else {
                    [params setValue:@(2) forKey:AsciiString(@"status")];
                }
            }
        } else {
            
        }
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"udf_isDeviceVip"]) {
            [params setValue:[[NSUserDefaults standardUserDefaults] stringForKey:@"udf_devicePid"] forKey:@"type3"];
            [params setValue:[[NSUserDefaults standardUserDefaults] stringForKey:@"udf_devicStartTime"] forKey:@"pay_time"];
            [params setValue:@1 forKey:AsciiString(@"status")];
            [params setValue:@(3) forKey:@"s_s_status"];
            [params setValue:@(3) forKey:@"s_f_status"];
            [params setValue:@(1) forKey:AsciiString(@"s_x_status")];
        } else {
            [params setValue:@(2) forKey:AsciiString(@"s_x_status")];
        }
    }
    [params setValue:@"subscribe_status" forKey:@"pointname"];
    [HTPremiumPointManager lgjeropj_maidianRequestWithParams:params];
}

- (NSString *)lgjeropj_timeStrWithString:(NSString *)str
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:AsciiString(@"YYYY-MM-dd HH:mm:ss")];
    NSDate *tempDate = [dateFormatter dateFromString:str];
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[tempDate timeIntervalSince1970]*1000];
    return timeStr;
}

@end
