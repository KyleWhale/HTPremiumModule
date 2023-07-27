//
//  HTKitCreate.m
//  Hucolla
//
//  Created by mac on 2020/10/10.
//  Copyright © 2020 Jerry. All rights reserved.
//

#import "HTKitCreate.h"
#import "SDWebImage.h"
#import "LKFPrivateFunction.h"
#import "HTCommonMacro.h"

@implementation HTKitCreate

+ (UITableView *)ht_tableViewWithDelegate:( __nullable id)delegate style:(UITableViewStyle)style {
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectZero style:style];
    table.backgroundColor = [UIColor clearColor];
    table.delegate = delegate;
    table.dataSource = delegate;
    table.showsVerticalScrollIndicator = NO;
    table.showsHorizontalScrollIndicator = NO;
    table.tableHeaderView = [UIView new];
    table.tableFooterView = [UIView new];
    
    if (@available(iOS 11.0, *)) {
        table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        
    }
    if (@available(iOS 13.0, *)) {
        table.automaticallyAdjustsScrollIndicatorInsets = NO;
    } else {
        
    }
    
    if (@available(iOS 15.0, *)) {
        table.sectionHeaderTopPadding = 0;
    } else {
        
    }
    
    return table;
}

+ (UIScrollView *)ht_scrollViewWithDelegate:( __nullable id)delegate {
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectZero];
    scroll.delegate = delegate;
    scroll.showsVerticalScrollIndicator = NO;
    scroll.showsHorizontalScrollIndicator = NO;
    if (@available(iOS 11.0, *)) {
        scroll.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        
    }
    if (@available(iOS 13.0, *)) {
        scroll.automaticallyAdjustsScrollIndicatorInsets = NO;
    } else {
        
    }
    return scroll;
}

+ (UICollectionView *)ht_collectionViewWithDelegate:( __nullable id)delegate andIsVertical:(BOOL)isVertical andLineSpacing:(CGFloat)lineS andColumnSpacing:(CGFloat)columnS andItemSize:(CGSize)size andIsEstimated:(BOOL)isEstimated andSectionInset:(UIEdgeInsets)inset
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    // 行间距
    layout.minimumLineSpacing = lineS;
    // 列间距
    layout.minimumInteritemSpacing = columnS;
    
    if ( CGSizeEqualToSize(size, CGSizeZero) == NO ) {
        if ( isEstimated ) {
            // 每一块预设大小
            layout.estimatedItemSize = size;
        }else{
            // 每一块的大小
            layout.itemSize = size;
        }
    }
    
    // 每一块的内容和区的四边的距离
    layout.sectionInset = inset;
    // 设置滑动方向
    layout.scrollDirection = isVertical?UICollectionViewScrollDirectionVertical:UICollectionViewScrollDirectionHorizontal;

    return [self ht_collectionViewWithDelegate:delegate andLayout:layout];
}

+ (UICollectionView *)ht_collectionViewWithDelegate:( __nullable id)delegate andLayout:(UICollectionViewFlowLayout *)layout {
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame: CGRectZero collectionViewLayout: layout];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.delegate = delegate;
    collectionView.dataSource = delegate;
    collectionView.backgroundColor = [UIColor clearColor];
    
    if (@available(iOS 11.0, *)) {
        collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        
    }
    if (@available(iOS 13.0, *)) {
        collectionView.automaticallyAdjustsScrollIndicatorInsets = NO;
    } else {
        
    }
    
    return collectionView;
}

+ (UITextField *)ht_textFieldWithDelegate:( __nullable id)delegate andFont:(UIFont * __nullable)font andTextColor:(UIColor * __nullable)textColor andPlaceholder:(NSString * __nullable)placeholder andHolderColor:(UIColor * __nullable)var_holderColor
{
    UITextField *textField = [[UITextField alloc] init];
    textField.delegate = delegate;
    textField.font = font;
    textField.textColor = textColor;
    textField.placeholder = placeholder;
    if ( placeholder && var_holderColor ) {
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:placeholder attributes:
        @{NSForegroundColorAttributeName:var_holderColor}];
        
        textField.attributedPlaceholder = attrString;
    }
    
    return textField;
}

+ (UITextView *)ht_textViewWithDelegate:( __nullable id)delegate andFont:(UIFont * __nullable)font andTextColor:(UIColor * __nullable)textColor andPlaceholder:(NSString * __nullable)placeholder andHolderColor:(UIColor * __nullable)var_holderColor
{
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
    textView.delegate = delegate;
    textView.font =  font;
    return textView;
}

