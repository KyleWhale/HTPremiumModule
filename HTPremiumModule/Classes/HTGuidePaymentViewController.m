//
//  HTGuidePaymentViewController.m
//  Hucolla
//
//  Created by mac on 2022/9/21.
//

#import "HTGuidePaymentViewController.h"
#import "HTGuidePaymentViewManager.h"
#import "HTPayMaiDianManager.h"
#import "HTPremiumPointManager.h"
#import "LRIAPManager.h"

@interface HTGuidePaymentViewController ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIImageView *trailIconView;
@property (nonatomic, strong) UILabel *topTitleLabel;
@property (nonatomic, strong) UILabel *topSubTitleLabel;
@property (nonatomic, strong) UILabel *priceSubLabel;
@property (nonatomic, strong) UIButton *moreProductBtn;
@property (nonatomic, strong) UIButton *buyButton;
@property (nonatomic, strong) NSMutableDictionary *sourceDict;

@end

@implementation HTGuidePaymentViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)lgjeropj_iapProductsChange:(NSNotification *)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.sourceDict removeAllObjects];
        self.sourceDict = nil;
        [self lgjeropj_upDataUI];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kMainColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lgjeropj_iapProductsChange:) name:@"NTFCTString_UpdateVIPStatusAndProductsInfo" object:nil];
    [self lgjeropj_setupUI];
    [self lgjeropj_upDataUI];
    
    //埋点
    [self lgjeropj_maidianVipShow];
}

- (void)lgjeropj_setupUI {
    UIButton *cancelBtn = [HTGuidePaymentViewManager lgjeropj_cancelButton:self action:@selector(ht_onCancelAction)];
    [self.view addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-12);
        make.top.equalTo(self.view).offset(kStatusHeight + 8);
        make.width.height.equalTo(@50);
    }];
    
    self.iconView = [HTGuidePaymentViewManager lgjeropj_iconView];
    [self.view addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cancelBtn.mas_bottom).offset(kScale*10);
        make.left.mas_equalTo(isPad?(kScale*50):(kScale*20));
        make.right.mas_equalTo(isPad?(-kScale*50):(-kScale*20));
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-kScale*310);
    }];
    
    self.topTitleLabel = [HTGuidePaymentViewManager lgjeropj_topLabel];
    [self.view addSubview:self.topTitleLabel];
    [self.topTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-kScale*250);
        make.left.mas_equalTo(kScale*20);
        make.right.mas_equalTo(-kScale*20);
        make.height.mas_equalTo(kScale*60);
    }];
    
    self.topSubTitleLabel = [HTGuidePaymentViewManager lgjeropj_centerLabel];
    [self.view addSubview:self.topSubTitleLabel];
    [self.topSubTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-kScale*200);
        make.left.mas_equalTo(kScale*20);
        make.right.mas_equalTo(-kScale*20);
        make.height.mas_equalTo(kScale*50);
    }];
    
    self.buyButton = [HTGuidePaymentViewManager lgjeropj_buyButton:self action:@selector(ht_onPaymentAction)];
    [self.view addSubview:self.buyButton];
    [self.buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-kScale*120);
        make.width.mas_equalTo(kScale*300);
        make.height.mas_equalTo(kScale*60);
        make.centerX.mas_equalTo(self.view);
    }];
    
    self.trailIconView = [HTGuidePaymentViewManager lgjeropj_trialView];
    [self.buyButton addSubview:self.trailIconView];
    [self.trailIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.buyButton);
        make.left.mas_equalTo(self.buyButton);
        make.width.mas_equalTo(kScale*64);
        make.height.mas_equalTo(kScale*46);
    }];
    
    self.priceSubLabel = [HTGuidePaymentViewManager lgjeropj_priceLabel];
    [self.view addSubview:self.priceSubLabel];
    [self.priceSubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.buyButton.mas_bottom).offset(0);
        make.left.mas_equalTo(kScale*20);
        make.right.mas_equalTo(-kScale*20);
        make.height.mas_equalTo(kScale*40);
    }];
    
    self.moreProductBtn = [HTGuidePaymentViewManager lgjeropj_chooseMoreButton:self action:@selector(ht_onPlanAction)];
    [self.view addSubview:self.moreProductBtn];
    [self.moreProductBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.priceSubLabel.mas_bottom).offset(kScale*20);
        make.left.mas_equalTo(kScale*20);
        make.right.mas_equalTo(-kScale*20);
        make.height.mas_equalTo(kScale*20);
    }];
}

