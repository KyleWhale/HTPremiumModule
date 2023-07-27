//
//  HTPremiumViewController.m
//  Hucolla
//
//  Created by mac on 2022/4/14.
//

#import "HTPremiumViewController.h"
#import "HTDBVipModel.h"
#import "HTPayMaiDianManager.h"
#import "HTPremiumViewManager.h"
#import "HTToolSubscribeAlertView.h"
#import "HTRemindAddFamilyMemberView.h"
#import "HTUnSubscribeRemindView.h"
#import "HTPremiumPointManager.h"
#import "SVProgressHUD.h"
#import "LRIAPManager.h"
#import "HTToolKitManager.h"

@interface HTPremiumViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView       * collectionView;
@property (nonatomic, strong) NSMutableArray         * cardArray;
@property (nonatomic, strong) NSMutableArray         * familyArray;
@property (nonatomic, strong) NSArray                * var_infoArray;
@property (nonatomic, assign) BOOL                     var_family;
@property (nonatomic, assign) NSInteger                var_index;

@end

@implementation HTPremiumViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#11101E"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lgjeropj_iapProductsChange:) name:@"NTFCTString_UpdateVIPStatusAndProductsInfo" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ht_remind_add_member) name:@"NTFCTString_RemindAddFamilyMember" object:nil];

    if (self.navigationController.viewControllers.count > 1) {
        [self ht_addDefaultLeftItem];
    }
    
    self.navigationItem.titleView = [HTPremiumViewManager lgjeropj_removeLabel];
    [self lgjeropj_addSubViews];
    [self lgjeropj_bindViewModel];
    [self ht_showRemindIcon];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self ht_resetCardArray];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController ht_barTintColor:[UIColor colorWithHexString:@"#1A1C21"] andIsTranslucent:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [HTPremiumViewManager lgjeropj_maidianVipShow:self.source];
}

- (void)lgjeropj_iapProductsChange:(NSNotification *)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self ht_resetCardArray];
        [self ht_showRemindIcon];
    });
}

- (void)lgjeropj_addSubViews {
    self.collectionView = [HTPremiumViewManager lgjeropj_collectionView:self];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (BOOL)ht_doublePremium {
    
    BOOL var_localVip = [[NSUserDefaults standardUserDefaults] boolForKey:@"udf_isLocalIapVip"];
    BOOL var_deviceVip = [[NSUserDefaults standardUserDefaults] boolForKey:@"udf_isDeviceVip"];
    BOOL var_toolVip = NO;
    ZQAccountModel *model = [HTCommonConfiguration lgjeropj_shared].BLOCK_userBlock();
    if ([model.var_toolVip integerValue] > 0) {
        var_toolVip = YES;
    }
    return var_localVip && !var_deviceVip && var_toolVip;
}

- (void)ht_showRemindIcon {
    
    BOOL var_show = [[NSUserDefaults standardUserDefaults] boolForKey:@"udf_remind_unsubscribe_icon"];
    if (!var_show) {
        return;
    }
    if ([self ht_doublePremium]) {
        // 既是本地vip 又是工具包vip 且不是绑定在设备上
        UIButton *rightView = [[UIButton alloc] init];
        rightView.frame = CGRectMake(0, 0, 44, 44);
        @weakify(self);
        [[rightView rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"udf_remind_unsubscribe_red"];
            HTUnSubscribeRemindView *view = [[HTUnSubscribeRemindView alloc] init];
            [view lgjeropj_show];
            [self ht_showRemindIcon];
            // 埋点
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            [params setValue:@(44) forKey:AsciiString(@"source")];
            [params setValue:@(46) forKey:@"kid"];
            [params setValue:@"vip_cl" forKey:@"pointname"];
            [HTPremiumPointManager lgjeropj_maidianRequestWithParams:params];
        }];
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView sd_setImageWithURL:[LKFPrivateFunction lgjeropj_imageUrlFromNumber:248]];
        [rightView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(29, 24));
        }];
        BOOL var_show_red = [[NSUserDefaults standardUserDefaults] boolForKey:@"udf_remind_unsubscribe_red"];
        if (!var_show_red) {
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor redColor];
            view.layer.cornerRadius = 3;
            view.layer.masksToBounds = YES;
            [rightView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.right.equalTo(imageView);
                make.size.mas_equalTo(6);
            }];
        }
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    }
}

