//
//  HTPremiumFakeCardCell.h
//  Moshfocus
//
//  Created by 李雪健 on 2023/6/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BLOCK_IntegerBlock)(NSInteger index);
typedef void(^BLOCK_PayEventBlock)(NSDictionary *dic);

@interface HTPremiumNewCardCell : UICollectionViewCell

// type=0 个人计划 type=1 家庭计划
@property (nonatomic, copy) BLOCK_IntegerBlock typeBlock;
// 选中下标
@property (nonatomic, copy) BLOCK_IntegerBlock indexBlock;
// pay
@property (nonatomic, copy) BLOCK_PayEventBlock payBlock;
// restore
@property (nonatomic, copy) BLOCK_HTVoidBlock restoreBlock;

- (void)lgjeropj_updateCellWithData:(NSArray *)var_individualData andFamilyData:(NSArray *)var_familyData;

@end

NS_ASSUME_NONNULL_END
