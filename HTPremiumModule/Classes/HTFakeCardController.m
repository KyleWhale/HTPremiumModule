//
//  HTFakeCardController.m
//  Ziven
//
//  Created by 李雪健 on 2023/5/29.
//

#import "HTFakeCardController.h"
#import "HTToolKitManager.h"
#import "SDWebImageDownloader.h"
#import "SDImageCache.h"
#import "HTPremiumPointManager.h"

@interface HTFakeCardController ()

@property (nonatomic, strong) UIControl *var_backgroundView;
@property (nonatomic, strong) UIView *var_contentView;
@property (nonatomic, copy) dispatch_block_t var_after;

@end

@implementation HTFakeCardController

- (void)dealloc {
    [HTCommonConfiguration lgjeropj_shared].BLOCK_stopAdBlock(NO);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [HTCommonConfiguration lgjeropj_shared].BLOCK_stopAdBlock(YES);
    [self lgjeropj_initViews];
    [self lgjeropj_show_maidian];
    // 预加载一下图片
    NSDictionary *dic = [[HTToolKitManager shared] lgjeropj_strip_p1];
    NSString *var_gif = dic[AsciiString(@"gif")];
    NSString *var_path = [[SDImageCache sharedImageCache] cachePathForKey:var_gif];
    if (var_path == nil || var_path.length == 0) {
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:var_gif] completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {}];
    }
}