- (void)ht_showUnsubscribeAlertView {
    
    BOOL var_reminded = [[NSUserDefaults standardUserDefaults] boolForKey:@"udf_remind_unsubscribe"];
    if (var_reminded) {
        // 弹过就不弹了
        return;
    }
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"udf_remind_unsubscribe"];
    if ([self ht_doublePremium]) {
        // 既是本地vip 又是工具包vip 且不是绑定在设备上
        HTUnSubscribeRemindView *view = [[HTUnSubscribeRemindView alloc] init];
        view.block = ^() {
            // skip 显示右上角icon
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"udf_remind_unsubscribe_icon"];
            [self ht_showRemindIcon];
        };
        [view lgjeropj_show];
    }
}

- (void)ht_remind_add_member {
    
    BOOL var_remind = [[NSUserDefaults standardUserDefaults] boolForKey:@"udf_remind_add_member"];
    if (var_remind) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"udf_remind_add_member"];
    HTRemindAddFamilyMemberView *view = [[HTRemindAddFamilyMemberView alloc] init];
    __weak typeof(self) weakSelf = self;
    view.block = ^() {
        // 添加家庭成员
        UIViewController *vc = [[NSClassFromString(@"HTFamilyViewController") alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    [view lgjeropj_show];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSDictionary *var_dataDict = [HTCommonConfiguration lgjeropj_shared].BLOCK_gdBlock();
    if ([[var_dataDict objectForKey:@"status"] integerValue] != 0) {
        return 2;
    }
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 2) {
        return self.var_infoArray.count;
    }
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        HTPremiumHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HTPremiumHeaderCell class]) forIndexPath:indexPath];
        cell.var_redView.hidden = YES;
        cell.var_lineView.hidden = YES;
        cell.var_hintLabel.hidden = YES;
        cell.var_managerBtn.hidden = YES;
        __weak typeof(self) weakSelf = self;
        [[[cell.var_managerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
            // 家庭
            UIViewController *vc = [[NSClassFromString(@"HTFamilyViewController") alloc] init];            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"udf_remind_add_family_member_red"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [weakSelf.collectionView reloadData];
        }];
        HTDBVipModel *model = [[HTDBVipModel alloc] init];
        if ([model ht_isVip]) {
            [cell.var_imageView sd_setImageWithURL:[LKFPrivateFunction lgjeropj_imageUrlFromNumber:251]];
            ZQAccountModel *accountResult = [HTCommonConfiguration lgjeropj_shared].BLOCK_userBlock();
            if ([accountResult.var_familyPlanState isEqualToString:@"1"]) {
                NSString *planDescStr = @"";
                NSString *var_cancel = @"";
                cell.var_redView.hidden = [[NSUserDefaults standardUserDefaults] boolForKey:@"udf_remind_add_family_member_red"];
                cell.var_lineView.hidden = NO;
                cell.var_hintLabel.hidden = NO;
                cell.var_managerBtn.hidden = NO;
                BOOL var_master = [accountResult.var_identity integerValue] == 1;
                [cell.var_managerBtn setTitle:var_master ? AsciiString(@"Manage") : AsciiString(@"View") forState:UIControlStateNormal];
                [cell.var_managerBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(var_master ? 79 : 59);
                }];
                // 家庭计划
                if ([accountResult.var_pid containsString:AsciiString(@"week")]) {
                    planDescStr = LocalString(@"Weekly", nil);
                } else if ([accountResult.var_pid containsString:AsciiString(@"month")]) {
                    planDescStr = LocalString(@"Monthly", nil);
                } else if ([accountResult.var_pid containsString:AsciiString(@"year")]) {
                    planDescStr = LocalString(@"Annually", nil);
                }
                if (![accountResult.var_renewStatus isEqualToString:@"1"]) {
                    if ([accountResult.var_vipEndTime longLongValue] > 0) {
                        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[accountResult.var_vipEndTime longLongValue]];
                        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                        [formatter setDateFormat:AsciiString(@"MMM d, yyyy")];
                        NSString *dateString = [formatter stringFromDate:date];
                        var_cancel = [NSString stringWithFormat:@"%@ %@", LocalString(@"Cancels on", nil), dateString];
                        planDescStr = [NSString stringWithFormat:@"%@\n%@", planDescStr, var_cancel];
                    }
                }
                if (var_cancel.length > 0) {
                    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:planDescStr];
                    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14 weight:UIFontWeightSemibold] range:NSMakeRange(0, planDescStr.length)];
                    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10 weight:UIFontWeightRegular] range:[planDescStr rangeOfString:var_cancel]];
                    cell.var_planLabel.attributedText = att;
                } else {
                    cell.var_planLabel.attributedText = [[NSAttributedString alloc] initWithString:planDescStr attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:18]}];
                }
            } else if ([accountResult.var_bindPlanState isEqualToString:@"1"]) {
                // 个人计划
                NSString *planDescStr = @"";
                NSString *var_cancel = @"";
                if ([accountResult.var_bindPid containsString:AsciiString(@"week")]) {
                    planDescStr = LocalString(@"Weekly", nil);
                } else if ([accountResult.var_bindPid containsString:AsciiString(@"month")]) {
                    planDescStr = LocalString(@"Monthly", nil);
                } else if ([accountResult.var_bindPid containsString:AsciiString(@"year")]) {
                    planDescStr = LocalString(@"Annually", nil);
                }
                if (![accountResult.var_bindRenewStatus isEqualToString:@"1"]) {
                    if ([accountResult.var_bindEndTime longLongValue] > 0) {
                        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[accountResult.var_bindEndTime longLongValue]];
                        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                        [formatter setDateFormat:AsciiString(@"MMM d, yyyy")];
                        NSString *dateString = [formatter stringFromDate:date];
                        var_cancel = [NSString stringWithFormat:@"%@ %@", LocalString(@"Cancels on", nil), dateString];
                        planDescStr = [NSString stringWithFormat:@"%@\n%@", planDescStr, var_cancel];
                    }
                }
                if (var_cancel.length > 0) {
                    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:planDescStr];
                    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14 weight:UIFontWeightSemibold] range:NSMakeRange(0, planDescStr.length)];
                    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10 weight:UIFontWeightRegular] range:[planDescStr rangeOfString:var_cancel]];
                    cell.var_planLabel.attributedText = att;
                } else {
                    cell.var_planLabel.attributedText = [[NSAttributedString alloc] initWithString:planDescStr attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:18]}];
                }
            } else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"udf_isDeviceVip"]) {
                NSString *planDescStr = @"";
                NSString *var_pid = [[NSUserDefaults standardUserDefaults] objectForKey:@"udf_devicePid"];
                if ([var_pid containsString:AsciiString(@"week")]) {
                    planDescStr = LocalString(@"Weekly", nil);
                } else if ([var_pid containsString:AsciiString(@"month")]) {
                    planDescStr = LocalString(@"Monthly", nil);
                } else if ([var_pid containsString:AsciiString(@"year")]) {
                    planDescStr = LocalString(@"Annually", nil);
                }
                cell.var_planLabel.attributedText = [[NSAttributedString alloc] initWithString:planDescStr attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:18]}];
            } else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"udf_isLocalIapVip"]) {
                NSString *planDescStr = @"";
                NSString *var_cancel = @"";
                NSString *idStr = model.var_vipId;
                if ([idStr containsString:AsciiString(@"month")]) {
                    planDescStr = AsciiString(@"Monthly");
                } else if ([idStr containsString:AsciiString(@"year")]) {
                    planDescStr = LocalString(@"Annually", nil);
                } else if ([idStr containsString:AsciiString(@"week")]) {
                    planDescStr = LocalString(@"Weekly", nil);
                }
                if ([[NSUserDefaults standardUserDefaults] boolForKey:@"udf_iap_sub"]) {
                    NSString *var_vipEndTime = [[NSUserDefaults standardUserDefaults] stringForKey:@"udf_iap_expireTime"];
                    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[var_vipEndTime longLongValue]];
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:AsciiString(@"MMM d, yyyy")];
                    NSString *dateString = [formatter stringFromDate:date];
                    var_cancel = [NSString stringWithFormat:@"%@ %@", LocalString(@"Cancels on", nil), dateString];
                    planDescStr = [NSString stringWithFormat:@"%@\n%@", planDescStr, var_cancel];
                }
                if (var_cancel.length > 0) {
                    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:planDescStr];
                    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14 weight:UIFontWeightSemibold] range:NSMakeRange(0, planDescStr.length)];
                    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10 weight:UIFontWeightRegular] range:[planDescStr rangeOfString:var_cancel]];
                    cell.var_planLabel.attributedText = att;
                } else {
                    cell.var_planLabel.attributedText = [[NSAttributedString alloc] initWithString:planDescStr attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:18]}];
                }
            }
            
        } else {
            cell.var_planLabel.attributedText = [[NSAttributedString alloc] initWithString:AsciiString(@"Free") attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:18]}];
            [cell.var_imageView sd_setImageWithURL:[LKFPrivateFunction lgjeropj_imageUrlFromNumber:250]];
        }
        return cell;
    }
    NSDictionary *var_dataDict = [HTCommonConfiguration lgjeropj_shared].BLOCK_gdBlock();
    if ([[var_dataDict objectForKey:@"status"] integerValue] != 0) {
        HTPremiumEmptyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HTPremiumEmptyCell class]) forIndexPath:indexPath];
        cell.emptyBlock = ^{
            // 导量 下架后无产品时显示
            [HTPremiumViewManager lgjeropj_guideAction];
        };
        return cell;
    } else if (indexPath.section == 1) {
        HTPremiumNewCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HTPremiumNewCardCell class]) forIndexPath:indexPath];
        [cell lgjeropj_updateCellWithData:self.cardArray andFamilyData:self.familyArray];
        __weak typeof(self) weakSelf = self;
        cell.typeBlock = ^(NSInteger type) {
            weakSelf.var_family = type == 1;
            [weakSelf.collectionView reloadData];
        };
        cell.indexBlock = ^(NSInteger index) {
            weakSelf.var_index = index;
        };
        cell.payBlock = ^(NSDictionary * _Nonnull dic) {
            if ([[dic objectForKey:@"var_fake"] boolValue]) {
                [weakSelf ht_fakeCardPay:dic];
            } else {
                [weakSelf ht_buyVip:dic];
            }
        };
        cell.restoreBlock = ^{
            [weakSelf ht_restore];
            [[HTPayMaiDianManager shareInstance] lgjeropj_maidian:2];
        };
        return cell;
    }
    NSMutableAttributedString *att = self.var_infoArray[indexPath.row];
    HTPremiumViewInfoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HTPremiumViewInfoCell class]) forIndexPath:indexPath];
    [cell ht_updateCellWithData:att];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        HTDBVipModel *model = [[HTDBVipModel alloc] init];
        ZQAccountModel *accountResult = [HTCommonConfiguration lgjeropj_shared].BLOCK_userBlock();
        if ([model ht_isVip]) {
            if ([accountResult.var_userid integerValue] > 0) {
                if ([accountResult.var_familyPlanState isEqualToString:@"1"]) {
                    return CGSizeMake(kScreenWidth, 92+44);
                }
            }
        }
        return CGSizeMake(kScreenWidth, 92);
    }
    NSDictionary *var_dataDict = [HTCommonConfiguration lgjeropj_shared].BLOCK_gdBlock();
    if ([[var_dataDict objectForKey:@"status"] integerValue] != 0) {
        return CGSizeMake(kScreenWidth, 300);
    } else if (indexPath.section == 1) {
        if (self.var_family) {
            return CGSizeMake(kScreenWidth, 16+48+8+3*38+14+136+58+44+24+18);
        }
        return CGSizeMake(kScreenWidth, 16+48+8+2*38+14+136+58+44+24+18);
    }
    NSMutableAttributedString *att = self.var_infoArray[indexPath.row];
    HTPremiumViewInfoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HTPremiumViewInfoCell class]) forIndexPath:indexPath];
    [cell ht_updateCellWithData:att];
    CGFloat rowH = 100;
    if (cell) {
        rowH = [cell ht_cellHeight];
    }
    return CGSizeMake(kScreenWidth, rowH);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 2) {
        return UIEdgeInsetsMake(20, 0, 20, 0);
    }
    return UIEdgeInsetsZero;
}

