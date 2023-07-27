
#import "UIButton+Extension.h"

@implementation UIButton (Extension)

- (void)setPosition:(int)style interval:(CGFloat)interval
{
    CGFloat imageWith = self.imageView.intrinsicContentSize.width;
    CGFloat imageHeight = self.imageView.intrinsicContentSize.height;
    CGFloat titleWidth = self.titleLabel.intrinsicContentSize.width;
    CGFloat titleHeight = self.titleLabel.intrinsicContentSize.height;
    
    UIEdgeInsets imageInsets = UIEdgeInsetsZero;
    UIEdgeInsets titleInsets = UIEdgeInsetsZero;
    
    switch (style) {
        case 0:
        {
            imageInsets = UIEdgeInsetsMake(-titleHeight-interval/2.0, 0, 0, -titleWidth);
            titleInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-interval/2.0, 0);
        }
            break;
        case 1:
        {
            imageInsets = UIEdgeInsetsMake(0, -interval/2.0, 0, interval/2.0);
            titleInsets = UIEdgeInsetsMake(0, interval/2.0, 0, -interval/2.0);
        }
            break;
        case 2:
        {
            imageInsets = UIEdgeInsetsMake(0, 0, -titleHeight-interval/2.0, -titleWidth);
            titleInsets = UIEdgeInsetsMake(-imageHeight-interval/2.0, -imageWith, 0, 0);
        }
            break;
        case 3:
        {
            imageInsets = UIEdgeInsetsMake(0, titleWidth+interval/2.0, 0, -titleWidth-interval/2.0);
            titleInsets = UIEdgeInsetsMake(0, -imageWith-interval/2.0, 0, imageWith+interval/2.0);
        }
            break;
        default:
            break;
    }
    self.titleEdgeInsets = titleInsets;
    self.imageEdgeInsets = UIEdgeInsetsMake(imageInsets.top, imageInsets.left, imageInsets.bottom, imageInsets.right);
}

@end
