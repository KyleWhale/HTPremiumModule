//
//  HTHttpRequest.m
//  Hucolla
//
//  Created by mac on 2020/10/9.
//  Copyright © 2020 Jerry. All rights reserved.
//

#import "HTHttpRequest.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "HTCommonHeader.h"
#import "HTConfig.h"

@interface HTHttpRequest ()
///afn的网络请求管理者
@property(nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation HTHttpRequest

///网络请求管理者
+ (instancetype)sharedManager {
    
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    
    self.manager = [[AFHTTPSessionManager alloc] init];
    [self.manager.requestSerializer setTimeoutInterval:30];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:AsciiString(@"application/json"), AsciiString(@"text/json"), AsciiString(@"text/javascript"), AsciiString(@"text/html"), AsciiString(@"text/plain"), AsciiString(@"application/pdf"), nil];
    
    return self;
}

#pragma mark - 是否打开网络状态转圈菊花
- (void)ht_post:(NSString *)urlString andParameters:(NSDictionary *)parameters andTrans:(BOOL)var_trans andCompletion:(nonnull BLOCK_HTRequestCompleteBlock)completion {
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    NSMutableDictionary *para = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *signature = [self lgjeropj_signatureWithPrama:para];
    NSMutableDictionary *apiParams = [self lgjeropj_apiPublicParams];
    [para addEntriesFromDictionary:signature];
    [para addEntriesFromDictionary:apiParams];
    [para addEntriesFromDictionary:parameters];
    
    NSDictionary *headers = @{};
    urlString = [HTHttpRequest lgjeropj_splicingURLWith:urlString];
    [self.manager POST:urlString parameters:para headers:headers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:NO];
        if (var_trans) {
            HTResponseModel *model = [HTResponseModel yy_modelWithJSON:responseObject];
            completion(model, nil);
        } else {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:NO];
        completion(nil, error);
    }];
}

- (void)ht_post:(NSString *)urlString andParameters:(NSDictionary *)parameters andCompletion:(nonnull BLOCK_HTRequestCompleteBlock)completion {
    
    [self ht_post:urlString andParameters:parameters andTrans:YES andCompletion:completion];
}

