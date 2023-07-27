//
//  BaseViewController.m
//  SameCity
//
//  Created by mac on 2020/5/28.
//  Copyright © 2020 Jerry. All rights reserved.
//

#import "BaseViewController.h"
#import <MoExtension/MoExtension.h>
#import "HTCommonMacro.h"
#import "SDWebImage.h"

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kMainColor;
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold], NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#FFFFFF"]};
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *var_barApp = self.navigationController.navigationBar.standardAppearance;
        var_barApp.titleTextAttributes = attributes;
    } else {
        self.navigationController.navigationBar.titleTextAttributes = attributes;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController ht_barTintColor:kNavBGColor andIsTranslucent:NO];
}

- (void)ht_addDefaultLeftItem {
    UIImage *image = [[UIImage imageNamed:@"icon_wdback"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    button.tintColor = [UIColor colorWithHexString:@"#FFFFFF"];
    button.frame = CGRectMake(0, 0, 40, 40);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button addTarget:self action:@selector(ht_leftItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *var_leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = var_leftItem;
}

- (void)ht_leftItemClicked:(UIButton *)sender {
    
    if ([self ht_slideBackDisable] && sender == nil) {
        return;
    }
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (BOOL)ht_slideBackDisable {
    return NO;
}

- (void)ht_addRightBtnWithTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    button.frame = CGRectMake(0, 0, 45, 30);
    [button addTarget:self action:@selector(ht_rightItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *var_rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = var_rightItem;
}

- (void)ht_addRightBtnWithImage:(id)named {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if ( named && [named isKindOfClass:[UIImage class]] ) {
        [button setImage:[UIImage imageNamed:named] forState:UIControlStateNormal];
    } else if ([named isKindOfClass:[NSURL class]]) {
        [button sd_setImageWithURL:named forState:UIControlStateNormal];
    }
    button.frame = CGRectMake(0, 0, 30, 30);
    [button addTarget:self action:@selector(ht_rightItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *var_rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = var_rightItem;
}

- (void)ht_rightItemClicked:(UIButton *)sender {
    
}

//Interface的方向是否会跟随设备方向自动旋转，如果返回NO,后两个方法不会再调用
- (BOOL)shouldAutorotate {
   return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