- (void)lgjeropj_initViews {
    
    self.view.backgroundColor = [UIColor blackColor];
    UIImageView *var_backgroundView = [[UIImageView alloc] init];
    [var_backgroundView sd_setImageWithURL:[LKFPrivateFunction lgjeropj_imageUrlFromNumber:254]];
    var_backgroundView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:var_backgroundView];
    [var_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    UIView *var_contentView = [[UIView alloc] init];
    [self.view addSubview:var_contentView];
    [var_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.center.mas_equalTo(0);
    }];
    
    UIView *var_blackView = [[UIView alloc] init];
    var_blackView.backgroundColor = [UIColor blackColor];
    [var_contentView addSubview:var_blackView];
    [var_blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(72);
        make.top.mas_equalTo(0);
    }];
    
    UILabel *var_priceLabel = [[UILabel alloc] init];
    var_priceLabel.text = [[[HTToolKitManager shared] lgjeropj_strip_p1] objectForKey:AsciiString(@"t5")];
    var_priceLabel.font = [UIFont boldSystemFontOfSize:20];
    var_priceLabel.textColor = [UIColor colorWithHexString:@"#FFD770"];
    [var_blackView addSubview:var_priceLabel];
    [var_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(28);
        make.right.mas_equalTo(-28);
        make.top.mas_equalTo(13);
    }];
    
    UILabel *var_hintLabel = [[UILabel alloc] init];
    var_hintLabel.text = LocalString(@"Become PREM & Enjoy Uninterrupted Viewing", nil);
    var_hintLabel.font = [UIFont boldSystemFontOfSize:13];
    var_hintLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [var_blackView addSubview:var_hintLabel];
    [var_hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(28);
        make.right.mas_equalTo(-28);
        make.bottom.mas_equalTo(-10);
    }];
    
    UIView *var_colorView = [[UIView alloc] init];
    var_colorView.backgroundColor = [UIColor colorWithHexString:@"#3B3838"];
    var_colorView.layer.masksToBounds = YES;
    var_colorView.layer.cornerRadius = 12;
    [var_contentView addSubview:var_colorView];
    [var_colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(var_blackView.mas_bottom).offset(68);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(332);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    NSString *var_gif = [[[[HTToolKitManager shared] lgjeropj_strip_p2] objectForKey:AsciiString(@"gif")] firstObject];
    [imageView sd_setImageWithURL:[NSURL URLWithString:var_gif]];
    [var_colorView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(187);
    }];
    
    UIView *var_interestView = [[UIView alloc] init];
    [var_colorView addSubview:var_interestView];
    [var_interestView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(48);
    }];
    
    UILabel *var_interestLabel = [[UILabel alloc] init];
    var_interestLabel.text = [NSString stringWithFormat:@"%@%@", LocalString(@"All PREM Privileges", nil), @":"];
    var_interestLabel.textColor = [UIColor colorWithWhite:1 alpha:0.5];
    var_interestLabel.font = [UIFont boldSystemFontOfSize:13];
    [var_interestView addSubview:var_interestLabel];
    [var_interestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(0);
    }];
    
    CGFloat width = [var_interestLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, 13)].width;
    CGFloat var_width = (332-20-width-20-26*3)/3;
    
    UIImageView *var_img1 = [[UIImageView alloc] init];
    [var_img1 sd_setImageWithURL:[LKFPrivateFunction lgjeropj_imageUrlFromNumber:255]];
    [var_interestView addSubview:var_img1];
    [var_img1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.equalTo(var_interestLabel.mas_right).offset(var_width);
        make.width.mas_equalTo(26);
        make.height.mas_equalTo(21);
    }];
    
    UIImageView *var_img2 = [[UIImageView alloc] init];
    [var_img2 sd_setImageWithURL:[LKFPrivateFunction lgjeropj_imageUrlFromNumber:256]];
    [var_interestView addSubview:var_img2];
    [var_img2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.equalTo(var_img1.mas_right).offset(var_width);
        make.width.mas_equalTo(26);
        make.height.mas_equalTo(21);
    }];
    
    UIImageView *var_img3 = [[UIImageView alloc] init];
    [var_img3 sd_setImageWithURL:[LKFPrivateFunction lgjeropj_imageUrlFromNumber:257]];
    [var_interestView addSubview:var_img3];
    [var_img3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.equalTo(var_img2.mas_right).offset(var_width);
        make.width.mas_equalTo(26);
        make.height.mas_equalTo(21);
    }];
    
    NSString *var_btnName = LocalString(@"Become PREM for Only XXX", nil);
    NSString *var_replace = [[[HTToolKitManager shared] lgjeropj_strip_p2] objectForKey:AsciiString(@"t1")];
    var_btnName = [var_btnName stringByReplacingOccurrencesOfString:AsciiString(@"XXX") withString:var_replace];
    UIButton *var_button = [[UIButton alloc] init];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, kScreenWidth-65, 44);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"#EDC391"].CGColor, (__bridge id)[UIColor colorWithHexString:@"#FDDDB7"].CGColor];
    [var_button.layer addSublayer:gradientLayer];
    var_button.layer.masksToBounds = YES;
    var_button.layer.cornerRadius = 22;
    [var_button setTitle:var_btnName forState:UIControlStateNormal];
    [var_button setTitleColor:[UIColor colorWithHexString:@"#685034"] forState:UIControlStateNormal];
    var_button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [var_button addTarget:self action:@selector(lgjeropj_becomeAction) forControlEvents:UIControlEventTouchUpInside];
    [var_contentView addSubview:var_button];
    [var_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(var_colorView.mas_bottom).offset(69);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(kScreenWidth-65);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *var_skipBtn = [[UIButton alloc] init];
    [var_skipBtn setTitle:LocalString(@"Skip", nil) forState:UIControlStateNormal];
    [var_skipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [var_skipBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [var_skipBtn.titleLabel setAttributedText:[[NSAttributedString alloc] initWithString:LocalString(@"Skip", nil) attributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)}]];
    [var_skipBtn addTarget:self action:@selector(lgjeropj_skipAction) forControlEvents:UIControlEventTouchUpInside];
    [var_contentView addSubview:var_skipBtn];
    [var_skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(var_button.mas_bottom).offset(15);
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)lgjeropj_subscribeAction {
    
    [self lgjeropj_click_maidian:41];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@"1" forKey:AsciiString(@"type")];
    // 1:个人周 2:个人月 3:个人年 4:家庭周 5:家庭月 6:家庭年
    [params setValue:@"2" forKey:AsciiString(@"product")];
    [params setValue:@"0" forKey:AsciiString(@"activityProduct")];
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
    [self ht_backAction];
}

