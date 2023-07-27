//
//  HTFakeCardController.h
//  Ziven
//
//  Created by 李雪健 on 2023/5/29.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTFakeCardController : BaseViewController

@property (nonatomic, copy) void (^block) (void);

@end

NS_ASSUME_NONNULL_END
