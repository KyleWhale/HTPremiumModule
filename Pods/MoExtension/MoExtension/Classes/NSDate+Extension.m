
#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (NSString *)stringWithFormat:(NSString *)format {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setLocale:[NSLocale currentLocale]];
    return [formatter stringFromDate:self];
}

@end
