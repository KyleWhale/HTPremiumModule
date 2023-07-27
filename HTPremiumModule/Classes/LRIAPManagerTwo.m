//
//  LRIAPManagerTwo.m
//  Merriciya
//
//  Created by dn on 2022/9/14.
//

#import "LRIAPManagerTwo.h"

@implementation LRIAPManagerTwo

+ (NSDictionary *)localizedTrialDuraion:(SKProduct *)var_product {
    if (@available(iOS 11.2, *)) {
        NSNumberFormatter *var_priceFormatter = [[NSNumberFormatter alloc]init];
        var_priceFormatter.locale = var_product.introductoryPrice.priceLocale;
        
        NSDateComponentsFormatter *var_timeFormatter = [[NSDateComponentsFormatter alloc] init];
        [var_timeFormatter setUnitsStyle:NSDateComponentsFormatterUnitsStyleFull];
        var_timeFormatter.zeroFormattingBehavior = NSDateComponentsFormatterZeroFormattingBehaviorDropAll;
        NSDateComponents *var_dateComponents = [[NSDateComponents alloc]init];
        [var_dateComponents setCalendar:[NSCalendar currentCalendar]];
        if (var_product.introductoryPrice.subscriptionPeriod.unit == SKProductPeriodUnitDay) {
            var_timeFormatter.allowedUnits = NSCalendarUnitDay;
            [var_dateComponents setDay:var_product.introductoryPrice.subscriptionPeriod.numberOfUnits];
        } else if (var_product.introductoryPrice.subscriptionPeriod.unit == SKProductPeriodUnitWeek) {
            var_timeFormatter.allowedUnits = NSCalendarUnitWeekOfMonth;
            [var_dateComponents setWeekOfMonth:var_product.introductoryPrice.subscriptionPeriod.numberOfUnits];
        } else if (var_product.introductoryPrice.subscriptionPeriod.unit == SKProductPeriodUnitMonth) {
            var_timeFormatter.allowedUnits = NSCalendarUnitMonth;
            [var_dateComponents setMonth:var_product.introductoryPrice.subscriptionPeriod.numberOfUnits];
        } else if (var_product.introductoryPrice.subscriptionPeriod.unit == SKProductPeriodUnitYear) {
            var_timeFormatter.allowedUnits = NSCalendarUnitYear;
            [var_dateComponents setYear:var_product.introductoryPrice.subscriptionPeriod.numberOfUnits];
        }
        [var_dateComponents setValue:var_product.introductoryPrice.subscriptionPeriod.numberOfUnits forComponent:var_timeFormatter.allowedUnits];
        NSMutableDictionary *var_dic = [NSMutableDictionary dictionary];
        if (var_product.introductoryPrice.subscriptionPeriod.numberOfUnits > 0) {
            var_priceFormatter.numberStyle = NSNumberFormatterDecimalStyle;
            var_priceFormatter.decimalSeparator = @".";
            [var_dic setValue:[var_priceFormatter stringFromNumber:var_product.introductoryPrice.price] forKey:AsciiString(@"price")];
            var_priceFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
            [var_dic setValue:var_priceFormatter.currencySymbol forKey:AsciiString(@"unit")];
            [var_dic setValue:[var_timeFormatter stringFromDateComponents:var_dateComponents] forKey:AsciiString(@"time")];
            if (@available(iOS 12.2, *)) {
                [var_dic setValue:var_product.introductoryPrice.identifier forKey:AsciiString(@"id")];
            }
            return var_dic;
        }
        return nil;
    }
    return nil;
}

+ (void)lgjeropj_iapVerifyWithAppleStoreSandBox:(NSString *)var_iapUrlStr andBlock:(void(^)(NSInteger code, NSData *data))block
{
    //从沙盒中获取交易凭证并且拼接成请求体数据
    NSString *var_receiptString = [[NSData dataWithContentsOfURL:[[NSBundle mainBundle] appStoreReceiptURL]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSString *var_bodyString = [NSString stringWithFormat:AsciiString(@"{\"receipt-data\" : \"%@\", \"password\" : \"%@\"}"), var_receiptString, IAP_ShareKey];
    NSData *var_bodyData = [var_bodyString dataUsingEncoding:NSUTF8StringEncoding];
    //创建请求到苹果官方进行购买验证
    NSURL *var_url = [NSURL URLWithString:var_iapUrlStr];
    NSMutableURLRequest *var_requestM = [NSMutableURLRequest requestWithURL:var_url];
    var_requestM.HTTPBody = var_bodyData;
    var_requestM.HTTPMethod = AsciiString(@"POST");
    NSURLSessionConfiguration *var_configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *var_session = [NSURLSession sessionWithConfiguration:var_configuration];
    NSURLSessionDataTask *var_dataTask = [var_session dataTaskWithRequest:var_requestM completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            block(1, data);
        } else {
            block(0, nil);
        }
    }];
    [var_dataTask resume];
}

