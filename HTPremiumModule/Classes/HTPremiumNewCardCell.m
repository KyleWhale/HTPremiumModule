//
//  HTPremiumFakeCardCell.m
//  Moshfocus
//
//  Created by 李雪健 on 2023/6/25.
//

#import "HTPremiumNewCardCell.h"
#import "HTPremiumNewCardItem.h"
#import "HTPremiumVipCellManager.h"

@interface HTPremiumNewCardCell () <UICollectionViewDelegate, UICollectionViewDataSource, UITextViewDelegate>

@property (nonatomic, strong) UIButton *htIndividualButton;
@property (nonatomic, strong) UIButton *htFamilyButton;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *htHintLabel;
@property (nonatomic, strong) UIButton *htPayButton;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSArray *individualArray;
@property (nonatomic, strong) NSArray *familyArray;
@property (nonatomic, strong) NSDictionary *var_product;
@property (nonatomic, strong) UITextView *textView;

@end

@implementation HTPremiumNewCardCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self lgjeropj_addCellSubViews];
    }
    return self;
}

- (void)lgjeropj_addCellSubViews {
    
    self.htIndividualButton = [[UIButton alloc] init];
    [self.htIndividualButton setTitle:LocalString(@"Individual Plan", nil) forState:UIControlStateNormal];
    [self.htIndividualButton setTitleColor:[UIColor colorWithHexString:@"#727682"] forState:UIControlStateNormal];
    [self.htIndividualButton setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateSelected];
    [self.htIndividualButton setBackgroundImage:[[UIColor colorWithHexString:@"#161A26"] imageWithSize:CGSizeMake(kScreenWidth/2, 48)] forState:UIControlStateNormal];
    [self.htIndividualButton setBackgroundImage:[[UIColor colorWithHexString:@"#11101E"] imageWithSize:CGSizeMake(kScreenWidth/2, 48)] forState:UIControlStateSelected];
    self.htIndividualButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    @weakify(self);
    [[self.htIndividualButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.collectionView reloadData];
        self.htIndividualButton.selected = YES;
        self.htFamilyButton.selected = NO;
        [self lgjeropj_interestView];
        [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(16+48+8+2*38+14);
        }];
        if (self.typeBlock) {
            self.typeBlock(0);
        }
        if (self.indexBlock) {
            self.indexBlock(0);
        }
    }];
    [self.contentView addSubview:self.htIndividualButton];
    [self.htIndividualButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(48);
        make.width.mas_equalTo(kScreenWidth/2);
    }];
    
    self.htFamilyButton = [[UIButton alloc] init];
    [self.htFamilyButton setTitle:LocalString(@"Family Plan", nil) forState:UIControlStateNormal];
    [self.htFamilyButton setTitleColor:[UIColor colorWithHexString:@"#727682"] forState:UIControlStateNormal];
    [self.htFamilyButton setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateSelected];
    [self.htFamilyButton setBackgroundImage:[[UIColor colorWithHexString:@"#161A26"] imageWithSize:CGSizeMake(kScreenWidth/2, 48)] forState:UIControlStateNormal];
    [self.htFamilyButton setBackgroundImage:[[UIColor colorWithHexString:@"#11101E"] imageWithSize:CGSizeMake(kScreenWidth/2, 48)] forState:UIControlStateSelected];
    self.htFamilyButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [[self.htFamilyButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.collectionView reloadData];
        self.htFamilyButton.selected = YES;
        self.htIndividualButton.selected = NO;
        [self lgjeropj_interestView];
        [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(16+48+8+3*38+14);
        }];
        if (self.typeBlock) {
            self.typeBlock(1);
        }
        if (self.indexBlock) {
            self.indexBlock(0);
        }
    }];
    [self.contentView addSubview:self.htFamilyButton];
    [self.htFamilyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.htIndividualButton);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(48);
        make.width.mas_equalTo(kScreenWidth/2);
    }];
    
    self.htIndividualButton.selected = YES;
    self.htFamilyButton.selected = NO;
    // 权益
    [self lgjeropj_interestView];
    // 卡片
    self.collectionView = [HTKitCreate ht_collectionViewWithDelegate:self andIsVertical:NO andLineSpacing:12 andColumnSpacing:0 andItemSize:CGSizeMake(kWidthScale(107), kWidthScale(145)) andIsEstimated:NO andSectionInset:UIEdgeInsetsMake(0, 16, 0, 16)];
    [self.collectionView registerClass:[HTPremiumNewCardItem class] forCellWithReuseIdentifier:NSStringFromClass([HTPremiumNewCardItem class])];
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16+48+8+2*38+14);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kWidthScale(145));
    }];
    
    self.htHintLabel = [[UILabel alloc] init];
    self.htHintLabel.numberOfLines = 0;
    self.htHintLabel.font = [UIFont systemFontOfSize:12];
    self.htHintLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self.contentView addSubview:self.htHintLabel];
    [self.htHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom).offset(10);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_greaterThanOrEqualTo(14);
    }];
    
    self.htPayButton = [[UIButton alloc] init];
    [self.htPayButton setTitleColor:[UIColor colorWithHexString:@"#685034"] forState:UIControlStateNormal];
    self.htPayButton.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBlack];
    self.htPayButton.backgroundColor = [UIColor gradient:CGSizeMake(kScreenWidth-47, 44) direction:0 start:[UIColor colorWithHexString:@"#EDC391"] end:[UIColor colorWithHexString:@"#FDDDB7"]];
    self.htPayButton.layer.cornerRadius = 22;
    [[self.htPayButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.payBlock) {
            self.payBlock(self.var_product);
        }
    }];
    [self.contentView addSubview:self.htPayButton];
    [self.htPayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom).offset(58);
        make.left.mas_equalTo(23.5);
        make.right.mas_equalTo(-23.5);
        make.height.mas_equalTo(44);
    }];
    
    self.textView = [HTPremiumVipCellManager lgjeropj_textView:self];
    [self.contentView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).inset(16);
        make.top.equalTo(self.htPayButton.mas_bottom).offset(24);
        make.height.mas_equalTo(18);
    }];
}

