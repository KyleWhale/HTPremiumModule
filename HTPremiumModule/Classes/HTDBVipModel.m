//
//  HTDBVipModel.m
//  Hucolla
//
//  Created by mac on 2022/9/19.
//

#import "HTDBVipModel.h"

@implementation HTDBVipModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSString *identifier = [[NSUserDefaults standardUserDefaults] stringForKey:@"udf_productIdentifier"];
        self.var_vipId = identifier;
        self.var_start = [[NSDate dateWithTimeIntervalSince1970:[[NSUserDefaults standardUserDefaults] integerForKey:@"udf_iap_startTime"]] stringWithFormat:AsciiString(@"yyyy-MM-dd HH:mm:ss")];
        self.var_end = [[NSDate dateWithTimeIntervalSince1970:[[NSUserDefaults standardUserDefaults] integerForKey:@"udf_iap_expireTime"]] stringWithFormat:AsciiString(@"yyyy-MM-dd HH:mm:ss")];
        
    }
    return self;
}

- (BOOL)ht_isVip {
    BOOL var_isvip = NO;
    ZQAccountModel *var_result = [HTCommonConfiguration lgjeropj_shared].BLOCK_userBlock();
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"udf_isLocalIapVip"]  || [var_result.var_bindPlanState isEqualToString:@"1"] || [var_result.var_familyPlanState isEqualToString:@"1"] || [[NSUserDefaults standardUserDefaults] boolForKey:@"udf_isDeviceVip"]) {
        var_isvip = YES;
    }
    return var_isvip;
}

@end
