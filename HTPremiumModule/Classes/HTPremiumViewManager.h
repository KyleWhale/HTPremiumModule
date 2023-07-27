//
//  HTPremiumViewManager.h
//  Moshfocus
//
//  Created by 李雪健 on 2023/6/7.
//

#import <Foundation/Foundation.h>
#import "HTPremiumViewInfoCell.h"
#import "HTPremiumHeaderCell.h"
#import "HTPremiumEmptyCell.h"
#import "HTPremiumNewCardCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTPremiumViewManager : NSObject

+ (UILabel *)lgjeropj_removeLabel;

+ (UICollectionView *)lgjeropj_collectionView:(id)target;

+ (void)lgjeropj_guideAction;

+ (NSArray *)lgjeropj_hintArray;

+ (CGFloat)lgjeropj_getScale;

+ (void)lgjeropj_maidianVipShow:(NSInteger)source;

+ (void)lgjeropj_maidianVipClick:(NSString *)kidStr source:(NSInteger)source;

@end

NS_ASSUME_NONNULL_END
