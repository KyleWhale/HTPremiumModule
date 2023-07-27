//
//  HTPremiumEmptyCell.h
//  WillDrawApp
//
//  Created by 昊天 on 2023/1/4.
//

#import "BaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTPremiumEmptyCell : BaseCollectionViewCell
@property (nonatomic, copy) BLOCK_HTVoidBlock emptyBlock;
@property (nonatomic, strong) UIView *remindView;

@end

NS_ASSUME_NONNULL_END
