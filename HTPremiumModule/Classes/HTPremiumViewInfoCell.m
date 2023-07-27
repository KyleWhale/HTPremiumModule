//
//  HTPremiumViewInfoCell.m
//  Hucolla
//
//  Created by mac on 2022/9/16.
//

#import "HTPremiumViewInfoCell.h"

@interface  HTPremiumViewInfoCell()<UITextViewDelegate>

@property (nonatomic, strong) UITextView       * textView;

@end

@implementation HTPremiumViewInfoCell

- (void)ht_addCellSubViews {
    
    CGFloat scale = [self lgjeropj_getScale];
    
    UIView *dotV = [[UIView alloc] init];
    dotV.backgroundColor = [UIColor whiteColor];
    dotV.cornerRadius = 3*scale;
    [self.contentView addSubview:dotV];
    [dotV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.top.equalTo(self.contentView).offset(6);
        make.width.height.equalTo(@(6*scale));
    }];
    
    self.textView = [[UITextView alloc] init];
    self.textView.editable = NO;
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.textContainerInset = UIEdgeInsetsZero;
    self.textView.scrollEnabled = NO;
    self.textView.delegate = self;
    [self.contentView addSubview: self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(dotV.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-16);
    }];
    
    self.textView.linkTextAttributes = @{NSFontAttributeName:HTPingFangRegularFont(12*scale),
          NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#5B98F3"]};
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    NSLog(@"%@",URL.absoluteString);
    return YES;
}

- (void)ht_updateCellWithData:(id)data {
    NSMutableAttributedString *att = (NSMutableAttributedString *)data;
    self.textView.attributedText = att;
}

- (CGFloat)ht_cellHeight {
    CGRect rect = [self.textView.attributedText boundingRectWithSize:CGSizeMake(kScreenWidth - 32 - 16, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return rect.size.height;
}

- (CGFloat)lgjeropj_getScale {
    CGFloat itemWid = 162;
    if ( isPad ) {
        itemWid = (kScreenWidth - 16*2 - 10*2)/3;
    }
    CGFloat scale = itemWid/162;
    return scale;
}

@end
