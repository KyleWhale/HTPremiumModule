//
//  HTConfig.h
//  Hucolla
//
//  Created by mac on 2022/9/14.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "HTCommonHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTConfig : NSObject

/// 公参 必传 手机设置获取
+ (NSString *)ht_lang;

/// 公参 必传 手机设置获取 只有两个值 android / iOS
+ (NSString *)ht_device;

/// 公参 必传 app版本号
+ (NSString *)ht_appVer;

/// 公参 必传 手机系统版本号
+ (NSString *)ht_osVer;

/// 公参 必传 手机分辨率
+ (NSString *)ht_resolution;

/// 公参 必传 设备id
+ (NSString *)ht_deviceNo;

/// 首次运行 YES 否则 NO
+ (BOOL)ht_firstRunApp;

/// app 安装时间 10位数时间戳
+ (NSString *)ht_installTime;

/// 设备型号
+ (NSString *)lgjeropj_getPlatformString;

/// 判断设备是否安装sim卡
+ (BOOL)lgjeropj_isSIMInstalled;

/// 获取时区
+ (NSString *)lgjeropj_destinationTimeZone;

/// 得到当前屏幕的尺寸
+ (NSString *)lgjeropj_currentResolution;

@end

NS_ASSUME_NONNULL_END
