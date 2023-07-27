//
//  HTRemindAddFamilyMemberView.m
//  Ziven
//
//  Created by 李雪健 on 2023/5/29.
//

#import "HTRemindAddFamilyMemberView.h"
#import "HTToolKitManager.h"

@interface HTRemindAddFamilyMemberView ()

@property (nonatomic, strong) UIView *contentView;

@end

@implementation HTRemindAddFamilyMemberView

- (void)lgjeropj_alertView {
 
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#292A2F"];
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 16;
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.mas_equalTo(300);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[LKFPrivateFunction lgjeropj_imageUrlFromNumber:265]];
    imageView.layer.cornerRadius = 12;
    imageView.layer.masksToBounds = YES;
    [self.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(140);
    }];
    
    UILabel *var_label = [[UILabel alloc] init];
    var_label.text = AsciiString(@"Add Your Family Members");
    var_label.textColor = [UIColor colorWithHexString:@"#FFD29D"];
    var_label.font = [UIFont boldSystemFontOfSize:14];
    var_label.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:var_label];
    [var_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.equalTo(imageView.mas_bottom).offset(5);
        make.width.mas_lessThanOrEqualTo(270);
    }];
    
    UILabel *var_label1 = [[UILabel alloc] init];
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    var_label1.text = AsciiString(@"Enjoy The Premium Journey With Your Family");
    var_label1.textColor = [UIColor colorWithHexString:@"#999999"];
    var_label1.font = [UIFont boldSystemFontOfSize:14];
    var_label1.textAlignment = NSTextAlignmentCenter;
    var_label1.numberOfLines = 0;
    [self.contentView addSubview:var_label1];
    [var_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.equalTo(var_label.mas_bottom).offset(5);
        make.width.mas_lessThanOrEqualTo(270);
    }];
    
    UIButton *var_button = [[UIButton alloc] init];
    var_button.backgroundColor = [UIColor colorWithHexString:@"#FDDDB7"];
    var_button.layer.masksToBounds = YES;
    var_button.layer.cornerRadius = 22;
    [var_button setTitle:AsciiString(@"Add Now") forState:UIControlStateNormal];
    [var_button setTitleColor:[UIColor colorWithHexString:@"#685034"] forState:UIControlStateNormal];
    var_button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [var_button addTarget:self action:@selector(lgjeropj_addAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:var_button];
    [var_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(var_label1.mas_bottom).offset(44);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(238);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *var_skipBtn = [[UIButton alloc] init];
    [var_skipBtn setTitle:LocalString(@"Later", nil) forState:UIControlStateNormal];
    [var_skipBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    [var_skipBtn.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
    [var_skipBtn.titleLabel setAttributedText:[[NSAttributedString alloc] initWithString:LocalString(@"Later", nil) attributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)}]];
    [var_skipBtn addTarget:self action:@selector(lgjeropj_skipAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:var_skipBtn];
    [var_skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(var_button.mas_bottom).offset(10);
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-20);
    }];
}

- (void)lgjeropj_show {
    
    [self lgjeropj_alertView];

    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    if ([self isDescendantOfView:window] == NO) {
        [window addSubview:self];
    }
    self.frame = [UIScreen mainScreen].bounds;
    self.contentView.alpha = 0;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.alpha = 1;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        [self layoutIfNeeded];
    }];
}

- (void)lgjeropj_dismiss {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.alpha = 0;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)lgjeropj_addAction {
    
    if (self.block) {
        self.block();
    }
    [self lgjeropj_dismiss];
}

- (void)lgjeropj_skipAction {
    
    [self lgjeropj_dismiss];
}

@end
