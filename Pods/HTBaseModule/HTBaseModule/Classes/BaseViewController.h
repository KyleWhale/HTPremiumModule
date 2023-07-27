//
//  BaseViewController.h
//  SameCity
//
//  Created by mac on 2020/5/28.
//  Copyright © 2020 Jerry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

// 是否禁用侧滑返回
- (BOOL)ht_slideBackDisable;
// 左按钮  默认
- (void)ht_addDefaultLeftItem;
// 左按钮  点击方法
- (void)ht_leftItemClicked:(UIButton * __nullable)sender;
// 右按钮  文字类型
- (void)ht_addRightBtnWithTitle:(NSString *)title;
// 右按钮  图片类型
- (void)ht_addRightBtnWithImage:(id)named;
// 右按钮  点击方法
- (void)ht_rightItemClicked:(UIButton *)sender;

@end


NS_ASSUME_NONNULL_END
