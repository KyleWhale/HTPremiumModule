//
//  BaseCollectionViewCell.h
//  Hucolla
//
//  Created by mac on 2022/9/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseCollectionViewCell : UICollectionViewCell

- (void)ht_addCellSubViews;

- (void)ht_updateCellWithData:(id)data;

- (CGFloat)ht_cellHeight;

@end

NS_ASSUME_NONNULL_END
