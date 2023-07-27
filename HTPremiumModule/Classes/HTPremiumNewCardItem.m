//
//  HTPremiumNewCardItem.m
//  Moshfocus
//
//  Created by 李雪健 on 2023/6/25.
//

#import "HTPremiumNewCardItem.h"

@interface HTPremiumNewCardItem ()

@property (nonatomic, strong) UIImageView *trialView;
@property (nonatomic, strong) UILabel *trialLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *hintLabel;
@property (nonatomic, strong) UILabel *tagLabel;

@end

@implementation HTPremiumNewCardItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self lgjeropj_addCellSubViews];
    }
    return self;
}

- (void)lgjeropj_addCellSubViews {
    
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 6;
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#161A26"];
    
    self.dateLabel = [[UILabel alloc] init];
    self.dateLabel.adjustsFontSizeToFitWidth = YES;
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    self.dateLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightSemibold];
    [self.contentView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(38);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.adjustsFontSizeToFitWidth = YES;
    self.priceLabel.textAlignment = NSTextAlignmentCenter;
    self.priceLabel.font = [UIFont systemFontOfSize:24 weight:UIFontWeightBlack];
    [self.contentView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(66);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    
    self.hintLabel = [[UILabel alloc] init];
    self.hintLabel.adjustsFontSizeToFitWidth = YES;
    self.hintLabel.textAlignment = NSTextAlignmentCenter;
    self.hintLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    [self.contentView addSubview:self.hintLabel];
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(103);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    
    self.tagLabel = [[UILabel alloc] init];
    self.tagLabel.hidden = YES;
    self.tagLabel.textAlignment = NSTextAlignmentCenter;
    self.tagLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.tagLabel.backgroundColor = [UIColor colorWithHexString:@"#403DFF"];
    self.tagLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightBold];
    [self.contentView addSubview:self.tagLabel];
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
    
    self.trialView = [[UIImageView alloc] init];
    [self.trialView sd_setImageWithURL:[LKFPrivateFunction lgjeropj_imageUrlFromNumber:238]];
    [self.contentView addSubview:self.trialView];
    [self.trialView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.width.mas_equalTo(72);
        make.height.mas_equalTo(24);
    }];
    self.trialLabel = [[UILabel alloc] init];
    self.trialLabel.adjustsFontSizeToFitWidth = YES;
    self.trialLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.trialLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    [self.contentView addSubview:self.trialLabel];
    [self.trialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.trialView);
        make.width.mas_lessThanOrEqualTo(60);
    }];
}