/**
 *   height 16+48+8+(self.htFamilyButton.selected ? 3 : 2)*38+14+136+58+44+24+18
 */
- (void)lgjeropj_interestView {
    
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj && obj.tag >= 289000 && [obj isKindOfClass:[UIButton class]]) {
            [obj removeFromSuperview];
        }
    }];
    NSMutableArray *array = @[LocalString(@"Remove ads", nil), LocalString(@"Unlock all movies", nil), LocalString(@"HD Resources", nil), LocalString(@"Unlimited Screen Casting", nil)].mutableCopy;
    if (self.htFamilyButton.selected) {
        [array addObject:LocalString(@"Up To 5 Members", nil)];
    }
    for (int i = 0; i < array.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = 289000+i;
        button.userInteractionEnabled = NO;
        button.titleLabel.numberOfLines = 2;
        [button setTitle:array[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button setTitleColor:[UIColor colorWithHexString:@"#EAE9EE"] forState:UIControlStateNormal];
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [button sd_setImageWithURL:[LKFPrivateFunction lgjeropj_imageUrlFromNumber:212] forState:UIControlStateNormal];
        [self.contentView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(16+48+8+38*(i/2));
            make.left.mas_equalTo(25+kScreenWidth/2*(i%2));
            make.width.mas_equalTo(kScreenWidth/2-30);
            make.height.mas_equalTo(38);
        }];
    }
}

- (void)lgjeropj_updateCellWithData:(NSArray *)var_individualData andFamilyData:(NSArray *)var_familyData {
    
    self.individualArray = var_individualData;
    self.familyArray = var_familyData;
    self.selectedIndex = 0;
    [self.collectionView reloadData];
    [self lgjeropj_refreshWithIndex:0];
}

- (NSArray *)ht_currentArray {
    
    if (self.htIndividualButton.selected) {
        return self.individualArray;
    }
    return self.familyArray;
}

