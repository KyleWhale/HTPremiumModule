
#import "UIColor+Extension.h"

@implementation UIColor (Extension)

+ (instancetype)gradient:(CGSize)size direction:(int)direction start:(UIColor *)startColor end:(UIColor *)endColor {
    
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        return nil;
    }
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    gradientLayer.startPoint = CGPointZero;
    CGPoint endPoint = CGPointZero;
    switch (direction) {
        case 0:
            endPoint = CGPointMake(1.0, 0.0);
            break;
        case 1:
            endPoint = CGPointMake(0.0, 1.0);
            break;
        case 2:
            endPoint = CGPointMake(1.0, 1.0);
            break;
        case 3:
            endPoint = CGPointMake(1.0, 0.0);
            break;
        default:
            break;
    }
    gradientLayer.endPoint = endPoint;
    gradientLayer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    UIGraphicsBeginImageContext(size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [UIColor colorWithPatternImage:image];
}

+ (UIColor *)colorWithHexString:(NSString *)color {
    
    color = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([color length] < 6) {
        return [UIColor clearColor];
    }
    if ([color hasPrefix:@"0X"]) {
        color = [color substringFromIndex:2];
    }
    if ([color hasPrefix:@"#"]) {
        color = [color substringFromIndex:1];
    }
    if ([color length] != 6) {
        return [UIColor clearColor];
    }
    UIColor *result = nil;
    unsigned int code = 0;
    unsigned char red, green, blue;
    if (color != nil) {
        NSScanner *scanner = [NSScanner scannerWithString:color];
        (void)[scanner scanHexInt:&code];
    }
    red = (unsigned char) (code >> 16);
    green = (unsigned char) (code >> 8);
    blue = (unsigned char) (code);
    result = [UIColor colorWithRed: (float)red/0xff green: (float)green/0xff blue: (float)blue/0xff alpha:1];
    return result;
}

- (UIImage *)imageWithSize:(CGSize)size {
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.CGColor);
    CGContextFillRect(context, rect);
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