- (void)ht_restore {
    
    [HTPremiumViewManager lgjeropj_maidianVipClick:@"5" source:self.source];
    [SVProgressHUD showWithStatus:LocalString(@"Restoring...", nil)];
    [LRIAPManager iapInstance].var_isPaying = YES;
    [[LRIAPManager iapInstance] lgjeropj_restorePurchaseStatusWithBlock:^(BOOL result, NSInteger source) {
        [LRIAPManager iapInstance].var_isPaying = NO;
        [SVProgressHUD dismiss];
    }];
}

- (void)ht_fakeCardPay:(NSDictionary *)data {
    
    NSInteger count = [[data objectForKey:AsciiString(@"c1")] integerValue];
    HTToolSubscribeAlertView *view = [[HTToolSubscribeAlertView alloc] init];
    if (count < 30) {
        [view lgjeropj_show:data source:self.var_family ? 4 : 3];
    } else if (count == 30) {
        [view lgjeropj_show:data source:self.var_family ? 5 : 1];
    } else {
        [view lgjeropj_show:data source:self.var_family ? 6 : 2];
    }
}

- (void)ht_buyVip:(id)data {
    
    NSString *var_id = data[AsciiString(@"id")];
    // 家庭计划 强制登录
    ZQAccountModel *var_model = [HTCommonConfiguration lgjeropj_shared].BLOCK_userBlock();
    if ([var_id containsString:AsciiString(@"family")] && var_model.var_userid.integerValue == 0) {
        [HTCommonConfiguration lgjeropj_shared].BLOCK_toLoginBlock();
        return;
    }
    BOOL trial = [data[AsciiString(@"first")] length] > 0;
    if ([var_id isEqualToString:[NSString stringWithFormat:@"%@_%@", HT_IPA_Mosh, HT_IPA_Month]]) {
        [HTPremiumViewManager lgjeropj_maidianVipClick:@"34" source:self.source];
    } else if (trial) {
        [HTPremiumViewManager lgjeropj_maidianVipClick:@"9" source:self.source];
    } else if ([var_id containsString:HT_IPA_Week] || [var_id containsString:[NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Week]]) {
        [HTPremiumViewManager lgjeropj_maidianVipClick:@"7" source:self.source];
    } else if ([var_id containsString:HT_IPA_Month] || [var_id containsString:[NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Month]]) {
        [HTPremiumViewManager lgjeropj_maidianVipClick:@"2" source:self.source];
    } else if ([var_id containsString:HT_IPA_Year] || [var_id containsString:[NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Year]]) {
        [HTPremiumViewManager lgjeropj_maidianVipClick:@"3" source:self.source];
    }
    // 本地订阅
    [LRIAPManager iapInstance].var_isPaying = YES;
    [[LRIAPManager iapInstance] lgjeropj_purchaseWithPID:data[AsciiString(@"id")] andBlock:^(BOOL result, NSInteger source, NSString * _Nonnull urlStr) {
        [LRIAPManager iapInstance].var_isPaying = NO;
        if (result == YES) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NTFCTString_IPASuccess" object:nil];
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"udf_showFreeMonth"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[LRIAPManager iapInstance] lgjeropj_getIapProductsListWithRefresh:YES];
            });
        }
    }];
}

