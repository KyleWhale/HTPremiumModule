
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (Extension)

+ (CGFloat)safeTop;

+ (CGFloat)safeBottom;

+ (CGFloat)statusBarHeight;

+ (CGFloat)tabbarHeight;

@end

NS_ASSUME_NONNULL_END