- (void)lgjeropj_updateInterest {
    
    if (self.topTitleLabel.text.length > 0) {
        return;
    }
    NSArray *array = [[NSUserDefaults standardUserDefaults] arrayForKey:@"udf_guideVipArray"];
    if (array.count == 0) {
        return;
    }
    
}

- (void)lgjeropj_upDataUI {
    NSArray *array = [[NSUserDefaults standardUserDefaults] arrayForKey:@"udf_guideVipArray"];
    if (array.count > 0 && self.topTitleLabel.text.length <= 0) {
        NSInteger showCount = 1;
        NSDictionary *dict = [HTCommonConfiguration lgjeropj_shared].BLOCK_airDictBlock();
        if (dict == nil) {
            dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"udf_airplay"];
        }
        if (dict.count > 0) {
            showCount = 2;
        }
        int value = 0;
        if (showCount > 1) {
            value = arc4random() % showCount;
            if (value == 1) {
                value = 3;
            }
        }
        NSString *imageUrl = array[value];
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
        if (value == 0) {//去广告
            self.topTitleLabel.text = LocalString(@"NO ADS", nil);
            self.topSubTitleLabel.text = LocalString(@"Remove all full-screen ads, banner ads and MREC ads.", nil);
        } else if (value == 3) {//投屏
            self.topTitleLabel.text = LocalString(@"Cast to TV", nil);
            self.topSubTitleLabel.text = LocalString(@"Support Chromecast, Roku TV, Samsung TV and other DLNA streaming device.", nil);
        }
        if (self.topSubTitleLabel.text.length <= 0) {
            [self.buyButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.topTitleLabel.mas_bottom).offset(kScale*70);
            }];
        }
    }
    
    NSString *priceStr = @"";
    NSString *trialPriceStr = @"";
    NSInteger dayCount = [self.sourceDict[AsciiString(@"count")] integerValue];
    NSString *unitStr = @"";
    if (dayCount == 7) {
        unitStr = LocalString(@"Week", nil);
    } else if (dayCount == 30) {
        unitStr = LocalString(@"Month", nil);
    } else if (dayCount >= 360) {
        unitStr = LocalString(@"Year", nil);
    }
    BOOL trial = [self.sourceDict[AsciiString(@"trial")] boolValue];
    if (trial && ![[NSUserDefaults standardUserDefaults] boolForKey:@"udf_isIAPDiscount"]) {
        [self.trailIconView sd_setImageWithURL:[LKFPrivateFunction lgjeropj_imageUrlFromNumber:55]];
        self.priceSubLabel.text = [NSString stringWithFormat:LocalString(@"Then %@%@/%@ after trial ends, you can cancel anytime", nil), self.sourceDict[AsciiString(@"unit")], self.sourceDict[AsciiString(@"price")], unitStr];
        if ([self.sourceDict[AsciiString(@"tp")] floatValue] > 0.0) {
            trialPriceStr = [NSString stringWithFormat:@"%@%@", self.sourceDict[AsciiString(@"unit")], self.sourceDict[AsciiString(@"tp")]];
        } else {
            trialPriceStr = LocalString(@"Free", nil);
        }
        priceStr = [NSString stringWithFormat:LocalString(@"%@ FOR %@ TRIAL", nil), trialPriceStr, self.sourceDict[AsciiString(@"td")]];
    } else {
        [self.trailIconView sd_setImageWithURL:[LKFPrivateFunction lgjeropj_imageUrlFromNumber:54]];
        self.priceSubLabel.text = LocalString(@"you can cancel anytime", nil);
        trialPriceStr = [NSString stringWithFormat:@"%@%@", self.sourceDict[AsciiString(@"unit")], self.sourceDict[AsciiString(@"price")]];
        priceStr = [NSString stringWithFormat:@"%@ /%@", trialPriceStr, unitStr];
    }
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:priceStr];
    if (priceStr.length > 0 && trialPriceStr.length > 0 && priceStr.length > trialPriceStr.length) {
        [attStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:kScale*22] range:NSMakeRange(0, [trialPriceStr length])];
    }
    [self.buyButton setAttributedTitle:attStr forState:UIControlStateNormal];
}


