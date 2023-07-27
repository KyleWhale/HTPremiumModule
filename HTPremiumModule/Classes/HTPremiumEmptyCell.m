//
//  HTPremiumEmptyCell.m
//  WillDrawApp
//
//  Created by 昊天 on 2023/1/4.
//

#import "HTPremiumEmptyCell.h"
#import "HTPremiumEmptyCellManager.h"

@interface HTPremiumEmptyCell ()

@property (nonatomic, strong) UIImageView *var_imageView;
@property (nonatomic, strong) UILabel *var_currentLabel;

@end

@implementation HTPremiumEmptyCell

- (void)ht_addCellSubViews
{
    CGFloat remindHeight = 300;
    self.remindView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, remindHeight)];
    [self.contentView addSubview:self.remindView];
    self.remindView.backgroundColor = [UIColor clearColor];
    
    UILabel *warnLab = [HTPremiumEmptyCellManager lgjeropj_warning];
    [self.remindView addSubview:warnLab];
    
    UIImageView *warnLeftImg = [HTPremiumEmptyCellManager lgjeropj_left];
    warnLeftImg.frame = CGRectMake(CGRectGetMinX(warnLab.frame) -32, 32, 32, 16);
    [self.remindView addSubview:warnLeftImg];
    UIImageView *warnRightImg = [HTPremiumEmptyCellManager lgjeropj_right];
    warnRightImg.frame = CGRectMake(CGRectGetMaxX(warnLab.frame), 32, 32, 16);
    [self.remindView addSubview:warnRightImg];
    
    UILabel *contentLab = [HTPremiumEmptyCellManager lgjeropj_contentLabel];
    contentLab.frame = CGRectMake(20, CGRectGetMaxY(warnLab.frame), kScreenWidth-40, contentLab.height);
    [self.remindView addSubview:contentLab];
    
    CGFloat tapYHeight = CGRectGetMaxY(contentLab.frame)+20;
    if (tapYHeight + 50 > remindHeight) {
        tapYHeight = remindHeight - 50;
    }
    UIButton *tapButton = [HTPremiumEmptyCellManager lgjeropj_tapButton:self action:@selector(lgjeropj_tapButtonAction:)];
    tapButton.frame = CGRectMake(kScreenWidth*0.15, tapYHeight, kScreenWidth*0.7, 50);
    [self.remindView addSubview:tapButton];
}

- (void)lgjeropj_tapButtonAction:(UIButton *)button {
    if ( self.emptyBlock ) {
        self.emptyBlock();
    }
}

@end