- (void)lgjeropj_installAction {
    
    [self lgjeropj_guide_show_maidian];
    if (!self.var_backgroundView) {
        self.var_backgroundView = [[UIControl alloc] init];
        [self.var_backgroundView addTarget:self action:@selector(lgjeropj_dismissAction) forControlEvents:UIControlEventTouchUpInside];
    }
    UIView *var_super = [[UIApplication sharedApplication] keyWindow];
    [var_super addSubview:self.var_backgroundView];
    [self.var_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    if (!self.var_contentView) {
        self.var_contentView = [[UIView alloc] init];
        self.var_contentView.backgroundColor = [UIColor colorWithHexString:@"#292A2F"];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, kScreenWidth, 375) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(24, 24)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = CGRectMake(0, 0, kScreenWidth, 375);
        maskLayer.path = maskPath.CGPath;
        self.var_contentView.layer.mask = maskLayer;
        [self.var_backgroundView addSubview:self.var_contentView];
        
        NSDictionary *dic = [[HTToolKitManager shared] lgjeropj_strip_p1];
        NSString *var_gif = dic[AsciiString(@"gif")];
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.var_contentView addSubview:imageView];
        [imageView sd_setImageWithURL:[NSURL URLWithString:var_gif]];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(30);
            make.centerX.mas_equalTo(0);
            make.width.mas_equalTo(360);
            make.height.mas_equalTo(260);
        }];
        
        UILabel *var_payment = [[UILabel alloc] init];
        var_payment.text = [LocalString(@"Proceeding to XXX to complete payment", nil) stringByReplacingOccurrencesOfString:AsciiString(@"XXX") withString:dic[AsciiString(@"t1")]];
        var_payment.textColor = [UIColor colorWithHexString:@"#FFD770"];
        var_payment.font = [UIFont boldSystemFontOfSize:14];
        [self.var_contentView addSubview:var_payment];
        [var_payment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.equalTo(imageView.mas_bottom).offset(20);
        }];
    }
    if (!self.var_after) {
        __weak typeof(self) weakSelf = self;
        self.var_after = dispatch_block_create(0, ^{
            if ([weakSelf.var_backgroundView superview]) {
                [weakSelf.var_backgroundView removeFromSuperview];
                weakSelf.var_contentView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 375);
                [weakSelf lgjeropj_subscribeAction];
                [weakSelf ht_backAction];
            }
        });
    }
    self.var_contentView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 375);
    [UIView animateWithDuration:0.2 animations:^{
        self.var_contentView.frame = CGRectMake(0, kScreenHeight-375, kScreenWidth, 375);
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), self.var_after);
    }];
}

- (void)lgjeropj_dismissAction {
    
    if (self.var_after) {
        dispatch_block_cancel(self.var_after);
        self.var_after = nil;
    }
    //埋点
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@2 forKey:AsciiString(@"kid")];
    [params setValue:@8 forKey:AsciiString(@"source")];
    [params setValue:@"tspop_cl" forKey:@"pointname"];
    [HTPremiumPointManager lgjeropj_maidianRequestWithParams:params];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.var_contentView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 334);
    } completion:^(BOOL finished) {
        [self.var_backgroundView removeFromSuperview];
    }];
}

- (void)lgjeropj_becomeAction {
 
    NSInteger var_count = [[NSUserDefaults standardUserDefaults] integerForKey:@"udf_toolkit_guide_count"];
    BOOL var_installed = [[HTToolKitManager shared] lgjeropj_installed];
    if (var_count < 3 && !var_installed) {
        [[NSUserDefaults standardUserDefaults] setInteger:var_count+1 forKey:@"udf_toolkit_guide_count"];
        [self lgjeropj_installAction];
    } else {
        [self lgjeropj_subscribeAction];
    }
}

- (void)lgjeropj_skipAction {
    
    if (self.block) {
        self.block();
    }
    [self lgjeropj_click_maidian:8];
    [self ht_backAction];
}

- (void)ht_backAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)lgjeropj_show_maidian {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@1 forKey:AsciiString(@"type")];
    [params setValue:@14 forKey:AsciiString(@"source")];
    [params setValue:@3 forKey:AsciiString(@"pay_method")];
    [params setValue:@1 forKey:AsciiString(@"status")];
    [params setValue:@"vip_sh" forKey:@"pointname"];
    [HTPremiumPointManager lgjeropj_maidianRequestWithParams:params];
}

- (void)lgjeropj_click_maidian:(NSInteger)kid {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@1 forKey:AsciiString(@"type")];
    [params setValue:@14 forKey:AsciiString(@"source")];
    [params setValue:@3 forKey:AsciiString(@"pay_method")];
    [params setValue:@1 forKey:AsciiString(@"status")];
    [params setValue:@(kid) forKey:AsciiString(@"kid")];
    [params setValue:@"vip_cl" forKey:@"pointname"];
    [HTPremiumPointManager lgjeropj_maidianRequestWithParams:params];
}

- (void)lgjeropj_guide_show_maidian {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@8 forKey:AsciiString(@"source")];
    [params setValue:@"tspop_sh" forKey:@"pointname"];
    [HTPremiumPointManager lgjeropj_maidianRequestWithParams:params];
}

@end
