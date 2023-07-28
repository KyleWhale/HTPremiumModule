//
//  HTGuidePaymentViewController.h
//  Hucolla
//
//  Created by mac on 2022/9/21.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTGuidePaymentViewController : BaseViewController

@property (nonatomic, assign) NSInteger source;
@property (nonatomic, copy) BLOCK_HTVoidBlock     guideBlock;
@property (nonatomic, copy) BLOCK_HTVoidBlock     planBlock;

@end

NS_ASSUME_NONNULL_END