- (void)ht_get:(NSString *)URLString andParameters:(NSDictionary *)parameters andCompletion:(nonnull BLOCK_HTRequestCompleteBlock)completion {
    
    NSMutableDictionary * para = [NSMutableDictionary dictionaryWithDictionary:parameters].mutableCopy;
    NSMutableDictionary *apiParams = [self lgjeropj_maidianPublicParams];
    [para addEntriesFromDictionary:apiParams];
    
    NSDictionary *headers = @{};
    URLString = [HTHttpRequest lgjeropj_splicingURLWith:URLString];
    [self.manager GET:URLString parameters:para headers:headers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HTResponseModel *model = [HTResponseModel yy_modelWithJSON:responseObject];
        completion(model, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

+ (NSString *)lgjeropj_splicingURLWith:(NSString *)URLString {
    
    NSString *var_base = @"";
    if ([URLString isEqualToString:AsciiString(@"data")]) {
        var_base = [HTCommonConfiguration lgjeropj_shared].BLOCK_dataURLBlock();
    } else {
        var_base = [HTCommonConfiguration lgjeropj_shared].BLOCK_baseURLBlock();
    }
    return [var_base stringByAppendingFormat:@"%@%@%@",@"/",URLString,@"/"];
}

// 公参
- (NSMutableDictionary *)lgjeropj_apiPublicParams {
    
    NSMutableDictionary *params = [self lgjeropj_publicParameters];
    [params setValue:[HTConfig ht_device] forKey:AsciiString(@"device")];
    [params setValue:[HTConfig ht_appVer] forKey:AsciiString(@"app_ver")];
    [params setValue:[HTConfig ht_osVer] forKey:AsciiString(@"os_ver")];
    [params setValue:[HTConfig ht_resolution] forKey:AsciiString(@"resolution")];
    [params setValue:[HTConfig ht_deviceNo] forKey:AsciiString(@"deviceNo")];
    [params setValue:[HTConfig ht_installTime] forKey:AsciiString(@"installTime")];
    // 手机型号（模式） @"iPhone", @"iPod touch"
    [params setValue:[[UIDevice currentDevice] model] forKey:AsciiString(@"brand")];
    // 设备型号
    [params setValue:[HTConfig lgjeropj_getPlatformString] forKey:AsciiString(@"model")];
    
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:AsciiString(@"AppleLanguages")];
    NSString *string = [array objectAtIndex:0];
    NSRange range = [string rangeOfString:@"-" options:NSBackwardsSearch];
    NSString *locale = @"";
    if (range.location != NSNotFound) {
        NSArray *array1 = [string componentsSeparatedByString:@"-"];
        locale = [array1 objectAtIndex:array1.count - 1];
    } else {
        string = string.length > 1?[string substringToIndex:2]:@"";
        locale = [[NSLocale currentLocale] localeIdentifier];
    }
    NSString *language = @"";
    if (range.location != NSNotFound) {
        language = [string substringToIndex:range.location];
    } else {
        language = [string substringToIndex:2];
    }
    [params setValue:locale forKey:AsciiString(@"country")];
    [params setValue:language forKey:AsciiString(@"lang")];
    // token
    [params setValue:@(1) forKey:AsciiString(@"token")];
    // 时区
    [params setValue:[HTConfig lgjeropj_destinationTimeZone] forKey:AsciiString(@"timezone")];
    // 开关
    NSInteger var_coverDefinition = [[NSUserDefaults standardUserDefaults] integerForKey:@"udf_coverDefinition"];
    [params setValue:(var_coverDefinition > 0 ? @(var_coverDefinition) : @"0") forKey:AsciiString(@"r1")];
    // 网络状态
    CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc]init];
    CTCarrier *carrier = [netInfo subscriberCellularProvider];
    // 供应商国家编号
    NSString *countryCode = carrier.mobileCountryCode;
    // 供应商网络编号
    NSString *networkCode = carrier.mobileNetworkCode;
    [params setValue:[NSString stringWithFormat:@"%@%@", countryCode, networkCode] forKey:AsciiString(@"imsi")];
    ZQAccountModel *var_model = [HTCommonConfiguration lgjeropj_shared].BLOCK_userBlock();
    if (var_model && [var_model.var_userid integerValue] > 0) {
        [params setObject:var_model.var_userid forKey:AsciiString(@"uid")];
    } else {
        [params setObject:@"0" forKey:AsciiString(@"uid")];
    }
    /*
     测试
     [params setValue:@"4.0" forKey:AsciiString(@"version")];
     */

    return params;
}
- (NSMutableDictionary *)lgjeropj_maidianPublicParams {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *publicDict = [self lgjeropj_publicParameters];
    [dict addEntriesFromDictionary:publicDict];
    
    NSString *model = [[UIDevice currentDevice] model];//手机型号（模式） @"iPhone", @"iPod touch"
    [dict setValue:[self ht_safeValue:model] forKey:AsciiString(@"brand")];
    NSString *UUIDString = [[[UIDevice currentDevice] identifierForVendor] UUIDString];//设备基本信息 UUID,5.0后不可用
    [dict setValue:[self ht_safeValue:UUIDString] forKey:@"xaid"];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *shortVersion = [infoDictionary objectForKey:AsciiString(@"CFBundleShortVersionString")];// 当前应用软件版本  比如：1.0.1
    [dict setValue:[self ht_safeValue:shortVersion] forKey:@"ver"];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *array = [userDefaults objectForKey:AsciiString(@"AppleLanguages")];
    NSString *string = [array objectAtIndex:0];
    [dict setValue:[self ht_safeValue:string] forKey:@"cl"];//语言
    [dict setValue:[HTConfig lgjeropj_getPlatformString] forKey:AsciiString(@"model")];//设备型号
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    [dict setValue:[self ht_safeValue:systemVersion] forKey:AsciiString(@"os_ver")];//系统版本
    [dict setValue:[HTConfig lgjeropj_destinationTimeZone] forKey:@"tmzone"];
    [dict setValue:@([[NSDate date] timeIntervalSince1970]) forKey:@"uptime"];
    [dict setValue:@(2) forKey:@"prodid"];
    [dict setValue:[HTConfig lgjeropj_currentResolution] forKey:AsciiString(@"display")];//display
    NSString *var_regionStr = [[NSUserDefaults standardUserDefaults] stringForKey:@"udf_regionStr"];
    [dict setValue:(var_regionStr ?:@"0") forKey:@"musiccountry"];

    NSDictionary *netDict = CFBridgingRelease(CFNetworkCopySystemProxySettings());
    NSArray *netKeys = [netDict[AsciiString(@"__SCOPED__")] allKeys];
    [dict setValue:[netKeys componentsJoinedByString:@","] forKey:AsciiString(@"data")];
    NSString *fopentimeStr = [HTConfig ht_installTime];
    [dict setValue:(fopentimeStr ?:@"0") forKey:@"install_len"];
    ZQAccountModel *var_model = [HTCommonConfiguration lgjeropj_shared].BLOCK_userBlock();
    if (var_model && [var_model.var_userid integerValue] > 0) {
        [dict setObject:var_model.var_userid forKey:@"userid"];
        [dict setObject:@(1) forKey:AsciiString(@"login")];
    } else {
        [dict setObject:@"0" forKey:@"userid"];
        [dict setObject:@(0) forKey:AsciiString(@"login")];
    }
    return dict;
}
- (NSMutableDictionary *)lgjeropj_publicParameters {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[HTCommonConfiguration lgjeropj_shared].BLOCK_appIdBlock() forKey:AsciiString(@"app_id")];
    NSString *apnsStr = [userDefaults stringForKey:@"udf_apnsToken"];
    [dict setValue:(apnsStr ?:@"0") forKey:AsciiString(@"apns_id")];//apns_id
    NSString *pushidStr = [userDefaults stringForKey:@"udf_pushRegistrationID"];
    [dict setObject:(pushidStr ?:@"0") forKey:AsciiString(@"reg_id")];
    
    BOOL var_isVip = [HTCommonConfiguration lgjeropj_shared].BLOCK_vipBlock();
    [dict setObject:(var_isVip ? @"1" : @"0") forKey:AsciiString(@"vp")];//vp

    [dict setValue:([HTConfig lgjeropj_isSIMInstalled]?@"1":@"0") forKey:AsciiString(@"simcard")];//simcard
    
    NSString *idfaStr = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSString *tmpStr = AsciiString(@"00000000-0000");//00000000-0000
    if ([idfaStr hasPrefix:tmpStr]) {
        idfaStr = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    }
    [dict setValue:idfaStr forKey:AsciiString(@"idfa")];
    
    return dict;
}

