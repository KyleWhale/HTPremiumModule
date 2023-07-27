//
//  HTToolKitManager.m
//  Ziven
//
//  Created by 李雪健 on 2023/5/29.
//

#import "HTToolKitManager.h"
#import "HTPremiumPointManager.h"

@implementation HTToolKitManager

+ (HTToolKitManager *)shared
{
    static HTToolKitManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HTToolKitManager alloc] init];
    });
    return manager;
}

- (void)lgjeropj_save_strip_product:(NSDictionary *)dic
{
    if (dic == nil || dic.count == 0) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"udf_strip_product_data"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // 埋点
    NSInteger var_k12 = [dic[AsciiString(@"k12")] integerValue];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@(1) forKey:AsciiString(@"type")];
    [params setValue:@(var_k12 == 1 ? 1 : 2) forKey:AsciiString(@"status")];
    [params setValue:@"tool_switch" forKey:@"pointname"];
    [HTPremiumPointManager lgjeropj_maidianRequestWithParams:params];
}

- (NSDictionary *)lgjeropj_strip_product
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"udf_strip_product_data"];
}

- (NSDictionary *)lgjeropj_server_products
{
    NSDictionary *dic = [[HTToolKitManager shared] lgjeropj_strip_product];
    return dic[AsciiString(@"data2")];
}

- (NSArray *)lgjeropj_hidden_products
{
    NSDictionary *dic = [[HTToolKitManager shared] lgjeropj_strip_product];
    return dic[AsciiString(@"h1")];
}

- (NSDictionary *)lgjeropj_strip_p1
{
    NSDictionary *dic = [[HTToolKitManager shared] lgjeropj_strip_product];
    return dic[AsciiString(@"p1")];
}

- (NSDictionary *)lgjeropj_strip_p2
{
    NSDictionary *dic = [[HTToolKitManager shared] lgjeropj_strip_product];
    return dic[AsciiString(@"p2")];
}

- (NSArray *)lgjeropj_strip_k3
{
    NSDictionary *dic = [[HTToolKitManager shared] lgjeropj_strip_product];
    return dic[AsciiString(@"k3")];
}

- (NSInteger)lgjeropj_strip_k12
{
    NSDictionary *dic = [[HTToolKitManager shared] lgjeropj_strip_product];
    return ([dic[AsciiString(@"k12")] integerValue] > 0 && [self lgjeropj_airplay].count > 0) ? 1 : 0;
}

- (NSInteger)lgjeropj_strip_k13
{
    NSDictionary *dic = [[HTToolKitManager shared] lgjeropj_strip_product];
    return [dic[AsciiString(@"k13")] integerValue];
}

- (void)lgjeropj_save_airplay:(NSDictionary *)dic
{
    if (dic == nil || dic.count == 0) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"udf_airplay"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSDictionary *)lgjeropj_airplay
{
    NSDictionary *data = [HTCommonConfiguration lgjeropj_shared].BLOCK_airDictBlock();
    if (data == nil) {
        data = [[NSUserDefaults standardUserDefaults] objectForKey:@"udf_airplay"];
    }
    return data;
}

- (BOOL)lgjeropj_installed
{
    NSDictionary *dic = [[HTToolKitManager shared] lgjeropj_airplay];
    if (dic.count == 0) {
        return NO;
    }
    NSString *var_scheme = [NSString stringWithFormat:@"%@%@%@%@", dic[AsciiString(@"scheme")], @":", @"/", @"/"];
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:var_scheme]];
}

@end
