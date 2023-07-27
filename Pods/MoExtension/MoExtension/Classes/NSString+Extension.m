
#import "NSString+Extension.h"

@implementation NSString (Extension)

- (NSDate *)dateWithFormat:(NSString *)format {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter dateFromString:self];
}

@end
