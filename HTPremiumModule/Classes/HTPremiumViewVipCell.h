//
//  HTPremiumViewVipCell.h
//  Hucolla
//
//  Created by mac on 2022/9/16.
//

#import "BaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTPremiumViewVipCell : BaseCollectionViewCell

@property (nonatomic, copy) BLOCK_dataBlock    cellBlock;

@property (nonatomic, copy) BLOCK_HTVoidBlock    vipBlock;

@end

NS_ASSUME_NONNULL_END
