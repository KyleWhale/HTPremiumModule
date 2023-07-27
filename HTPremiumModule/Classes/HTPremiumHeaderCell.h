//
//  HTPremiumHeaderCell.h
//  newNotes
//
//  Created by 李雪健 on 2022/10/27.
//

#import "BaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTPremiumHeaderCell : BaseCollectionViewCell

@property (nonatomic, strong) UILabel *var_planLabel;
@property (nonatomic, strong) UIImageView *var_imageView;
@property (nonatomic, strong) UIView *var_lineView;
@property (nonatomic, strong) UILabel *var_hintLabel;
@property (nonatomic, strong) UIButton *var_managerBtn;
@property (nonatomic, strong) UIView *var_redView;

@end

NS_ASSUME_NONNULL_END
