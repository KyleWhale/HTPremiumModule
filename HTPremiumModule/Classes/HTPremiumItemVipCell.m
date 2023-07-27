//
//  HTPremiumItemVipCell.m
//  Hucolla
//
//  Created by mac on 2022/9/16.
//

#import "HTPremiumItemVipCell.h"
#import "HTPremiumItemManager.h"

@interface HTPremiumItemVipCell()

@property (nonatomic, strong) UILabel            * vipLab;
@property (nonatomic, strong) UIImageView        * trialImgV;
@property (nonatomic, strong) UILabel            * discountLab;
@property (nonatomic, strong) UILabel            * priceLab;
@property (nonatomic, strong) UILabel            * var_monLab;
@property (nonatomic, strong) UIButton           * payBtn;
@property (nonatomic, strong) UILabel            * thenLab;

@property (nonatomic, strong) UILabel            * disLab;
@property (nonatomic, strong) UILabel            * countLab;
@property (nonatomic, strong) UILabel            * dLab;
@property (nonatomic, strong) NSDictionary       * data;

@end

@implementation HTPremiumItemVipCell

- (void)ht_addCellSubViews {
    
    CGFloat scale = [HTPremiumItemManager lgjeropj_getScale];
    
    self.backgroundColor = [UIColor colorWithHexString:@"#FDDDB8"];
    self.cornerRadius = 12*scale;
    
    UIView *line = [HTPremiumItemManager lgjeropj_line];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(40*scale);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView);
        make.height.equalTo(@1);
    }];
    
    self.vipLab = [HTPremiumItemManager lgjeropj_vipLabel];
    [self.contentView addSubview:self.vipLab];
    [self.vipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(16*scale);
        make.height.equalTo(@(16*scale));
        make.width.greaterThanOrEqualTo(@52);
    }];
    
    self.trialImgV = [HTPremiumItemManager lgjeropj_trialImage];
    [self.contentView addSubview:self.trialImgV];
    [self.trialImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.height.equalTo(@(27*scale));
        make.width.equalTo(@(48*scale));
    }];
    
    self.discountLab = [HTPremiumItemManager lgjeropj_discountLabel];
    [self.contentView addSubview:self.discountLab];
    [self.discountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.contentView).offset(18*scale);
        make.height.equalTo(@(14*scale));
        make.width.greaterThanOrEqualTo(@52);
    }];
    
    self.dLab = [HTPremiumItemManager lgjeropj_symbolLabel];
    [self.contentView addSubview:self.dLab];
    [self.dLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(line.mas_bottom).offset(16*scale);
        make.height.equalTo(@(16*scale));
        make.width.greaterThanOrEqualTo(@8);
    }];
    
    self.priceLab = [HTPremiumItemManager lgjeropj_priceLabel];
    [self.contentView addSubview:self.priceLab];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dLab.mas_right);
        make.top.equalTo(line.mas_bottom).offset(16*scale);
        make.height.equalTo(@(38*scale));
        make.width.greaterThanOrEqualTo(@65);
    }];
    
    self.var_monLab = [HTPremiumItemManager lgjeropj_monLabel];
    [self.contentView addSubview:self.var_monLab];
    [self.var_monLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLab.mas_right).offset(3);
        make.centerY.equalTo(self.priceLab);
        make.height.equalTo(@(40*scale));
        make.width.equalTo(@(60*scale));
    }];
    
    self.thenLab = [HTPremiumItemManager lgjeropj_thenLabel];
    [self.contentView addSubview:self.thenLab];
    [self.thenLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-22);
        make.top.equalTo(self.priceLab.mas_bottom).offset(5*scale);
        make.height.equalTo(@(30*scale));
    }];
    
    self.disLab = [HTPremiumItemManager lgjeropj_disLabel];
    self.disLab.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:self.disLab];
    [self.disLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.width.equalTo(@(43*scale));
        make.top.equalTo(self.priceLab.mas_bottom).offset(5);
        make.height.equalTo(@(16*scale));
    }];
    
    self.countLab = [HTPremiumItemManager lgjeropj_countLabel];
    self.countLab.backgroundColor = [UIColor colorWithHexString:@"#FFB054"];
    [self.contentView addSubview:self.countLab];
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.disLab.mas_right);
        make.width.equalTo(@(60*scale));
        make.top.equalTo(self.priceLab.mas_bottom).offset(5);
        make.height.equalTo(@(16*scale));
    }];
    
    self.payBtn = [HTPremiumItemManager lgjeropj_payButton:self action:@selector(lgjeropj_onPayAction)];
    [self.contentView addSubview:self.payBtn];
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).inset(11);
        make.bottom.equalTo(self.contentView).offset(-10*scale);
        make.height.equalTo(@(32*scale));
    }];
}

