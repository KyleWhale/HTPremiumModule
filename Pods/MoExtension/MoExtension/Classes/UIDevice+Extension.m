
#import "UIDevice+Extension.h"

@implementation UIDevice (Extension)

+ (CGFloat)safeTop
{
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *scene = [set anyObject];
        UIWindow *window = scene.windows.firstObject;
        return window.safeAreaInsets.top;
    } else if ( @available(iOS 11.0, *) ) {
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        return window.safeAreaInsets.top;
    }
    return 0;
}

+ (CGFloat)safeBottom
{
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *scene = [set anyObject];
        UIWindow *window = scene.windows.firstObject;
        return window.safeAreaInsets.bottom;
    } else if ( @available(iOS 11.0, *) ) {
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        return window.safeAreaInsets.bottom;
    }
    return 0;
}

+ (CGFloat)statusBarHeight
{
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *scene = [set anyObject];
        UIStatusBarManager *manager = scene.statusBarManager;
        CGRect statusFrame = manager.statusBarFrame;
        return CGRectGetHeight(statusFrame);
    } else {
        CGRect statusFrame = [UIApplication sharedApplication].statusBarFrame;
        return CGRectGetHeight(statusFrame);
    }
}

+ (CGFloat)tabbarHeight
{
    return 49.0+[self safeBottom];
}

@end
