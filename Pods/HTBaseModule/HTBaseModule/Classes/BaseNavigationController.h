//
//  BaseNavigationController.h
//  SameCity
//
//  Created by mac on 2020/6/2.
//  Copyright © 2020 Jerry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseNavigationController : UINavigationController

@end

@interface UINavigationController (Extension)

- (void)ht_barTintColor:(UIColor *)tintColor andIsTranslucent:(BOOL)isTranslucent;

@end

NS_ASSUME_NONNULL_END
