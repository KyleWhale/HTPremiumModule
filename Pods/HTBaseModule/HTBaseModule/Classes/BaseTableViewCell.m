//
//  BaseTableViewCell.m
//  Hucolla
//
//  Created by mac on 2022/9/14.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self ) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
