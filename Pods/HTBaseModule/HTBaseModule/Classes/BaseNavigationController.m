//
//  BaseNavigationController.m
//  SameCity
//
//  Created by mac on 2020/6/2.
//  Copyright © 2020 Jerry. All rights reserved.
//

#import "BaseNavigationController.h"
#import "BaseViewController.h"
#import <MoExtension/MoExtension.h>
#import "HTCommonMacro.h"

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self ht_barTintColor:[UIColor clearColor] andIsTranslucent:YES];
    
    UISwipeGestureRecognizer *var_swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(lgjeropj_swipeRight:)];
    [var_swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:var_swipeLeft];
    
    UISwipeGestureRecognizer *var_swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(lgjeropj_swipeRight:)];
    [var_swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:var_swipeRight];
}

- (void)lgjeropj_swipeRight:(UISwipeGestureRecognizer *)sender {
    BOOL var_isBack = NO;
    CGPoint var_point = [sender locationInView:self.view];
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (var_point.x > kScreenWidth - 30) {
            var_isBack = YES;
        }
    } else {
        if (var_point.x > 0 && var_point.x < 30) {
            var_isBack = YES;
        }
    }
    
    if (var_isBack) {
        if (self.viewControllers.count > 1) {
            BaseViewController *vc = (BaseViewController *)[self.viewControllers lastObject];
            [vc ht_leftItemClicked:nil];
        }
    }
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (BOOL)prefersHomeIndicatorAutoHidden {
    return NO;
}

- (BOOL)shouldAutorotate {
    UIViewController *selectedVC = [self visibleViewController];
    return selectedVC.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    UIViewController *selectedVC = [self visibleViewController];
    return selectedVC.supportedInterfaceOrientations;
}

@end


@implementation UINavigationController (Extension)

- (void)ht_barTintColor:(UIColor *)tintColor andIsTranslucent:(BOOL)var_isTranslucent {
    
    if (@available(iOS 13.0, *)) {
        
        UINavigationBarAppearance * var_barApp = [[UINavigationBarAppearance alloc] init];
        
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:16 weight:(UIFontWeightSemibold)], NSForegroundColorAttributeName: [UIColor whiteColor]};
        var_barApp.titleTextAttributes = attributes;
        
        if ( var_isTranslucent ) {
            [var_barApp configureWithTransparentBackground];
            var_barApp.backgroundColor = tintColor;
            var_barApp.shadowColor = tintColor;
            self.navigationBar.standardAppearance = var_barApp;
            self.navigationBar.scrollEdgeAppearance = nil;
        } else {
            [var_barApp configureWithOpaqueBackground];
            var_barApp.backgroundColor = tintColor;
            var_barApp.shadowColor = tintColor;
            self.navigationBar.scrollEdgeAppearance = var_barApp;
            self.navigationBar.standardAppearance = var_barApp;
        }
    } else {
        self.navigationBar.shadowImage = [UIImage new];
        UIImage * img = [tintColor imageWithSize:CGSizeMake(kScreenWidth, kNavBarHeight)];
        [self.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    }
    //透明设置
    self.navigationBar.translucent = var_isTranslucent;
}

@end