- (void)lgjeropj_bindViewModel {
    
}

- (void)ht_resetCardArray {
    
    NSMutableArray *array = [LRIAPManagerTwo lgjeropj_makeIapSingleData];
    if (array.count) {
        NSMutableArray *tempArr = [[NSMutableArray alloc] init];
        NSString *weekPriceStr = [NSString stringWithFormat:@"%d.%d", 1, 99];
        NSString *familyWeekPriceStr = [NSString stringWithFormat:@"%d.%d", 2, 99];
        for (NSDictionary *dict in array) {
            if ([dict[AsciiString(@"id")] isEqualToString:HT_IPA_Week]) {
                weekPriceStr = dict[AsciiString(@"price")];
            } else if ([dict[AsciiString(@"id")] isEqualToString:[NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Week]]) {
                familyWeekPriceStr = dict[AsciiString(@"price")];
            }
        }
        
        for (NSDictionary *dict in array) {
            NSMutableDictionary *tempDict = [NSMutableDictionary dictionaryWithCapacity:4];
            NSString *var_id = dict[AsciiString(@"id")];
            [tempDict setObject:dict[AsciiString(@"id")] forKey:AsciiString(@"id")];
            [tempDict setObject:dict[AsciiString(@"price")] forKey:AsciiString(@"price")];
            if ([dict[AsciiString(@"id")] isEqualToString:HT_IPA_Week]) {
                [tempDict setObject:@"" forKey:AsciiString(@"discount")];
                [tempDict setObject:@"" forKey:AsciiString(@"first")];
            } else {
                NSInteger count = [dict[AsciiString(@"count")] intValue];
                NSString *discountStr = @"";
                if ([var_id containsString:AsciiString(@"family")]) {
                    discountStr = [NSString stringWithFormat:@"%.1f",familyWeekPriceStr.floatValue/7*count];
                } else {
                    discountStr = [NSString stringWithFormat:@"%.1f",weekPriceStr.floatValue/7*count];
                }
                [tempDict setObject:discountStr forKey:AsciiString(@"discount")];
                NSString *var_receiptString = [[NSData dataWithContentsOfURL:[[NSBundle mainBundle] appStoreReceiptURL]] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
                if (var_receiptString) {// IAP订单存在
                    [tempDict setObject:@"" forKey:AsciiString(@"first")];
                } else {
                    BOOL var_isTrial = [dict[AsciiString(@"trial")] boolValue];
                    [tempDict setObject:(var_isTrial ?dict[AsciiString(@"tp")] :@"") forKey:AsciiString(@"first")];
                }
            }
            [tempArr addObject:tempDict];
        }
        self.cardArray = [tempArr filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NSDictionary * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            NSString *var_id = [evaluatedObject objectForKey:AsciiString(@"id")];
            return ![var_id containsString:AsciiString(@"family")];
        }]].mutableCopy;
        self.familyArray = [tempArr filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NSDictionary * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            NSString *var_id = [evaluatedObject objectForKey:AsciiString(@"id")];
            return [var_id containsString:AsciiString(@"family")];
        }]].mutableCopy;
    } else {
        self.cardArray = @[@{AsciiString(@"id"):HT_IPA_Month,
                             AsciiString(@"price"):[NSString stringWithFormat:@"%d.%d", 4, 99],
                             AsciiString(@"discount"):AsciiString(@"8.5"),
                             AsciiString(@"first"):[NSString stringWithFormat:@"%d.%d", 2, 99]},
                           @{AsciiString(@"id"):HT_IPA_Year,
                             AsciiString(@"price"):[NSString stringWithFormat:@"%d.%d", 29, 99],
                             AsciiString(@"discount"):AsciiString(@"103"),
                             AsciiString(@"first"):@""},
                           @{AsciiString(@"id"):HT_IPA_Week,
                             AsciiString(@"price"):[NSString stringWithFormat:@"%d.%d", 1, 99],
                             AsciiString(@"discount"):@"",
                             AsciiString(@"first"):@""}].mutableCopy;
        self.familyArray = @[@{AsciiString(@"id"):[NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Month],
                               AsciiString(@"price"):[NSString stringWithFormat:@"%d.%d", 7, 99],
                               AsciiString(@"discount"):@"",
                               AsciiString(@"first"):@""},
                             @{AsciiString(@"id"):[NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Year],
                               AsciiString(@"price"):[NSString stringWithFormat:@"%d.%d", 49, 99],
                               AsciiString(@"discount"):@"",
                               AsciiString(@"first"):@""},
                             @{AsciiString(@"id"):[NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Week],
                               AsciiString(@"price"):[NSString stringWithFormat:@"%d.%d", 2, 99],
                               AsciiString(@"discount"):@"",
                               AsciiString(@"first"):@""}].mutableCopy;
    }
    [self ht_setupFakeCardData];
    [self.collectionView reloadData];
}

