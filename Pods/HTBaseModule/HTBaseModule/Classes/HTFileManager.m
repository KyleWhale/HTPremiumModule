//
//  HTFileManager.m
//  Hucolla
//
//  Created by mac on 2022/3/16.
//  Copyright © 2022 Jerry. All rights reserved.
//

#import "HTFileManager.h"

@implementation HTFileManager

+ (BOOL)ht_createDirectoryAtPath:(NSString *)directoryPath {
    NSError *error;
    BOOL isSuccess = [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:&error];
    if ( error ) {
        NSLog(@"创建错误 %@",error.description);
    }
    return isSuccess;
}

+ (NSString *)ht_filePathWithSearchPath:(NSSearchPathDirectory)searchPath andDirectoryPath:(NSString *)directoryPath andFileName:(NSString *)fileName {
    // 目录
    NSString *path = [NSSearchPathForDirectoriesInDomains(searchPath, NSUserDomainMask, YES) lastObject];
    // 文件夹
    NSString * dirPath = [NSString stringWithFormat:@"%@/%@",path,directoryPath];
    if ( [directoryPath hasPrefix:@"/"] ) {
        dirPath = [NSString stringWithFormat:@"%@%@",path,directoryPath];
    }
    if ( [directoryPath hasSuffix:@"/"] ) {
        dirPath = [dirPath substringToIndex:dirPath.length - 1];
    }
    // 文件路径
    NSString * filePath = [NSString stringWithFormat:@"%@/%@",dirPath,fileName];
    if ( [fileName hasPrefix:@"/"] ) {
        filePath = [NSString stringWithFormat:@"%@%@",dirPath,fileName];
    }
    
    ///特别注意，第一次需要先创建文件所在目录，否则用filePath取出的文件是空的
    if ( [[NSFileManager defaultManager] fileExistsAtPath:filePath] == NO ) {
        [self ht_createDirectoryAtPath:dirPath];
    }
    return filePath;
}

+ (NSURL *)ht_fileURLWithPath:(NSString *)filePath {
    return [NSURL fileURLWithPath:filePath];
}

+ (NSURL *)ht_fileURLWithSearchPath:(NSSearchPathDirectory)searchPath andDirectoryPath:(NSString *)directoryPath andFileName:(NSString *)fileName {
    NSString *filePath = [self ht_filePathWithSearchPath:searchPath andDirectoryPath:directoryPath andFileName:fileName];
    return [self ht_fileURLWithPath:filePath];
}

+ (BOOL)ht_fileExistsAtPath:(NSString *)filePath {
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

+ (BOOL)ht_removeItemAtPath:(NSString *)filePath {
    if ( [[NSFileManager defaultManager] fileExistsAtPath:filePath] ) {
        NSError *error;
        BOOL isSuccess = [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        if ( isSuccess == NO ) {
            NSLog(@"Remmve error: %@",error.description);
        }
        return isSuccess;
    }
    return NO;
}

+ (NSData *)ht_contentsAtPath:(NSString *)filePath {
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:filePath];
    return data;
}

+ (BOOL)ht_createFileAtPath:(NSString *)filePath andContents:(NSData *)data {
    BOOL isSuccess = [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
    return isSuccess;
}

+ (BOOL)ht_moveItemAtPath:(NSString *)atPath andToPath:(NSString *)toPath {
    NSError *error;
    BOOL isSuccess = [[NSFileManager defaultManager] moveItemAtPath:atPath toPath:toPath error:&error];
    
    if ( isSuccess == NO ) {
        NSLog(@"Remmve error: %@",error.description);
    }
    return isSuccess;
}

// 保存文件内容（覆盖）
+ (BOOL)saveFileContentsAtPath:(NSString *)path andContentDic:(NSDictionary *)contentDic {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if (![fileManager fileExistsAtPath:path isDirectory:&isDir]) {//先判断目录是否存在，不存在才创建
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:contentDic options:0 error:nil];
        if (jsonData) {
            return [fileManager createFileAtPath:path contents:jsonData attributes:nil];
        } else {
            return NO;
        }
    } else {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:contentDic options:0 error:nil];
        if (jsonData) {
            return [jsonData writeToFile:path atomically:YES];
        } else {
            return NO;
        }
    }
}


@end
