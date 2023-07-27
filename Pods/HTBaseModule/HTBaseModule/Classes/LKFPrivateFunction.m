//
//  LKFPrivateFunction.m
//  Hucolla
//
//  Created by 李雪健 on 2022/10/24.
//

#import "LKFPrivateFunction.h"
#import "HTCommonMacro.h"
#import "HTCommonConfiguration.h"

@implementation LKFPrivateFunction

+ (NSString *)lgjeropj_stringFromAsciiArray:(id)object {
    
    if ([object isKindOfClass:[NSString class]]) {
        NSString *result = object;
        return result;
    } else if ([object isKindOfClass:[NSArray class]]) {
        NSMutableString *string = [NSMutableString string];
        for (NSNumber *code in object) {
            /*
             测试
             int codeInt = code.intValue - TP_App_Id.intValue;
             NSString *temp = [NSString stringWithFormat:@"%c",codeInt];
             */
            NSString *temp = [NSString stringWithFormat:@"%c",code.intValue];
            [string appendString:temp];
        }
        return string;
    }
    return @"";
}

+ (NSURL *)lgjeropj_imageUrlFromNumber:(NSInteger)number {
    
    NSString *base = [[NSUserDefaults standardUserDefaults] objectForKey:@"udf_imageDomain"];
    NSString *scale = AsciiString(@"@3x");
    NSString *suffix = AsciiString(@".png");
    NSString *picture = [NSString stringWithFormat:@"%@%ld%@%@", base, number, scale, suffix];
    return [NSURL URLWithString:picture];
}

+ (NSString *)lgjeropj_stringWithKid:(id)var_text {
    
    NSString *var_string = @"";
    if ([var_text isKindOfClass:[NSString class]]) {
        var_string = var_text;
    } else {
        var_string = [NSString stringWithFormat:@"%@%@", AsciiString(@"string"), var_text];
    }
    NSDictionary *var_contentDict = [HTCommonConfiguration lgjeropj_shared].BLOCK_mutilLanguageBlock();
    NSString *var_str = AsciiString(@"text");
    if (var_contentDict.count > 0 &&[var_contentDict.allKeys containsObject:var_string]) {
        var_str = [var_contentDict objectForKey:var_string];
    } else if (![var_string hasPrefix:AsciiString(@"string")]) {
        var_str = var_string;
    }
    return var_str;
}

@end
