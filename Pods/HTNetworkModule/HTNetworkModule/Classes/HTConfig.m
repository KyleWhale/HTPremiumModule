//
//  HTConfig.m
//  Hucolla
//
//  Created by mac on 2022/9/14.
//

#import "HTConfig.h"
#import <sys/sysctl.h>

@implementation HTConfig

/// 公参 必传 手机设置获取
+ (NSString *)ht_lang {
    NSString *var_localeIden = [[NSLocale currentLocale] localeIdentifier];
    NSRange range = [var_localeIden rangeOfString:@"-"];
    if ( range.location != NSNotFound ) {
        var_localeIden = [var_localeIden substringToIndex:range.location];
    }
    return var_localeIden;
}

/// 公参 必传 手机设置获取 只有两个值 android / iOS
+ (NSString *)ht_device {
    return [[UIDevice currentDevice] systemName];
}

/// 公参 必传 app版本号
+ (NSString *)ht_appVer {
    
    NSString *var_appVer = [[NSBundle mainBundle] objectForInfoDictionaryKey:AsciiString(@"CFBundleShortVersionString")];
    return var_appVer;
}

/// 公参 必传 手机系统版本号
+ (NSString *)ht_osVer {
    NSString *var_vType = [[UIDevice currentDevice] systemVersion];
    return var_vType;
}

/// 公参 必传 手机分辨率
+ (NSString *)ht_resolution {
    CGRect rect_screen = [[UIScreen mainScreen] bounds];

    CGSize size = rect_screen.size;

    CGFloat scale = [UIScreen mainScreen].scale;
    
    NSString *resolution = [NSString stringWithFormat:@"%.f%@%.f",size.width*scale, @"x",size.height*scale];
    return resolution;
}

/// 公参 必传 设备id
+ (NSString *)ht_deviceNo {
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

/// 首次运行 YES 否则 NO
+ (BOOL)ht_firstRunApp {
    BOOL var_isFirst = ![[NSUserDefaults standardUserDefaults] boolForKey:@"udf_First_OpenApp"];
    if ( var_isFirst ) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"udf_First_OpenApp"];
        
        NSTimeInterval install = [[NSDate date] timeIntervalSince1970];
        [[NSUserDefaults standardUserDefaults] setDouble:install forKey:@"udf_InstallTime"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return var_isFirst;
}

/// app 安装时间
+ (NSString *)ht_installTime {
    NSTimeInterval install = [[NSUserDefaults standardUserDefaults] doubleForKey:@"udf_InstallTime"];
    return [NSString stringWithFormat:@"%.f",install];
}

+ (NSString *)lgjeropj_getPlatformString {
    size_t size;
    int number = sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    number = sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *string = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return (string ?: AsciiString(@"Unknown"));
}

// 判断设备是否安装sim卡
+ (BOOL)lgjeropj_isSIMInstalled {
    int simNum = [self lgjeropj_getSimCardNumInPhone];
    if (simNum > 0) {
        return YES;
    }
    return NO;
}

// 判断手机中sim卡数量
+ (int)lgjeropj_getSimCardNumInPhone {
    
     CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
     if (@available(iOS 12.0, *)) {
          NSDictionary *ctDict = networkInfo.serviceSubscriberCellularProviders;
          if ([ctDict allKeys].count > 1) {
               NSArray *keys = [ctDict allKeys];
               CTCarrier *carrier1 = [ctDict objectForKey:[keys firstObject]];
               CTCarrier *carrier2 = [ctDict objectForKey:[keys lastObject]];
               if (carrier1.mobileCountryCode.length && carrier2.mobileCountryCode.length) {
                    return 2;
               } else if (!carrier1.mobileCountryCode.length && !carrier2.mobileCountryCode.length) {
                    return 0;
               } else {
                    return 1;
               }
          } else if ([ctDict allKeys].count == 1) {
               NSArray *keys = [ctDict allKeys];
               CTCarrier *carrier1 = [ctDict objectForKey:[keys firstObject]];
               if (carrier1.mobileCountryCode.length) {
                    return 1;
               } else {
                    return 0;
               }
          } else {
               return 0;
          }
     }else {
          CTCarrier *carrier = [networkInfo subscriberCellularProvider];
          NSString *carrier_name = carrier.mobileCountryCode;
          if (carrier_name.length) {
               return 1;
          } else {
               return 0;
          }
     }
}

//获取时区
+ (NSString *)lgjeropj_destinationTimeZone {
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];//获取当前时区信息
    NSInteger sourceGMTOffset = [destinationTimeZone secondsFromGMTForDate:[NSDate date]];//获取偏移秒数
    NSString * sourceGMT = [NSString stringWithFormat:@"%ld",sourceGMTOffset/3600];
    return  sourceGMT;
}

// 得到当前屏幕的尺寸
+ (NSString *)lgjeropj_currentResolution {
    CGFloat width = UIScreen.mainScreen.bounds.size.width * UIScreen.mainScreen.scale;
    CGFloat height = UIScreen.mainScreen.bounds.size.height * UIScreen.mainScreen.scale;
    
    return [NSString stringWithFormat:@"%.0f%@%.0f",width,@"x",height];
}

@end
