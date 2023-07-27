//
//  HTPremiumVipCellManager.m
//  Moshfocus
//
//  Created by 李雪健 on 2023/6/7.
//

#import "HTPremiumVipCellManager.h"

@implementation HTPremiumVipCellManager

+ (UICollectionView *)lgjeropj_collectionView:(id)target {
    
    UICollectionView *view = [HTKitCreate ht_collectionViewWithDelegate:target andIsVertical:NO andLineSpacing:10 andColumnSpacing:0 andItemSize:CGSizeMake(162*[self lgjeropj_getScale], 210*[self lgjeropj_getScale]) andIsEstimated:NO andSectionInset:UIEdgeInsetsMake(0, 16, 0, 16)];
    [view registerClass:[HTPremiumItemVipCell class] forCellWithReuseIdentifier:NSStringFromClass([HTPremiumItemVipCell class])];
    return view;
}

+ (UITextView *)lgjeropj_textView:(id)target {
    
    UITextView *view = [[UITextView alloc] init];
    view.editable = NO;
    view.backgroundColor = [UIColor clearColor];
    view.textContainerInset = UIEdgeInsetsZero;
    view.scrollEnabled = NO;
    view.delegate = target;
    NSString *underLineStr = LocalString(@"tap Restore.", nil);
    NSString *localRe = LocalString(@"If the ad still appears after purchase,", nil);
    NSString *str = [NSString stringWithFormat:@"%@%@", localRe, underLineStr];
    view.attributedText = [self lgjeropj_getAttributeWithString:str range:[str rangeOfString:underLineStr] link:underLineStr];
    view.linkTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14 weight:UIFontWeightSemibold],NSForegroundColorAttributeName:[UIColor whiteColor]};

    return view;
}

+ (UIView *)lgjeropj_line {
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
    return view;
}

+ (NSMutableAttributedString *)lgjeropj_getAttributeWithString:(NSString *)str range:(NSRange)range link:(NSString *)link
{
    CGFloat scale = [self lgjeropj_getScale];
    HTAttributedManager *manager = [[HTAttributedManager alloc] initWithText:str andFont:HTPingFangRegularFont(12*scale) andForegroundColor:[UIColor colorWithHexString:@"#CCCCCC"]];
    [manager ht_addLineSpace:0 andFirstLineHeadIndent:0 andAlignment:NSTextAlignmentCenter];
    if ( range.location != NSNotFound && range.length > 0 ) {
        HTAttributedManager *subManager = [[HTAttributedManager alloc] initWithText:nil andFont:[UIFont systemFontOfSize:14 weight:(UIFontWeightSemibold)] andForegroundColor:[UIColor whiteColor]];
        if ( link ) {
            subManager.link = link;
            subManager.underline = @1;
            subManager.underlineColor = [UIColor whiteColor];
        }
        [manager ht_setAttributedModel:subManager andRang:range];
    }
    return manager.contentMutableAttributed;
}

+ (CGFloat)lgjeropj_getScale
{
    CGFloat itemWid = 162;
    if ( isPad ) {
        itemWid = (kScreenWidth - 16*2 - 10*2)/3;
    }
    CGFloat scale = itemWid/162;
    return scale;
}

@end
