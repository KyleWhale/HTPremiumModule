//
//  HTVipActivityView.h
//  Moshfocus
//
//  Created by 李雪健 on 2023/6/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BLOCK_ActivityBlock) (NSDictionary * _Nullable infoDict);

@interface HTVipActivityView : UIView

@property (nonatomic, copy) BLOCK_ActivityBlock block;
@property (nonatomic, assign) NSInteger source;
@property (nonatomic, strong) UIImage *var_image;

- (void)lgjeropj_showInView:(UIView *)view;

- (void)lgjeropj_dismiss;

@end

NS_ASSUME_NONNULL_END