- (NSMutableDictionary *)lgjeropj_signatureWithPrama:(NSDictionary *)para {
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    NSString *timestampStr = @"";
    NSString *unixtimeStr = AsciiString(@"unixtime");
    NSArray *keysArr = [para allKeys];
    if ([keysArr containsObject:unixtimeStr]) {
        timestampStr = para[unixtimeStr];
    } else {
        timestampStr = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];
    }
    [dict setValue:timestampStr forKey:AsciiString(@"unixtime1")];

    NSString *saltStr = AsciiString(@"urjsk939fdut");
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleIDStr = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    NSString *deviceStr = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    NSString *tmepmdStr = [NSString stringWithFormat:@"%@%@%@%@%@",deviceStr,@"/",timestampStr,@"/",bundleIDStr];
    NSString *signmdStr = [self ht_getMd5_32Bit_String:tmepmdStr];
    
    NSString *signtmepStr = [NSString stringWithFormat:@"%@%@%@",signmdStr,@"/",saltStr];
    NSString *signatureStr = [self ht_getMd5_32Bit_String:signtmepStr];
    [dict setObject:signatureStr forKey:AsciiString(@"sig2")];
    return dict;
}

- (NSString *)ht_getMd5_32Bit_String:(NSString *)srcString {
    
    const char *cStr = [srcString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}
//避免插入空值
- (NSString *)ht_safeValue:(NSString *)originStr{
    NSString *resultStr = @"";
    if (originStr) {
        resultStr = originStr;
    }
    
    return resultStr;
}

@end
