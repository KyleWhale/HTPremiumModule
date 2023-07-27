//
//  HTBaseModel.m
//  Hucolla
//
//  Created by 李雪健 on 2022/10/24.
//

#import "HTBaseModel.h"
#import "LKFPrivateFunction.h"
#import "HTCommonMacro.h"

// 类名 HTBaseModel
// 方法名 modelCustomPropertyMapper
// [mapping setValue:@"混淆后的数字" forKey:@"混淆后的串"];
@implementation HTBaseModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    NSMutableDictionary *mapping = [[NSMutableDictionary alloc] init];
    [mapping setValue:@"id" forKey:@"ID"];
    [mapping setValue:AsciiString(@"description") forKey:AsciiString(@"desc")];
    [mapping setValue:AsciiString(@"hd") forKey:@"var_hd"];
    [mapping setValue:AsciiString(@"sd") forKey:@"var_sd"];

    return mapping;
}

@end
