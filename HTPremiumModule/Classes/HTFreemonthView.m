//
//  HTFreemonthView.m
//  Moshfocus
//
//  Created by 昊天 on 2023/1/4.
//

#import "HTFreemonthView.h"
#import "LRIAPManager.h"
#import "HTPremiumPointManager.h"

@interface HTFreemonthView ()

@property (nonatomic, strong) UIView *var_alertView;
@property (nonatomic, strong) UIView *var_contentView;
@property (nonatomic, strong) UIImageView *var_backImg;
@property (nonatomic, strong) UIImageView *var_vipImg;
@property (nonatomic, strong) UILabel *var_titleLab;
@property (nonatomic, strong) UILabel *var_textLab;
@property (nonatomic, strong) UIButton *var_updateBtn;
@property (nonatomic, strong) UIButton *var_cancelBtn;

@end

@implementation HTFreemonthView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self lgjeropj_configUIWithData];
    }
    return self;
}

- (void)updateConstraints{
    [super updateConstraints];
    
    [self.var_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(kScreenHeight *0.5);
        make.centerX.mas_equalTo(kScreenWidth *0.5);
        make.width.mas_equalTo(isPad ?(kScreenWidth *0.5) :(kScreenWidth *0.8));
        make.height.mas_equalTo(270);
    }];
    
    [self.var_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.var_alertView.mas_top).mas_offset(70);
        make.centerX.mas_equalTo(self.var_alertView).mas_offset(0);
        make.width.mas_equalTo(self.var_alertView.mas_width).mas_offset(0);
        make.height.mas_equalTo(200);
    }];
    
    [self.var_backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.var_alertView).mas_offset(43);
        make.left.mas_equalTo(self.var_alertView).mas_offset(20);
        make.right.mas_equalTo(self.var_alertView).mas_offset(-20);
        make.height.mas_equalTo(100);
    }];
    
    [self.var_vipImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.var_alertView).mas_offset(0);
        make.right.mas_equalTo(self.var_alertView).mas_offset(-10);
        make.width.height.mas_equalTo(86);
    }];
    
    [self.var_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.var_alertView).mas_offset(45);
        make.left.mas_equalTo(self.var_alertView).mas_offset(30);
        make.right.mas_equalTo(self.var_alertView).mas_offset(-100);
    }];
    
    [self.var_textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.var_titleLab.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.var_alertView).mas_offset(30);
        make.right.mas_equalTo(self.var_alertView).mas_offset(-10);
    }];
    
    [self.var_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.var_alertView.mas_bottom).mas_offset(-5);
        make.left.mas_equalTo(self.var_alertView).mas_offset(20);
        make.right.mas_equalTo(self.var_alertView).mas_offset(-20);
        make.height.mas_equalTo(40);
    }];
    
    [self.var_updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.var_cancelBtn.mas_top).mas_offset(-10);
        make.left.mas_equalTo(self.var_alertView).mas_offset(20);
        make.right.mas_equalTo(self.var_alertView).mas_offset(-20);
        make.height.mas_equalTo(44);
    }];
}

- (void)lgjeropj_configUIWithData {
    [self setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
    [self addSubview:self.var_alertView];
    [self.var_alertView addSubview:self.var_contentView];
    [self.var_alertView addSubview:self.var_backImg];
    [self.var_alertView addSubview:self.var_vipImg];
    [self.var_alertView addSubview:self.var_titleLab];
    [self.var_alertView addSubview:self.var_textLab];
    [self.var_alertView addSubview:self.var_cancelBtn];
    [self.var_alertView addSubview:self.var_updateBtn];
}
#pragma mark-
- (void)lgjeropj_updateButtonAction {
    [self lgjeropj_vipguideClickAndkid:@"5"];
    //移除弹窗
    [self lgjeropj_hideAlertView];
    //去订阅
    [LRIAPManager iapInstance].var_isPaying = YES;
    [[LRIAPManager iapInstance] lgjeropj_purchaseWithPID:[NSString stringWithFormat:@"%@_%@", HT_IPA_Mosh, HT_IPA_Month] andBlock:^(BOOL result, NSInteger source, NSString * _Nonnull urlStr) {
        [LRIAPManager iapInstance].var_isPaying = NO;
        if (result == YES) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NTFCTString_IPASuccess" object:nil];
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"udf_showFreeMonth"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[LRIAPManager iapInstance] lgjeropj_getIapProductsListWithRefresh:YES];
            });
        }
    }];
}
- (void)lgjeropj_cancelButtonAction {
    // 埋点
    [self lgjeropj_vipguideClickAndkid:@"2"];
    // 红点
    [HTCommonConfiguration lgjeropj_shared].BLOCK_showRedBlock();
    // 移除
    [self lgjeropj_hideAlertView];
}
- (void)lgjeropj_showAlertView {
    //埋点
    [self lgjeropj_vipguideShow];
    [HTCommonConfiguration lgjeropj_shared].BLOCK_stopAdBlock(YES);
    UIWindow *rootWindow = [[[UIApplication sharedApplication] delegate] window];
    [rootWindow addSubview:self];
}

