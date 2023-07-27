//
//  BaseView.h
//  Hucolla
//
//  Created by mac on 2022/9/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseView : UIView

- (void)ht_addViewSubViews;

- (void)ht_updateViewWithData:(id)data;

@end

NS_ASSUME_NONNULL_END