- (void)ht_onCancelAction {
    //埋点
    [self lgjeropj_maidianVipClick:@"8"];
    [self ht_onCancelGuideView];
}

- (void)ht_onCancelGuideView {
    @weakify(self);
    [self dismissViewControllerAnimated:YES completion:^{
        @strongify(self);
        if (self.guideBlock) {
            self.guideBlock();
        }
    }];
}

- (void)ht_onPaymentAction {
    [LRIAPManager iapInstance].var_isPaying = YES;
    [[LRIAPManager iapInstance] lgjeropj_purchaseWithPID:self.sourceDict[@"id"] andBlock:^(BOOL result, NSInteger source, NSString * _Nonnull urlStr) {
        [LRIAPManager iapInstance].var_isPaying = NO;
        if (result == YES) {
            [self ht_onCancelGuideView];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NTFCTString_IPASuccess" object:nil];
        }
    }];
    
    //埋点
    NSString *var_id = self.sourceDict[AsciiString(@"id")];
    NSInteger dayCount = [self.sourceDict[AsciiString(@"count")] integerValue];
    BOOL trial = [self.sourceDict[AsciiString(@"trial")] boolValue];
    if ([var_id isEqualToString:[NSString stringWithFormat:@"%@_%@", HT_IPA_Mosh, HT_IPA_Month]]) {
        [self lgjeropj_maidianVipClick:@"34"];
    } else if (trial) {
        [self lgjeropj_maidianVipClick:@"9"];
    } else if (dayCount == 7) {
        [self lgjeropj_maidianVipClick:@"7"];
    } else if (dayCount == 30) {
        [self lgjeropj_maidianVipClick:@"2"];
    } else if (dayCount >= 360) {
        [self lgjeropj_maidianVipClick:@"3"];
    }
}

- (void)ht_onPlanAction {
    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.planBlock) {
        self.planBlock();
    }
    
    //埋点
    [self lgjeropj_maidianVipClick:@"16"];
}

- (NSMutableDictionary *)sourceDict {
    if (!_sourceDict) {
        _sourceDict = [NSMutableDictionary dictionary];
        NSMutableArray *array = [LRIAPManagerTwo lgjeropj_makeIapSingleData];
        NSDictionary *itemM = nil;
        NSDictionary *itemD = nil;
        for (NSDictionary *dict in array) {
            if ([dict[AsciiString(@"type")] integerValue] == 1) {
                itemD = dict;
            }
            if ([dict[AsciiString(@"count")] integerValue] == 30) {
                itemM = dict;
            }
        }
        if (itemD.count > 0) {
            [_sourceDict addEntriesFromDictionary:itemD];
        } else if (itemM.count > 0) {
            [_sourceDict addEntriesFromDictionary:itemM];
        }
    }
    return _sourceDict;
}

- (void)lgjeropj_maidianVipShow{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(self.source) forKey:@"source"];
    [params setObject:@"2" forKey:AsciiString(@"type")];
    [params setValue:@"vip_sh" forKey:@"pointname"];
    [HTPremiumPointManager lgjeropj_maidianRequestWithParams:params];
}

- (void)lgjeropj_maidianVipClick:(NSString *)kidStr{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:kidStr forKey:AsciiString(@"kid")];
    [params setObject:@"2" forKey:AsciiString(@"type")];
    [params setObject:@(self.source) forKey:@"source"];
    [params setObject:@"vip_cl" forKey:@"pointname"];
    [HTPremiumPointManager lgjeropj_maidianRequestWithParams:params];
}

@end