- (void)ht_updateCellWithData:(id)data {
    if ( data ) {
        CGFloat scale = [HTPremiumItemManager lgjeropj_getScale];
        
        NSDictionary *var_dict = (NSDictionary *)data;
        self.data = var_dict;
        self.dLab.text = AsciiString(@"$");
        NSString *idStr = var_dict[AsciiString(@"id")];
        if ([idStr containsString:AsciiString(@"week")]) {
            self.vipLab.text = LocalString(@"Weekly", nil);
            self.priceLab.text = var_dict[AsciiString(@"price")];
            NSString *message = LocalString(@"Price", nil);
            self.discountLab.attributedText = [HTPremiumItemManager lgjeropj_getAttributeWithString:[NSString stringWithFormat:AsciiString(@"%@: $%@"), message, var_dict[AsciiString(@"discount")]]];
            self.trialImgV.hidden = YES;
            
            NSString *wMsg = [NSString stringWithFormat:@"/%@", LocalString(@"Weekly", nil)];
            self.var_monLab.attributedText = [HTPremiumItemManager lgjeropj_getVipAttributeWithString:wMsg font:HTPingFangRegularFont(12*scale) color:[UIColor colorWithHexString:@"#685034"]];
            self.thenLab.text = @"";
            self.countLab.hidden = NO;
            self.countLab.hidden = YES;
            self.disLab.hidden = YES;
        } else {
            NSString *var_viptitleStr = LocalString(@"Monthly", nil);
            NSString *var_vipdetailStr = LocalString(@"month", nil);
            if ([idStr containsString:AsciiString(@"year")]) {
                var_viptitleStr = LocalString(@"Annually", nil);
                var_vipdetailStr = LocalString(@"year", nil);
            }
            self.vipLab.text = var_viptitleStr;
            
            NSString *var_firstStr = var_dict[AsciiString(@"first")];
            if (var_firstStr && var_firstStr.length > 0) {
                self.dLab.text = [var_firstStr floatValue] > 0 ? AsciiString(@"$") : @"";
                self.priceLab.text = [var_firstStr floatValue] > 0 ? var_firstStr : LocalString(@"Free", nil);
                self.discountLab.text = @"";
                self.trialImgV.hidden = NO;
                
                NSString *message4 = LocalString(@"for %@", nil);
                NSString *message3 = [NSString stringWithFormat:@"%@%@", @"1", var_vipdetailStr];
                NSString *message2 = [NSString stringWithFormat:message4,message3];
                self.var_monLab.attributedText = [HTPremiumItemManager lgjeropj_getVipAttributeWithString:message2 font:HTPingFangRegularFont(12*scale) color:[UIColor colorWithHexString:@"#685034"]];
                [self.var_monLab adjustsFontSizeToFitWidth];
                
                NSString *string1 = LocalString(@"Then %@%@/%@ After Trial Ends.", nil);
                NSString *message = [NSString stringWithFormat:string1, AsciiString(@"$"), var_dict[AsciiString(@"price")], var_vipdetailStr];
                NSString *then = message;
                self.thenLab.attributedText = [HTPremiumItemManager lgjeropj_getVipAttributeWithString:then font:HTPingFangFont(12*scale) color:[UIColor colorWithHexString:@"#222222"]];
                self.countLab.hidden = YES;
                self.disLab.hidden = YES;
            }else {
                self.priceLab.text = var_dict[AsciiString(@"price")];
                NSString *message = LocalString(@"Price", nil);
                self.discountLab.attributedText = [HTPremiumItemManager lgjeropj_getAttributeWithString:[NSString stringWithFormat:AsciiString(@"%@: $%@"), message, var_dict[AsciiString(@"discount")]]];
                self.trialImgV.hidden = YES;
                NSString *yMsg = [NSString stringWithFormat:@"/%@", var_viptitleStr];
                self.var_monLab.attributedText = [HTPremiumItemManager lgjeropj_getVipAttributeWithString:yMsg font:HTPingFangRegularFont(12*scale) color:[UIColor colorWithHexString:@"#685034"]];
                self.thenLab.text = @"";
                self.countLab.hidden = NO;
                self.disLab.hidden = NO;
                CGFloat var_dis = ([[var_dict objectForKey:AsciiString(@"discount")] floatValue] - [[var_dict objectForKey:AsciiString(@"price")] floatValue]) / [[var_dict objectForKey:AsciiString(@"discount")] floatValue];
                self.disLab.text = [NSString stringWithFormat:@"-%.f%%", var_dis * 100];
            }
        }
        
        if ( [var_dict[AsciiString(@"discount")] length] > 0 ) {
            self.discountLab.hidden = NO;
        } else {
            self.discountLab.hidden = YES;
        }
    }
}

- (void)lgjeropj_onPayAction {
    if ( self.vipBlock ) {
        self.vipBlock(self.data);
    }
}

@end
