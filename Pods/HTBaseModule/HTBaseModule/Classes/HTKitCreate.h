//
//  HTKitCreate.h
//  Hucolla
//
//  Created by mac on 2020/10/10.
//  Copyright © 2020 Jerry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTKitCreate : NSObject

+ (UITableView *)ht_tableViewWithDelegate:( __nullable id)delegate style:(UITableViewStyle)style;

+ (UIScrollView *)ht_scrollViewWithDelegate:( __nullable id)delegate;

+ (UICollectionView *)ht_collectionViewWithDelegate:( __nullable id)delegate andIsVertical:(BOOL)isVertical andLineSpacing:(CGFloat)lineS andColumnSpacing:(CGFloat)columnS andItemSize:(CGSize)size andIsEstimated:(BOOL)isEstimated andSectionInset:(UIEdgeInsets)inset;

+ (UICollectionView *)ht_collectionViewWithDelegate:( __nullable id)delegate andLayout:(UICollectionViewFlowLayout *)layout;

+ (UITextField *)ht_textFieldWithDelegate:( __nullable id)delegate andFont:(UIFont * __nullable)font andTextColor:(UIColor * __nullable)textColor andPlaceholder:(NSString * __nullable)placeholder andHolderColor:(UIColor * __nullable)var_holderColor;

+ (UITextView *)ht_textViewWithDelegate:( __nullable id)delegate andFont:(UIFont * __nullable)font andTextColor:(UIColor * __nullable)textColor andPlaceholder:(NSString * __nullable)placeholder andHolderColor:(UIColor * __nullable)var_holderColor;

+ (UILabel *)ht_labelWithText:(NSString * __nullable)text andFont:(UIFont * __nullable)font andTextColor:(UIColor * __nullable)textColor andAligment:(NSTextAlignment)aligment andNumberOfLines:(NSUInteger)lines;

+ (UIButton *)ht_buttonWithImage:(id __nullable)image andSelectImage:(id __nullable)selectImage;

+ (UIButton *)ht_buttonWithImage:(id __nullable)image andTitle:(NSString * __nullable)title andFont:(UIFont * __nullable)font andTextColor:(UIColor * __nullable)textColor andState:(UIControlState)state;

+ (NSMutableArray *)ht_buttonArrayWithTitles:(NSArray * __nullable)titles andImages:(NSArray * __nullable)images andFont:(UIFont * __nullable)font andTextColor:(UIColor * __nullable)textColor andSelectTextColor:(UIColor * __nullable)var_textColor andTarget:(id)target andAction:(SEL)action andSuperView:(UIView *)superView;

+ (UIAlertController *)ht_alertControllerWithTitle:(NSString * __nullable)title message:(NSString * __nullable)message andButtonTitles:(NSArray * __nullable)buttonArray handle:(void (^ __nullable)(UIAlertAction *action))handler;

@end

NS_ASSUME_NONNULL_END
