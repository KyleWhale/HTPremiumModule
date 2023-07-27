//
//  BaseCollectionViewCell.m
//  Hucolla
//
//  Created by mac on 2022/9/13.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( self ) {
        [self ht_addCellSubViews];
    }
    return self;
}

- (void)ht_addCellSubViews {
    
}

- (void)ht_updateCellWithData:(id)data {
    
}

- (CGFloat)ht_cellHeight {
    return 0;
}

@end
