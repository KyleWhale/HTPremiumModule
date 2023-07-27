//
//  HTUnSubscribeRemindView.m
//  Ziven
//
//  Created by 李雪健 on 2023/5/29.
//

#import "HTUnSubscribeRemindView.h"
#import "HTToolKitManager.h"
#import "HTPremiumPointManager.h"

@interface HTUnSubscribeRemindView ()

@property (nonatomic, strong) UIView *contentView;

@end

@implementation HTUnSubscribeRemindView

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
    [self.contentView addSubview:imageView];
    [imageView sd_setImageWithURL:[LKFPrivateFunction lgjeropj_imageUrlFromNumber:248]];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(24);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(66);
        make.height.mas_equalTo(51);
    }];
    
    UILabel *var_label = [[UILabel alloc] init];
    var_label.text = [AsciiString(@"You subscribed Both Premium in XXX") stringByReplacingOccurrencesOfString:AsciiString(@"XXX") withString:[[[HTToolKitManager shared] lgjeropj_strip_p1] objectForKey:AsciiString(@"t1")]];
    var_label.textColor = [UIColor colorWithHexString:@"#FFD29D"];
    var_label.font = [UIFont boldSystemFontOfSize:14];
    var_label.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:var_label];
    [var_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.equalTo(imageView.mas_bottom).offset(15);
        make.width.mas_lessThanOrEqualTo(270);
    }];
    
    UILabel *var_label1 = [[UILabel alloc] init];
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = infoDict[AsciiString(@"CFBundleDisplayName")];
    var_label1.text = [AsciiString(@"and need to unsubscribe the single premium in XXX") stringByReplacingOccurrencesOfString:AsciiString(@"XXX") withString:appName];
    var_label1.textColor = [UIColor colorWithHexString:@"#999999"];
    var_label1.font = [UIFont boldSystemFontOfSize:14];
    var_label1.textAlignment = NSTextAlignmentCenter;
    var_label1.numberOfLines = 0;
    [self.contentView addSubview:var_label1];
    [var_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.equalTo(var_label.mas_bottom);
        make.width.mas_lessThanOrEqualTo(270);
    }];
    
    UIButton *var_button = [[UIButton alloc] init];
    var_button.backgroundColor = [UIColor colorWithHexString:@"#FDDDB7"];
    var_button.layer.masksToBounds = YES;
    var_button.layer.cornerRadius = 22;
    [var_button setTitle:AsciiString(@"Unsubscribe") forState:UIControlStateNormal];
    [var_button setTitleColor:[UIColor colorWithHexString:@"#685034"] forState:UIControlStateNormal];
    var_button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [var_button addTarget:self action:@selector(lgjeropj_subscribeAction) forControlEvents:UIControlEventTouchUpInside];
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
    
    [self lgjeropj_show_maidian];
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

- (void)lgjeropj_subscribeAction {
    
    [self lgjeropj_click_maidian:47];
    [self lgjeropj_dismiss];
    NSURL *var_url = [NSURL URLWithString:AsciiString(@"https://apps.apple.com/account/subscriptions")];
    [[UIApplication sharedApplication] openURL:var_url options:@{} completionHandler:nil];
}

- (void)lgjeropj_skipAction {
    
    if (self.block) {
        self.block();
    }
    [self lgjeropj_click_maidian:48];
    [self lgjeropj_dismiss];
}

- (void)lgjeropj_click_maidian:(NSInteger)kid
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@(44) forKey:AsciiString(@"source")];
    [params setValue:@(kid) forKey:AsciiString(@"kid")];
    [params setValue:@"vip_cl" forKey:@"pointname"];
    [HTPremiumPointManager lgjeropj_maidianRequestWithParams:params];
}

- (void)lgjeropj_show_maidian
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@(44) forKey:AsciiString(@"source")];
    [params setValue:@"vip_sh" forKey:@"pointname"];
    [HTPremiumPointManager lgjeropj_maidianRequestWithParams:params];
}

@end