- (void)lgjeropj_refreshWithIndex:(NSInteger)index {
    
    if ([self ht_currentArray].count > index) {
        NSDictionary *data = [self ht_currentArray][index];
        self.var_product = data;
        BOOL var_fake = [[data objectForKey:@"var_fake"] boolValue];
        if (var_fake) {
            // 假卡片
            BOOL var_activity = [[data objectForKey:AsciiString(@"activity")] boolValue];
            if (var_activity) {
                [self.htPayButton setTitle:[NSString stringWithFormat:@"%@%@ %@ %@", [data objectForKey:@"d1"], [data objectForKey:@"h1"], AsciiString(@"First"), AsciiString(@"Trial")] forState:UIControlStateNormal];
            } else {
                NSString *var_trialPrice = [data objectForKey:AsciiString(@"h1")];
                NSString *var_trialEndPrice = [data objectForKey:AsciiString(@"h2")];
                if (![var_trialPrice isEqualToString:var_trialEndPrice] && var_trialPrice.length > 0) {
                    [self.htPayButton setTitle:[NSString stringWithFormat:@"%@%@ %@ %@", [data objectForKey:@"d1"], [data objectForKey:@"h1"], AsciiString(@"First"), AsciiString(@"Trial")] forState:UIControlStateNormal];
                } else {
                    [self.htPayButton setTitle:[NSString stringWithFormat:@"%@ %@%@", AsciiString(@"Pay"), [data objectForKey:@"d1"], [data objectForKey:@"h2"]] forState:UIControlStateNormal];
                }
            }
            NSString *string = [data objectForKey:AsciiString(@"t1")];
            if (string.length > 0) {
                NSString *var_cancel = LocalString(@"Cancel Anytime", nil);
                string = [NSString stringWithFormat:@"%@ %@ %@", @"*", string, var_cancel];
                NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:string];
                [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#3CDEF4"] range:NSMakeRange(0, string.length-var_cancel.length)];
                [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#999999"] range:NSMakeRange(string.length-var_cancel.length, var_cancel.length)];
                [attribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12 weight:UIFontWeightBold] range:NSMakeRange(0, string.length-var_cancel.length)];
                [attribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12 weight:UIFontWeightRegular] range:NSMakeRange(string.length-var_cancel.length, var_cancel.length)];
                self.htHintLabel.attributedText = attribute;
            } else {
                NSString *var_cancel = LocalString(@"Cancel Anytime", nil);
                NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:var_cancel];
                [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#999999"] range:NSMakeRange(0, var_cancel.length)];
                [attribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12 weight:UIFontWeightRegular] range:NSMakeRange(0, var_cancel.length)];
                self.htHintLabel.attributedText = attribute;
            }
        } else {
            // 真实商品
            NSString *var_price = [data objectForKey:AsciiString(@"first")];
            if (var_price.length == 0 || var_price.integerValue == 0) {
                var_price = [data objectForKey:AsciiString(@"price")];
            }
            if ([var_price integerValue] == 0) {
                var_price = LocalString(@"Free", nil);
                [self.htPayButton setTitle:[NSString stringWithFormat:@"%@ %@", AsciiString(@"Pay"), LocalString(@"Free", nil)] forState:UIControlStateNormal];
            } else {
                [self.htPayButton setTitle:[NSString stringWithFormat:@"%@ %@%@", AsciiString(@"Pay"), AsciiString(@"$"), var_price] forState:UIControlStateNormal];
            }
            NSString *var_id = [data objectForKey:AsciiString(@"id")];
            NSString *var_time = @"";
            if ([var_id containsString:HT_IPA_Week] || [var_id containsString:[NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Week]]) {
                var_time = AsciiString(@"week");
            } else if ([var_id containsString:HT_IPA_Month] || [var_id containsString:[NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Month]] || [var_id containsString:HT_IPA_Mosh]) {
                var_time = AsciiString(@"month");
            } else if ([var_id containsString:HT_IPA_Year] || [var_id containsString:[NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Year]]) {
                var_time = AsciiString(@"year");
            }
            NSString *var_first = [data objectForKey:AsciiString(@"first")];
            NSString *string = @"";
            if (var_first.length > 0) {
                string = [NSString stringWithFormat:@"%@ %@%@ %@ %@%@ %@ %@ %@%@", @"*", AsciiString(@"$"), var_first, AsciiString(@"for the 1st"), var_time, @".", AsciiString(@"Next recurring annual renewal will be"), AsciiString(@"$"), [data objectForKey:AsciiString(@"price")], AsciiString(@"")];
            } else {
                string = [NSString stringWithFormat:@"%@ %@ %@%@ %@ %@", @"*", AsciiString(@"Auto-renewal for"), AsciiString(@"$"), [data objectForKey:AsciiString(@"price")], AsciiString(@"per"), var_time];
            }
            NSString *var_cancel = LocalString(@"you can cancel anytime", nil);
            string = [NSString stringWithFormat:@"%@%@ %@", string, @",", var_cancel];
            NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:string];
            [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#3CDEF4"] range:NSMakeRange(0, string.length-var_cancel.length)];
            [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#999999"] range:NSMakeRange(string.length-var_cancel.length, var_cancel.length)];
            [attribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12 weight:UIFontWeightBold] range:NSMakeRange(0, string.length-var_cancel.length)];
            [attribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12 weight:UIFontWeightRegular] range:NSMakeRange(string.length-var_cancel.length, var_cancel.length)];
            self.htHintLabel.attributedText = attribute;
        }
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [[self ht_currentArray] count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HTPremiumNewCardItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HTPremiumNewCardItem class]) forIndexPath:indexPath];
    if ([self ht_currentArray].count > indexPath.row) {
        [cell lgjeropj_updateCellWithData:[self ht_currentArray][indexPath.row] selected:self.selectedIndex == indexPath.row];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedIndex = indexPath.row;
    if (self.indexBlock) {
        self.indexBlock(self.selectedIndex);
    }
    [self.collectionView reloadData];
    [self lgjeropj_refreshWithIndex:self.selectedIndex];
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    
    if( self.restoreBlock ) {
        self.restoreBlock();
    }
    return YES;
}

@end