// 获取单人计划中周的价格,用于计算普通优惠的显示
+ (NSString *)lgjeropj_makeSinglePlanWeekPrice {
    
    NSString *var_priceStr = [NSString stringWithFormat:@"%d.%d", 1, 99];
    if ([[NSUserDefaults standardUserDefaults] arrayForKey:@"udf_iap_products"].count > 0) {
        for (NSDictionary *var_dict in [[NSUserDefaults standardUserDefaults] arrayForKey:@"udf_iap_products"]) {
            if ([[var_dict objectForKey:AsciiString(@"id")] isEqualToString:HT_IPA_Month]) {
                var_priceStr = [var_dict objectForKey:AsciiString(@"price")];
            }
        }
    }
    return var_priceStr;
}

// 按照 月年周+是否有trial 调整顺序
+ (NSMutableArray *)lgjeropj_changeArrayOrder:(NSMutableArray *)var_array {
    BOOL var_showFree = [[NSUserDefaults standardUserDefaults] boolForKey:@"udf_showFreeMonth"];
    if (![HTCommonConfiguration lgjeropj_shared].BLOCK_switchStateBlock()) {
        NSMutableArray *var_orderArr = [NSMutableArray arrayWithArray:@[@{}, @{}, @{}, @{}, @{}, @{}, @{}]];
        for (NSDictionary *var_dict in var_array) {
            NSString *var_id = [var_dict objectForKey:AsciiString(@"id")];
            if ([var_id isEqualToString:[NSString stringWithFormat:@"%@_%@", HT_IPA_Mosh, HT_IPA_Month]]) {
                [var_orderArr replaceObjectAtIndex:0 withObject:var_dict];
            } else if ([var_id isEqualToString:HT_IPA_Month]) {
                [var_orderArr replaceObjectAtIndex:1 withObject:var_dict];
            } else if ([var_id isEqualToString:HT_IPA_Year]) {
                [var_orderArr replaceObjectAtIndex:2 withObject:var_dict];
            } else if ([var_id isEqualToString:HT_IPA_Week]) {
                [var_orderArr replaceObjectAtIndex:3 withObject:var_dict];
            } else if ([var_id isEqualToString:[NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Month]]) {
                [var_orderArr replaceObjectAtIndex:4 withObject:var_dict];
            } else if ([var_id isEqualToString:[NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Year]]) {
                [var_orderArr replaceObjectAtIndex:5 withObject:var_dict];
            } else if ([var_id isEqualToString:[NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Week]]) {
                [var_orderArr replaceObjectAtIndex:6 withObject:var_dict];
            }
        }
        return var_orderArr;
    } else if (var_showFree) {
        // 显示免费订阅项
        NSMutableArray *var_orderArr = [NSMutableArray arrayWithArray:@[@{}, @{}, @{}, @{}, @{}, @{}]];
        for (NSDictionary *var_dict in var_array) {
            NSString *var_id = [var_dict objectForKey:AsciiString(@"id")];
            if ([var_id isEqualToString:[NSString stringWithFormat:@"%@_%@", HT_IPA_Mosh, HT_IPA_Month]]) {
                [var_orderArr replaceObjectAtIndex:0 withObject:var_dict];
            } else if ([var_id isEqualToString:HT_IPA_Year]) {
                [var_orderArr replaceObjectAtIndex:1 withObject:var_dict];
            } else if ([var_id isEqualToString:HT_IPA_Week]) {
                [var_orderArr replaceObjectAtIndex:2 withObject:var_dict];
            } else if ([var_id isEqualToString:[NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Month]]) {
                [var_orderArr replaceObjectAtIndex:3 withObject:var_dict];
            } else if ([var_id isEqualToString:[NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Year]]) {
                [var_orderArr replaceObjectAtIndex:4 withObject:var_dict];
            } else if ([var_id isEqualToString:[NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Week]]) {
                [var_orderArr replaceObjectAtIndex:5 withObject:var_dict];
            }
        }
        NSMutableArray *var_orderArray = var_orderArr;
        for (NSDictionary *var_dict in var_orderArr) {
            NSInteger type = [[var_dict objectForKey:AsciiString(@"type")] integerValue];
            if (type == 1) {
                NSDictionary *var_myDict = var_dict;
                NSInteger var_index = [var_orderArr indexOfObject:var_dict];
                [var_orderArray removeObjectAtIndex:var_index];
                [var_orderArr insertObject:var_myDict atIndex:0];
                break;
            }
        }
        return var_orderArray;
    }
    NSMutableArray *var_orderArr = [NSMutableArray arrayWithArray:@[@{}, @{}, @{}, @{}, @{}, @{}]];
    for (NSDictionary *var_dict in var_array) {
        NSString *var_id = [var_dict objectForKey:AsciiString(@"id")];
        if ([var_id isEqualToString:HT_IPA_Month]) {
            [var_orderArr replaceObjectAtIndex:0 withObject:var_dict];
        } else if ([var_id isEqualToString:HT_IPA_Year]) {
            [var_orderArr replaceObjectAtIndex:1 withObject:var_dict];
        } else if ([var_id isEqualToString:HT_IPA_Week]) {
            [var_orderArr replaceObjectAtIndex:2 withObject:var_dict];
        } else if ([var_id isEqualToString:[NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Month]]) {
            [var_orderArr replaceObjectAtIndex:3 withObject:var_dict];
        } else if ([var_id isEqualToString:[NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Year]]) {
            [var_orderArr replaceObjectAtIndex:4 withObject:var_dict];
        } else if ([var_id isEqualToString:[NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Week]]) {
            [var_orderArr replaceObjectAtIndex:5 withObject:var_dict];
        }
    }
    
    NSMutableArray *var_orderArray = var_orderArr;
    for (NSDictionary *var_dict in var_orderArr) {
        NSInteger var_type = [[var_dict objectForKey:AsciiString(@"type")] integerValue];
        if (var_type == 1) {
            NSDictionary *var_myDict = var_dict;
            NSInteger var_index = [var_orderArr indexOfObject:var_dict];
            [var_orderArray removeObjectAtIndex:var_index];
            [var_orderArr insertObject:var_myDict atIndex:0];
            break;
        }
    }
    return var_orderArray;
}

