//
//  HTPremiumHeaderCell.m
//  newNotes
//
//  Created by 李雪健 on 2022/10/27.
//

#import "HTPremiumHeaderCell.h"

@interface HTPremiumHeaderCell ()

@property (nonatomic, strong) UILabel *var_currentLabel;

@end

@implementation HTPremiumHeaderCell

- (void)ht_addCellSubViews {

    self.var_imageView = [[UIImageView alloc] init];
    self.var_imageView.userInteractionEnabled = YES;
    self.var_imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.var_imageView.layer.masksToBounds = YES;
    self.var_imageView.layer.cornerRadius = 12;
    [self.var_imageView sd_setImageWithURL:[LKFPrivateFunction lgjeropj_imageUrlFromNumber:250]];
    [self.contentView addSubview:self.var_imageView];
    [self.var_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.bottom.mas_equalTo(-5);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
    self.var_currentLabel = [[UILabel alloc] init];
    self.var_currentLabel.text = LocalString(@"Current Plan", nil);
    self.var_currentLabel.textColor = [UIColor colorWithHexString:@"#222222"];
    self.var_currentLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.var_imageView addSubview:self.var_currentLabel];
    [self.var_currentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(72);
        make.left.mas_equalTo(20);
    }];
    self.var_planLabel = [[UILabel alloc] init];
    self.var_planLabel.numberOfLines = 2;
    self.var_planLabel.textAlignment = NSTextAlignmentRight;
    self.var_planLabel.textColor = [UIColor colorWithHexString:@"#222222"];
    self.var_planLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.var_imageView addSubview:self.var_planLabel];
    [self.var_planLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.var_currentLabel);
        make.right.mas_equalTo(-20);
    }];
    
    self.var_lineView = [[UIView alloc] init];
    self.var_lineView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    [self.var_imageView addSubview:self.var_lineView];
    [self.var_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(72);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    self.var_hintLabel = [[UILabel alloc] init];
    self.var_hintLabel.textColor = [UIColor colorWithHexString:@"#222222"];
    self.var_hintLabel.font = [UIFont systemFontOfSize:14];
    self.var_hintLabel.text = LocalString(@"My Family", nil);
    [self.var_imageView addSubview:self.var_hintLabel];
    [self.var_hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    self.var_managerBtn = [[UIButton alloc] init];
    self.var_managerBtn.backgroundColor = [UIColor whiteColor];
    [self.var_managerBtn setTitleColor:[UIColor colorWithHexString:@"#222222"] forState:UIControlStateNormal];
    self.var_managerBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    self.var_managerBtn.layer.cornerRadius = 13;
    self.var_managerBtn.layer.masksToBounds = YES;
    [self.var_imageView addSubview:self.var_managerBtn];
    [self.var_managerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.equalTo(self.var_hintLabel);
        make.width.mas_equalTo(79);
        make.height.mas_equalTo(26);
    }];
    
    self.var_redView = [[UIView alloc] init];
    self.var_redView.backgroundColor = [UIColor redColor];
    self.var_redView.layer.cornerRadius = 3;
    self.var_redView.layer.masksToBounds = YES;
    [self.var_imageView addSubview:self.var_redView];
    [self.var_redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.var_managerBtn);
        make.size.mas_equalTo(6);
    }];
}

@end
