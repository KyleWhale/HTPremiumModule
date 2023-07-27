//
//  HTPremiumPointManager.m
//  PostTest
//
//  Created by 李雪健 on 2023/7/27.
//

#import "HTPremiumPointManager.h"
#import "HTHttpRequest.h"

@implementation HTPremiumPointManager

+ (void)lgjeropj_maidianRequestWithParams:(NSDictionary *)dict
{
    NSMutableDictionary *var_params = [[NSMutableDictionary alloc] init];
    [var_params addEntriesFromDictionary:dict];
    NSString *var_urlString = AsciiString(@"data");
    [[HTHttpRequest sharedManager] ht_get:var_urlString andParameters:var_params andCompletion:^(HTResponseModel *model, NSError * _Nonnull error) {}];
}

@end