+ (UILabel *)ht_labelWithText:(NSString * __nullable)text andFont:(UIFont * __nullable)font andTextColor:(UIColor * __nullable)textColor andAligment:(NSTextAlignment)aligment andNumberOfLines:(NSUInteger)lines
{
    UILabel *label = [UILabel new];
    label.text = text;
    label.font = font;
    label.textColor = textColor;
    label.textAlignment = aligment;
    label.numberOfLines = lines;
    return label;
}

+ (UIButton *)ht_buttonWithImage:(id __nullable)image andSelectImage:(id __nullable)selectImage {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if ( image && [image isKindOfClass:[UIImage class]] ) {
        [button setImage:image forState:UIControlStateNormal];
    } else if ([image isKindOfClass:[NSURL class]]) {
        [button sd_setImageWithURL:image forState:UIControlStateNormal];
    }
    if ( selectImage && [selectImage isKindOfClass:[UIImage class]] ) {
        [button setImage:selectImage forState:UIControlStateSelected];
    }  else if ([selectImage isKindOfClass:[NSURL class]]) {
        [button sd_setImageWithURL:selectImage forState:UIControlStateSelected];
    }
    return button;
}

+ (UIButton *)ht_buttonWithImage:(id __nullable)image andTitle:(NSString * __nullable)title andFont:(UIFont * __nullable)font andTextColor:(UIColor * __nullable)textColor andState:(UIControlState)state
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if ( image && [image isKindOfClass:[UIImage class]] ) {
        [button setImage:image forState:state];
    } else if ([image isKindOfClass:[NSURL class]]) {
        [button sd_setImageWithURL:image forState:state];
    }
    if ( title && title.length > 0 ) {
        [button setTitle:title forState:state];
    }
    if ( font ) {
        button.titleLabel.font = font;
    }
    if ( textColor ) {
        [button setTitleColor:textColor forState:state];
    }
    return button;
}

+ (NSMutableArray *)ht_buttonArrayWithTitles:(NSArray * __nullable)titles andImages:(NSArray * __nullable)images andFont:(UIFont * __nullable)font andTextColor:(UIColor * __nullable)textColor andSelectTextColor:(UIColor * __nullable)var_textColor andTarget:(id)target andAction:(SEL)action andSuperView:(UIView *)superView
{
    NSMutableArray *var_buttonArray = [NSMutableArray array];
    if ( titles && titles.count > 0 ) {
        for ( int i=0; i < titles.count; i ++ )
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:titles[i] forState:UIControlStateNormal];
            button.tag = 100+i;
            if ( images.count > i ) {
                NSString *imageName = [images objectAtIndex:i];
                if ( imageName ) {
                    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
                }
            }
            if ( font ) {
                button.titleLabel.font = font;
            }
            if ( textColor ) {
                [button setTitleColor:textColor forState:UIControlStateNormal];
            }
            if ( var_textColor ) {
                [button setTitleColor:var_textColor forState:UIControlStateSelected];
            }
            [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
            [superView addSubview:button];
            [var_buttonArray addObject:button];
        }
    }
    if ( images && images.count > 0 && (!titles || titles.count == 0 ) ) {
        for ( int i=0; i < images.count; i ++ )
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
            button.tag = 100+i;
            [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
            [superView addSubview:button];
            [var_buttonArray addObject:button];
        }
    }
    
    return var_buttonArray;
}

+ (UIAlertController *)ht_alertControllerWithTitle:(NSString * __nullable)title message:(NSString * __nullable)message andButtonTitles:(NSArray * __nullable)buttonArray handle:(void (^ __nullable)(UIAlertAction *action))handler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if ( buttonArray == nil || buttonArray.count == 0 ) {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:AsciiString(@"Cancel") style:UIAlertActionStyleCancel handler:handler];
        [alert addAction:cancel];
    }
    else
    {
        for ( int i=0; i < buttonArray.count; i ++ ) {
            NSString *buttonTitle = buttonArray[i];
            if ( [buttonTitle isEqualToString:AsciiString(@"Cancel")] ) {
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleCancel handler:handler];
                [alert addAction:cancel];
            }else if ( [buttonTitle isEqualToString:@"OK"] ) {
                UIAlertAction *confirm = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDestructive handler:handler];
                [alert addAction:confirm];
            }
            else
            {
                UIAlertAction *other = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:handler];
                [alert addAction:other];
            }
        }
    }
    
    return alert;
}


@end
