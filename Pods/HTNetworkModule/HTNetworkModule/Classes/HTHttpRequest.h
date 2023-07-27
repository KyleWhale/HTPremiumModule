//
//  HTHttpRequest.h
//  Hucolla
//
//  Created by mac on 2020/10/9.
//  Copyright © 2020 Jerry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTResponseModel.h"
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BLOCK_HTRequestCompleteBlock)(id __nullable data, NSError * __nullable error);

@interface HTHttpRequest : NSObject

///网络请求管理者
+ (instancetype)sharedManager;

- (NSMutableDictionary *)lgjeropj_apiPublicParams;

///POST网络请求
- (void)ht_post:(NSString * __nonnull)urlString andParameters:( NSDictionary * __nullable )parameters andCompletion:(BLOCK_HTRequestCompleteBlock)completion;

- (void)ht_post:(NSString *)urlString andParameters:(NSDictionary *)parameters andTrans:(BOOL)var_trans andCompletion:(nonnull BLOCK_HTRequestCompleteBlock)completion;

///GET网络请求
- (void)ht_get:(NSString * __nonnull)URLString andParameters:(NSDictionary * __nullable)parameters andCompletion:(BLOCK_HTRequestCompleteBlock)completion;

@end

NS_ASSUME_NONNULL_END