- (void)lgjeropj_vipguideShow {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"vipguide_sh" forKey:@"pointname"];
    [params setObject:@"28" forKey:@"source"];
    [HTPremiumPointManager lgjeropj_maidianRequestWithParams:params];
}

- (void)lgjeropj_vipguideClickAndkid:(NSString *)kidStr {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"vipguide_cl" forKey:@"pointname"];
    [params setValue:kidStr forKey:AsciiString(@"kid")];
    [params setObject:@"28" forKey:@"source"];
    [HTPremiumPointManager lgjeropj_maidianRequestWithParams:params];
}

- (void)lgjeropj_hideAlertView {
    [HTCommonConfiguration lgjeropj_shared].BLOCK_stopAdBlock(NO);
    [self removeFromSuperview];
}

- (UIView *)var_alertView {
    if (!_var_alertView) {
        _var_alertView = [[UIView alloc] init];
    }
    return _var_alertView;
}

- (UIView *)var_contentView {
    if (!_var_contentView) {
        _var_contentView = [[UIView alloc] init];
        _var_contentView.backgroundColor = [UIColor whiteColor];
        [_var_contentView.layer setCornerRadius:10];
        [_var_contentView setClipsToBounds:YES];
    }
    return _var_contentView;
}

- (UIImageView *)var_backImg {
    if (!_var_backImg) {
        _var_backImg = [[UIImageView alloc] init];
        [_var_backImg sd_setImageWithURL:[LKFPrivateFunction lgjeropj_imageUrlFromNumber:246]];
    }
    return _var_backImg;
}

- (UIImageView *)var_vipImg {
    if (!_var_vipImg) {
        _var_vipImg = [[UIImageView alloc] init];
        [_var_vipImg sd_setImageWithURL:[LKFPrivateFunction lgjeropj_imageUrlFromNumber:247]];
    }
    return _var_vipImg;
}

- (UILabel *)var_titleLab {
    if (!_var_titleLab) {
        _var_titleLab = [[UILabel alloc] init];
        [_var_titleLab setTextColor:[UIColor whiteColor]];
        [_var_titleLab setFont:[UIFont boldSystemFontOfSize:40]];
        [_var_titleLab setText:@"1"];
    }
    return _var_titleLab;
}

- (UILabel *)var_textLab {
    if (!_var_textLab) {
        _var_textLab = [[UILabel alloc] init];
        [_var_textLab setTextColor:[UIColor whiteColor]];
        [_var_textLab setFont:[UIFont systemFontOfSize:12]];
        [_var_textLab setNumberOfLines:0];
        [_var_textLab setText:LocalString(@"Month Free Primium For You", nil)];
    }
    return _var_textLab;
}

- (UIButton *)var_cancelBtn {
    if (!_var_cancelBtn) {
        _var_cancelBtn = [[UIButton alloc] init];
        [_var_cancelBtn setBackgroundColor:[UIColor clearColor]];
        NSString *var_cancelStr = LocalString(@"Give Up Discount", nil);
        NSDictionary *var_attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor],NSUnderlineColorAttributeName,[UIFont systemFontOfSize:14],NSFontAttributeName,[UIColor lightGrayColor],NSForegroundColorAttributeName,@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),NSUnderlineStyleAttributeName,nil];
        NSMutableAttributedString *var_attributedString = [[NSMutableAttributedString alloc] initWithString:var_cancelStr attributes:var_attributeDict];
        [_var_cancelBtn setAttributedTitle:var_attributedString forState:UIControlStateNormal];
        [_var_cancelBtn addTarget:self action:@selector(lgjeropj_cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _var_cancelBtn;
}

- (UIButton *)var_updateBtn {
    if (!_var_updateBtn) {
        _var_updateBtn = [[UIButton alloc] init];
        [_var_updateBtn setTitle:LocalString(@"Receive", nil) forState:UIControlStateNormal];
        [_var_updateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_var_updateBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [_var_updateBtn.layer setCornerRadius:10.0];
        [_var_updateBtn setClipsToBounds:YES];
        [_var_updateBtn sd_setBackgroundImageWithURL:[LKFPrivateFunction lgjeropj_imageUrlFromNumber:206] forState:UIControlStateNormal];
        [_var_updateBtn addTarget:self action:@selector(lgjeropj_updateButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _var_updateBtn;
}


@end