// 假卡片数据拼接
- (NSDictionary *)ht_translateModel:(NSDictionary *)dic {
    
    NSMutableDictionary *var_fake = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSString *var_id = [dic objectForKey:AsciiString(@"product")];
    // id price discount first
    [var_fake setValue:var_id forKey:AsciiString(@"id")];
    NSString *var_h2 = [NSString stringWithFormat:@"%@", [dic objectForKey:AsciiString(@"h2")]];
    [var_fake setValue:var_h2 forKey:AsciiString(@"price")];
    [var_fake setValue:@"" forKey:AsciiString(@"discount")];
    [var_fake setValue:@"" forKey:AsciiString(@"first")];
    [var_fake setValue:@(YES) forKey:@"var_fake"];
    return var_fake;
}

- (void)ht_setupFakeCardData {

    BOOL var_isLocalVip = [[NSUserDefaults standardUserDefaults] boolForKey:@"udf_isLocalIapVip"];
    BOOL var_isToolVip = NO;
    ZQAccountModel *model = [HTCommonConfiguration lgjeropj_shared].BLOCK_userBlock();
    if ([model.var_toolVip integerValue] > 0) {
        var_isToolVip = YES;
    }
    // 非本地订阅用户 或 是工具包订阅用户
    if (!var_isLocalVip || var_isToolVip) {
        if ([[HTToolKitManager shared] lgjeropj_strip_k12] > 0) {
            // 假卡片数据
            NSDictionary *var_server = [[HTToolKitManager shared] lgjeropj_server_products];
            if (var_server.count > 0) {
                // 家庭计划
                NSMutableDictionary *var_fm = [NSMutableDictionary dictionaryWithDictionary:[var_server objectForKey:AsciiString(@"fm")]];
                [var_fm setValue:AsciiString(@"fm") forKey:AsciiString(@"product")];
                // 假月 真月 真年 真周
                [self.familyArray insertObject:[self ht_translateModel:var_fm] atIndex:0];
                NSMutableDictionary *var_fy = [NSMutableDictionary dictionaryWithDictionary:[var_server objectForKey:AsciiString(@"fy")]];
                [var_fy setValue:AsciiString(@"fy") forKey:AsciiString(@"product")];
                // 假月 真月 假年 真年 真周
                [self.familyArray insertObject:[self ht_translateModel:var_fy] atIndex:2];
                NSMutableDictionary *var_fw = [NSMutableDictionary dictionaryWithDictionary:[var_server objectForKey:AsciiString(@"fw")]];
                [var_fw setValue:AsciiString(@"fw") forKey:AsciiString(@"product")];
                // 假月 真月 假年 真年 假周 真周
                [self.familyArray insertObject:[self ht_translateModel:var_fw] atIndex:4];
                // 个人计划
                NSMutableDictionary *var_month = [NSMutableDictionary dictionaryWithDictionary:[var_server objectForKey:AsciiString(@"month")]];
                [var_month setValue:AsciiString(@"month") forKey:AsciiString(@"product")];
                // 假月 真月 真年 真周
                [self.cardArray insertObject:[self ht_translateModel:var_month] atIndex:0];
                NSMutableDictionary *var_year = [NSMutableDictionary dictionaryWithDictionary:[var_server objectForKey:AsciiString(@"year")]];
                [var_year setValue:AsciiString(@"year") forKey:AsciiString(@"product")];
                // 假月 真月 假年 真年 真周
                [self.cardArray insertObject:[self ht_translateModel:var_year] atIndex:2];
                NSMutableDictionary *var_week = [NSMutableDictionary dictionaryWithDictionary:[var_server objectForKey:AsciiString(@"week")]];
                [var_week setValue:AsciiString(@"week") forKey:AsciiString(@"product")];
                // 假月 真月 假年 真年 假周 真周
                [self.cardArray insertObject:[self ht_translateModel:var_week] atIndex:4];
            }
            NSArray *var_hidden = [[HTToolKitManager shared] lgjeropj_hidden_products];
            if (var_hidden.count > 0) {
                // 移除真实商品
                NSArray *array = [self.cardArray filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NSDictionary *evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
                    return ![[evaluatedObject objectForKey:@"var_fake"] boolValue];
                }]];
                for (NSInteger i = self.cardArray.count-1; i >= 0; i--) {
                    NSDictionary *dic = self.cardArray[i];
                    if ([array containsObject:dic]) {
                        [self.cardArray removeObject:dic];
                    }
                }
                array = [self.familyArray filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NSDictionary *evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
                    return ![[evaluatedObject objectForKey:@"var_fake"] boolValue];
                }]];
                for (NSInteger i = self.familyArray.count-1; i >= 0; i--) {
                    NSDictionary *dic = self.familyArray[i];
                    if ([array containsObject:dic]) {
                        [self.familyArray removeObject:dic];
                    }
                }
            }
            NSString *var_activity_product = @"";
            NSArray *var_k3 = [[HTToolKitManager shared] lgjeropj_strip_k3];
            if (var_k3.count > 0) {
                NSInteger var_activity = [[var_k3 firstObject] integerValue];
                if (var_activity == 1) {
                    // 有活动
                    if (var_k3.count > 2) {
                        var_activity_product = [NSString stringWithFormat:@"%@", [var_k3 objectAtIndex:2]];
                    }
                }
            }
            if (var_activity_product.length > 0) {
                if ([var_activity_product containsString:AsciiString(@"year")]) {
                    var_activity_product = AsciiString(@"year");
                } else if ([var_activity_product containsString:AsciiString(@"month")]) {
                    var_activity_product = AsciiString(@"month");
                }
                NSDictionary *var_trial_product = [var_server objectForKey:AsciiString(@"trial")];
                NSInteger index = -1;
                for (int i = 0; i < self.cardArray.count; i++) {
                    NSDictionary *dic = [self.cardArray objectAtIndex:i];
                    NSString *var_id = [dic objectForKey:AsciiString(@"id")];
                    BOOL var_fake = [[dic objectForKey:@"var_fake"] boolValue];
                    if (var_fake && [var_id isEqualToString:var_activity_product]) {
                        index = i;
                        break;
                    }
                }
                if (index >= 0) {
                    NSDictionary *replace = self.cardArray[index];
                    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:var_trial_product];
                    dic[AsciiString(@"activity")] = @"1";
                    [dic setValue:replace[AsciiString(@"product")] forKey:AsciiString(@"product")];
                    [self.cardArray removeObjectAtIndex:index];
                    [self.cardArray insertObject:[self ht_translateModel:dic] atIndex:0];
                }
            }
        }
    }
}

- (NSArray *)var_infoArray {
    if (_var_infoArray == nil) {
        _var_infoArray = [HTPremiumViewManager lgjeropj_hintArray];
    }
    return _var_infoArray;
}

@end