- (void)lgjeropj_updateCellWithData:(NSDictionary *)data selected:(BOOL)selected {
    self.tagLabel.hidden = YES;
    BOOL var_fake = [[data objectForKey:@"var_fake"] boolValue];
    if (var_fake) {
        // 假卡片
        NSString *var_id = [data objectForKey:AsciiString(@"id")];
        NSString *var_product = @"";
        NSString *var_trialPrice = [data objectForKey:AsciiString(@"h1")];
        NSString *var_trialEndPrice = [data objectForKey:AsciiString(@"h2")];
        NSString *var_trial = @"";
        BOOL var_activity = [[data objectForKey:AsciiString(@"activity")] boolValue];
        if (var_activity) {
            var_trial = AsciiString(@"Limited Offer");
        } else if (![var_trialPrice isEqualToString:var_trialEndPrice] && var_trialPrice.length > 0) {
            var_trial = AsciiString(@"Trial");
        }
        self.trialView.hidden = var_trial.length == 0;
        self.trialLabel.hidden = var_trial.length == 0;
        self.trialLabel.text = var_trial;
        if ([var_id isEqualToString:AsciiString(@"week")]) {
            var_product = HT_IPA_Week;
        } else if ([var_id isEqualToString:AsciiString(@"month")]) {
            var_product = HT_IPA_Month;
        } else if ([var_id isEqualToString:AsciiString(@"year")]) {
            var_product = HT_IPA_Year;
        } else if ([var_id isEqualToString:AsciiString(@"fw")]) {
            var_product = [NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Week];
        } else if ([var_id isEqualToString:AsciiString(@"fm")]) {
            var_product = [NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Month];
        } else if ([var_id isEqualToString:AsciiString(@"fy")]) {
            var_product = [NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Year];
        }
        if ([var_product containsString:HT_IPA_Week] || [var_product containsString:[NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Week]]) {
            self.dateLabel.text = LocalString(@"Weekly", nil);
        } else if ([var_product containsString:HT_IPA_Month] || [var_product containsString:[NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Month]]) {
            self.dateLabel.text = LocalString(@"Monthly", nil);
            self.tagLabel.hidden = NO;
            self.tagLabel.text = AsciiString(@"Most Choose");
        } else if ([var_product containsString:HT_IPA_Year] || [var_product containsString:[NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Year]]) {
            self.dateLabel.text = LocalString(@"Annually", nil);
            self.tagLabel.hidden = NO;
            self.tagLabel.text = AsciiString(@"Best Price");
        }
        self.hintLabel.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@", [data objectForKey:AsciiString(@"d1")], [data objectForKey:AsciiString(@"y1")]] attributes:@{NSStrikethroughStyleAttributeName: @(NSUnderlinePatternSolid | NSUnderlineStyleSingle)}];
        self.priceLabel.text = [NSString stringWithFormat:@"%@%@", AsciiString(@"$"), [data objectForKey:AsciiString(@"price")]];
    } else {
        // 真实商品
        NSString *var_id = [data objectForKey:AsciiString(@"id")];
        if ([var_id containsString:HT_IPA_Week] || [var_id containsString:[NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Week]]) {
            self.dateLabel.text = LocalString(@"Weekly", nil);
            self.hintLabel.attributedText = [[NSAttributedString alloc] initWithString:AsciiString(@"for the 1st week")];
        } else if ([var_id containsString:HT_IPA_Month] || [var_id containsString:[NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Month]] || [var_id containsString:HT_IPA_Mosh]) {
            self.dateLabel.text = LocalString(@"Monthly", nil);
            self.hintLabel.attributedText = [[NSAttributedString alloc] initWithString:AsciiString(@"for the 1st month")];;
        } else if ([var_id containsString:HT_IPA_Year] || [var_id containsString:[NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Year]]) {
            self.dateLabel.text = LocalString(@"Annually", nil);
            self.hintLabel.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@", AsciiString(@"$"), [data objectForKey:AsciiString(@"discount")]] attributes:@{NSStrikethroughStyleAttributeName: @(NSUnderlinePatternSolid | NSUnderlineStyleSingle)}];
        }
        self.priceLabel.text = [NSString stringWithFormat:@"%@%@", AsciiString(@"$"), [data objectForKey:AsciiString(@"price")]];
        self.trialView.hidden = YES;
        self.trialLabel.hidden = YES;
        NSString *var_first = [data objectForKey:AsciiString(@"first")];
        if (var_first.length > 0) {
            // trial
            self.trialView.hidden = NO;
            self.trialLabel.hidden = NO;
            self.trialLabel.text = AsciiString(@"Trial");
        }
        if ([var_id containsString:HT_IPA_Year] || [var_id containsString:[NSString stringWithFormat:@"%@_%@", HT_IPA_Family, HT_IPA_Year]]) {
            self.trialView.hidden = NO;
            self.trialLabel.hidden = NO;
            CGFloat var_current = [[data objectForKey:AsciiString(@"price")] floatValue];
            CGFloat var_discount = [[data objectForKey:AsciiString(@"discount")] floatValue];
            NSString *var_proportion = [NSString stringWithFormat:@"%.f", (1-var_current/var_discount)*100];
            self.trialLabel.text = [NSString stringWithFormat:@"%@%@%%", @"-", var_proportion];
        }
    }
    if (selected) {
        BOOL var_activity = [[data objectForKey:AsciiString(@"activity")] boolValue];
        if (var_fake && var_activity) {
            [self.trialView sd_setImageWithURL:[LKFPrivateFunction lgjeropj_imageUrlFromNumber:239]];
            self.contentView.backgroundColor = [UIColor gradient:CGSizeMake(self.size.width, self.size.height) direction:0 start:[UIColor colorWithHexString:@"#FF1C1C"] end:[UIColor colorWithHexString:@"#FF6D1C"]];
            self.dateLabel.textColor = [UIColor colorWithHexString:@"#ECECEC"];
            self.priceLabel.textColor = [UIColor colorWithHexString:@"#ECECEC"];
            self.hintLabel.textColor = [UIColor colorWithHexString:@"#ECECEC"];
            self.trialLabel.textColor = [UIColor colorWithHexString:@"#685034"];
        } else {
            [self.trialView sd_setImageWithURL:[LKFPrivateFunction lgjeropj_imageUrlFromNumber:238]];
            self.contentView.backgroundColor = [UIColor gradient:CGSizeMake(self.size.width, self.size.height) direction:0 start:[UIColor colorWithHexString:@"#EDC391"] end:[UIColor colorWithHexString:@"#FDDDB7"]];
            self.dateLabel.textColor = [UIColor colorWithHexString:@"#222222"];
            self.priceLabel.textColor = [UIColor colorWithHexString:@"#222222"];
            self.hintLabel.textColor = [UIColor colorWithHexString:@"#222222"];
            self.trialLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
        }
    } else {
        [self.trialView sd_setImageWithURL:[LKFPrivateFunction lgjeropj_imageUrlFromNumber:238]];
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#161A26"];
        self.dateLabel.textColor = [UIColor colorWithHexString:@"#ECECEC"];
        self.priceLabel.textColor = [UIColor colorWithHexString:@"#ECECEC"];
        self.hintLabel.textColor = [UIColor colorWithHexString:@"#ECECEC"];
        self.trialLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    }
}

@end
