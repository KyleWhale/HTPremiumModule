//
//  HTFileManager.h
//  Hucolla
//
//  Created by mac on 2022/3/16.
//  Copyright © 2022 Jerry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTFileManager : NSObject

/// 创建文件夹
+ (BOOL)ht_createDirectoryAtPath:(NSString *)directoryPath;
/// 创建文件路径
+ (NSString *)ht_filePathWithSearchPath:(NSSearchPathDirectory)searchPath andDirectoryPath:(NSString *)directoryPath andFileName:(NSString *)fileName;

+ (NSURL *)ht_fileURLWithPath:(NSString *)filePath;

+ (NSURL *)ht_fileURLWithSearchPath:(NSSearchPathDirectory)searchPath andDirectoryPath:(NSString *)directoryPath andFileName:(NSString *)fileName;

+ (BOOL)ht_fileExistsAtPath:(NSString *)filePath;
/// 删除文件
+ (BOOL)ht_removeItemAtPath:(NSString *)filePath;
/// 取出文件
+ (NSData *)ht_contentsAtPath:(NSString *)filePath;
/// 写入文件
+ (BOOL)ht_createFileAtPath:(NSString *)filePath andContents:(NSData *)data;
/// 移动文件
+ (BOOL)ht_moveItemAtPath:(NSString *)atPath andToPath:(NSString *)toPath;
/// 保存文件内容（覆盖）
+ (BOOL)saveFileContentsAtPath:(NSString *)path andContentDic:(NSDictionary *)contentDic;

@end

NS_ASSUME_NONNULL_END
