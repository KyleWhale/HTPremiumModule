//
//  HTToolSubscribeAlertView.m
//  Ziven
//
//  Created by 李雪健 on 2023/5/29.
//

#import "HTToolSubscribeAlertView.h"
#import "HTToolKitManager.h"
#import "HTPremiumPointManager.h"

@interface HTToolSubscribeAlertView ()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) NSDictionary *var_params;

@property (nonatomic, assign) NSInteger source;

@end

@implementation HTToolSubscribeAlertView

- (void)lgjeropj_alertView {
 
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#292A2F"];
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 12;
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.mas_equalTo(300);
    }];
    
    NSDictionary *dic = [[HTToolKitManager shared] lgjeropj_strip_p1];
    NSString *var_gif = dic[AsciiString(@"gif")];
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:imageView];
    [imageView sd_setImageWithURL:[NSURL URLWithString:var_gif]];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(36);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(220);
    }];
    
    UILabel *var_label = [[UILabel alloc] init];
    var_label.text = [LocalString(@"Subscribe at XXX to become PREM", nil) stringByReplacingOccurrencesOfString:AsciiString(@"XXX") withString:[[[HTToolKitManager shared] lgjeropj_strip_p1] objectForKey:AsciiString(@"t1")]];
    var_label.textColor = [UIColor colorWithHexString:@"#FFD29D"];
    var_label.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:var_label];
    [var_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.equalTo(imageView.mas_bottom).offset(25);
    }];
    
    UIButton *var_button = [[UIButton alloc] init];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, 238, 44);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"#EDC391"].CGColor, (__bridge id)[UIColor colorWithHexString:@"#FDDDB7"].CGColor];
    [var_button.layer addSublayer:gradientLayer];
    var_button.layer.masksToBounds = YES;
    var_button.layer.cornerRadius = 22;
    [var_button setTitle:[[HTToolKitManager shared] lgjeropj_installed] ? AsciiString(@"Go Subscribe") : AsciiString(@"Install") forState:UIControlStateNormal];
    [var_button setTitleColor:[UIColor colorWithHexString:@"#685034"] forState:UIControlStateNormal];
    var_button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [var_button addTarget:self action:@selector(lgjeropj_subscribeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:var_button];
    [var_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(var_label.mas_bottom).offset(35);
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

- (void)lgjeropj_toastView {
    
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#323232"];
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 12;
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.mas_equalTo(260);
        make.height.mas_equalTo(63);
    }];
    UILabel *toastView = [[UILabel alloc] init];
    toastView.text = [NSString stringWithFormat:@"%@%@", [LocalString(@"Proceeding to XXX to complete payment", nil) stringByReplacingOccurrencesOfString:AsciiString(@"XXX") withString:[[[HTToolKitManager shared] lgjeropj_strip_p1] objectForKey:AsciiString(@"t1")]], @"..."];
    toastView.textColor = [UIColor colorWithHexString:@"#FFD770"];
    toastView.font = [UIFont boldSystemFontOfSize:14];
    toastView.textAlignment = NSTextAlignmentCenter;
    toastView.numberOfLines = 0;
    [self.contentView addSubview:toastView];
    [toastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.mas_lessThanOrEqualTo(240);
    }];
}

- (void)lgjeropj_show:(NSDictionary *)dic source:(NSInteger)source {
    
    [HTCommonConfiguration lgjeropj_shared].BLOCK_stopAdBlock(YES);
    self.source = source;
    self.var_params = dic;
    NSInteger var_count = [[NSUserDefaults standardUserDefaults] integerForKey:@"udf_toolkit_guide_count"];
    BOOL var_alert = var_count < 3;
    if (var_alert) {
        [self lgjeropj_show_maidian];
        [self lgjeropj_alertView];
        [[NSUserDefaults standardUserDefaults] setInteger:var_count+1 forKey:@"udf_toolkit_guide_count"];
    } else {
        [self lgjeropj_toastView];
    }

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
    } completion:^(BOOL finished) {
        if (!var_alert) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self lgjeropj_subscribeAction];
            });
        }
    }];
}

- (void)lgjeropj_dismiss {
    
    [HTCommonConfiguration lgjeropj_shared].BLOCK_stopAdBlock(NO);
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.alpha = 0;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)lgjeropj_subscribeAction {
    
    [self lgjeropj_click_maidian:1];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@"1" forKey:AsciiString(@"type")];
    NSString *var_product = self.var_params[AsciiString(@"product")];
    if ([var_product isEqualToString:AsciiString(@"week")]) {
        var_product = @"1";
    } else if ([var_product isEqualToString:AsciiString(@"month")]) {
        var_product = @"2";
    } else if ([var_product isEqualToString:AsciiString(@"year")]) {
        var_product = @"3";
    } else if ([var_product isEqualToString:AsciiString(@"fw")]) {
        var_product = @"4";
    } else if ([var_product isEqualToString:AsciiString(@"fm")]) {
        var_product = @"5";
    } else if ([var_product isEqualToString:AsciiString(@"fy")]) {
        var_product = @"6";
    }
    // 1:个人周 2:个人月 3:个人年 4:家庭周 5:家庭月 6:家庭年
    [params setValue:var_product forKey:AsciiString(@"product")];
    NSInteger var_activity = [self.var_params[AsciiString(@"activity")] integerValue];
    [params setValue:var_activity > 0 ? var_product : @"0" forKey:AsciiString(@"activityProduct")];
    // var_shopLink var_targetBundle var_targetLink
    NSDictionary *data = [[HTToolKitManager shared] lgjeropj_airplay];
    NSString *var_appleId = data[AsciiString(@"appleid")];
    NSString *var_shopLink = [NSString stringWithFormat:@"%@%@", AsciiString(@"https://apps.apple.com/app/id"), var_appleId];
    [params setValue:var_shopLink forKey:@"var_shopLink"];
    [params setValue:[data objectForKey:AsciiString(@"bundleid")] forKey:@"var_targetBundle"];
    [params setValue:[data objectForKey:AsciiString(@"l1")] forKey:@"var_targetLink"];
    [params setValue:[data objectForKey:AsciiString(@"k2")] forKey:@"var_dynamicK2"];
    [params setValue:[data objectForKey:AsciiString(@"c4")] forKey:@"var_dynamicC4"];
    [params setValue:[data objectForKey:AsciiString(@"c5")] forKey:@"var_dynamicC5"];
    [params setValue:[data objectForKey:AsciiString(@"logo")] forKey:@"var_dynamicLogo"];
    [[UIApplication sharedApplication] openURL:[HTCommonConfiguration lgjeropj_shared].BLOCK_deepLinkBlock(params) options:@{} completionHandler:^(BOOL success) {}];
    [self removeFromSuperview];
}

- (void)lgjeropj_skipAction {
    
    [self lgjeropj_click_maidian:2];
    [self lgjeropj_dismiss];
}

- (void)lgjeropj_click_maidian:(NSInteger)kid
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@(self.source) forKey:AsciiString(@"source")];
    [params setValue:@(kid) forKey:AsciiString(@"kid")];
    [params setValue:@"tspop_cl" forKey:@"pointname"];
    [HTPremiumPointManager lgjeropj_maidianRequestWithParams:params];
}

- (void)lgjeropj_show_maidian
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@(self.source) forKey:AsciiString(@"source")];
    [params setValue:@"tspop_sh" forKey:@"pointname"];
    [HTPremiumPointManager lgjeropj_maidianRequestWithParams:params];
}

@end
