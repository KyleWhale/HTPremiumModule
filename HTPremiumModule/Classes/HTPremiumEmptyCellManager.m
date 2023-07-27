//
//  HTPremiumEmptyCellManager.m
//  Moshfocus
//
//  Created by 李雪健 on 2023/6/7.
//

#import "HTPremiumEmptyCellManager.h"
#import "HTDBVipModel.h"

@implementation HTPremiumEmptyCellManager

+ (UILabel *)lgjeropj_warning {

    NSString *string = AsciiString(@"WARNING");
    CGFloat width = [string sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}].width;
    UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - width - 20)/2, 20, width + 20, 40)];
    view.text = string;
    view.textColor = [UIColor whiteColor];
    view.font = [UIFont boldSystemFontOfSize:18];
    view.textAlignment = NSTextAlignmentCenter;
    return view;
}

+ (UIImageView *)lgjeropj_left {
    
    UIImageView *view = [[UIImageView alloc] init];
    [view sd_setImageWithURL:[LKFPrivateFunction lgjeropj_imageUrlFromNumber:240]];
    return view;
}

+ (UIImageView *)lgjeropj_right {
    
    UIImageView *view = [[UIImageView alloc] init];
    [view sd_setImageWithURL:[LKFPrivateFunction lgjeropj_imageUrlFromNumber:241]];
    return view;
}

+ (UILabel *)lgjeropj_contentLabel {
    
    NSString *firstString = LocalString(@"Because of Apple Policy, you cannot subscribe here.", nil);
    NSString *secondString = LocalString(@"You can download the new APP to subscribe.", nil);
    HTDBVipModel *model = [[HTDBVipModel alloc] init];
    if ([model ht_isVip]) {
        firstString = LocalString(@"Because of Apple Policy, you cannot renew or upgrade your subscription here.", nil);
        secondString = LocalString(@"You can download the new APP to renew or upgrade your subscription.", nil);
    }
    NSString *contentString = [NSString stringWithFormat:@"%@\n%@",firstString,secondString];
    CGSize boundingSize = CGSizeMake(kScreenWidth-40, MAXFLOAT);
    CGSize textSize = [contentString boundingRectWithSize:boundingSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    CGFloat contentHeight = textSize.height + 40;
    UILabel *view = [[UILabel alloc] init];
    view.text = contentString;
    view.height = contentHeight;
    view.textColor = [UIColor whiteColor];
    view.font = [UIFont systemFontOfSize:15];
    view.textAlignment = NSTextAlignmentCenter;
    view.numberOfLines = 0;
    return view;
}

+ (UIButton *)lgjeropj_tapButton:(id)target action:(SEL)action {
    
    UIButton *view = [[UIButton alloc] init];
    [view setTitle:LocalString(@"DOWNLOAD NOW", nil) forState:UIControlStateNormal];
    [view setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    view.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [view addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 10.0;
    view.backgroundColor = [UIColor gradient:CGSizeMake(kScreenWidth*0.7, 44) direction:0 start:[UIColor colorWithHexString:@"#7775FF"] end:[UIColor colorWithHexString:@"#403DFF"]];
    return view;
}

@end