// IAP产品信息
+ (NSMutableArray *)lgjeropj_makeIapSingleData {
    NSMutableArray *var_sourceArr = nil;
    if ([[NSUserDefaults standardUserDefaults] arrayForKey:@"udf_iap_products"].count > 0) {
        NSMutableArray *var_singlePlanArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"udf_iap_products"]];
        NSString *var_weekPriceStr = [self lgjeropj_makeSinglePlanWeekPrice];
        NSMutableArray *var_planArray = [self lgjeropj_getIapProducts:var_singlePlanArray andWeekPrice:var_weekPriceStr];
        var_sourceArr = [NSMutableArray arrayWithArray:[self lgjeropj_changeArrayOrder:var_planArray]];
    } else {
        var_sourceArr = [NSMutableArray array];
    }
    
    return var_sourceArr;
}

+ (NSMutableArray *)lgjeropj_getIapProducts:(NSMutableArray *)var_arr andWeekPrice:(NSString *)var_weekPriceStr {
    NSMutableArray *var_planArray = [NSMutableArray new];
    for (NSDictionary *var_dict in var_arr) {
        NSString *var_d2Str = AsciiString(@"discount");// discount

        if ([[var_dict allKeys] containsObject:var_d2Str] ) {
            NSString *var_priceStr = [var_dict objectForKey:AsciiString(@"price")];
            NSString *var_dayCountStr = [var_dict objectForKey:AsciiString(@"count")];
            NSString *var_unitStr = [var_dict objectForKey:AsciiString(@"unit")];
            NSString *var_identifierStr = [var_dict objectForKey:AsciiString(@"id")];

            NSDictionary *var_discountDict = [var_dict objectForKey:var_d2Str];
            NSString *var_trialPriceStr = [var_discountDict objectForKey:AsciiString(@"price")];
            NSString *var_trialDurationStr = [var_discountDict objectForKey:AsciiString(@"time")];
            
            NSDictionary *var_dict = @{AsciiString(@"type"):@"1", AsciiString(@"id"):var_identifierStr, AsciiString(@"price"):var_priceStr, AsciiString(@"unit"):var_unitStr, AsciiString(@"count"):var_dayCountStr, AsciiString(@"wp"):var_weekPriceStr, AsciiString(@"trial"):@YES, AsciiString(@"tp"):var_trialPriceStr, AsciiString(@"td"):var_trialDurationStr};
            [var_planArray addObject:var_dict];
        } else {
            NSString *var_priceStr = [var_dict objectForKey:AsciiString(@"price")];
            NSString *var_dayCountStr = [var_dict objectForKey:AsciiString(@"count")];
            NSString *var_unitStr = [var_dict objectForKey:AsciiString(@"unit")];
            NSString *var_identifierStr = [var_dict objectForKey:AsciiString(@"id")];
            
            NSString *var_d4Str = [NSString stringWithFormat:@"%d.%d", 0, 99];//0.99

            NSDictionary *var_dict = @{AsciiString(@"type"):@"2", AsciiString(@"id"):var_identifierStr, AsciiString(@"price"):var_priceStr, AsciiString(@"unit"):var_unitStr, AsciiString(@"count"):var_dayCountStr, AsciiString(@"wp"):var_weekPriceStr, AsciiString(@"trial"):@NO, AsciiString(@"tp"):var_d4Str, AsciiString(@"td"):@""};
            [var_planArray addObject:var_dict];
        }
    }
    return var_planArray;
}
@end
