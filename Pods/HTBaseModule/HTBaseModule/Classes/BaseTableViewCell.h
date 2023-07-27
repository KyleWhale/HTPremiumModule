//
//  BaseTableViewCell.h
//  Hucolla
//
//  Created by mac on 2022/9/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewCell : UITableViewCell

- (void)ht_addCellSubViews;

- (void)ht_updateCellWithData:(id)data;

- (CGFloat)ht_cellHeight;

@end

NS_ASSUME_NONNULL_END
