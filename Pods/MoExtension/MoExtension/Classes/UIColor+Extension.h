
#import <UIKit/UIKit.h>

@interface UIColor (Extension)

+ (UIColor *)gradient:(CGSize)size direction:(int)direction start:(UIColor *)startColor end:(UIColor *)endColor;

+ (UIColor *)colorWithHexString:(NSString *)color;

- (UIImage *)imageWithSize:(CGSize)size;

@end
