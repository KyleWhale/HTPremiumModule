//
//  HTResponseModel.h
//  XMPPDemo
//
//  Created by mac on 2022/4/14.
//

#import "HTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTResponseModel : HTBaseModel

@property (nonatomic, assign) NSInteger       status;
@property (nonatomic, strong) id              data;
@property (nonatomic, strong) NSString      * msg;

@end

NS_ASSUME_NONNULL_END
