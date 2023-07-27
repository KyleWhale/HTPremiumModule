//
//  HTAttributedManager.h
//  Hucolla
//
//  Created by mac on 2020/12/28.
//  Copyright © 2020 Jerry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTAttributedManager : NSObject

@property (nonatomic,strong) UIFont *font;
@property (nonatomic,strong) NSMutableParagraphStyle *paragraphStyle;
@property (nonatomic,strong) UIColor *foregroundColor;
@property (nonatomic,strong) UIColor *backgroundColor;
@property (nonatomic,strong) NSNumber *ligature;
@property (nonatomic,strong) NSNumber *kern;
@property (nonatomic,strong) NSNumber *tracking;
@property (nonatomic,strong) NSNumber *strikethrough;
@property (nonatomic,strong) NSNumber *underline;
@property (nonatomic,strong) UIColor *strokeColor;
@property (nonatomic,strong) NSNumber *strokeWidth;
@property (nonatomic,strong) NSShadow *shadow;
@property (nonatomic,strong) NSString *textEffect;
@property (nonatomic,strong) NSTextAttachment *attachment;
@property (nonatomic,strong) NSString *link;
@property (nonatomic,strong) NSNumber *baseline;
@property (nonatomic,strong) UIColor *underlineColor;
@property (nonatomic,strong) UIColor *strikethroughColor;
@property (nonatomic,strong) NSNumber *obliqueness;
@property (nonatomic,strong) NSNumber *expansion;
@property (nonatomic,strong) NSNumber *writingDirection;
@property (nonatomic,strong) NSNumber *verticalGlyph;

@property (nonatomic,strong) NSString *contentText;
@property (nonatomic,strong) NSAttributedString *contentAttributed;
@property (nonatomic,strong) NSMutableAttributedString *contentMutableAttributed;

// 富文本属性对象
// @contentText 正常文字
// @font 富文本字体
// @foregroundColor 富文本文字颜色
- (instancetype)initWithText:(NSString * __nullable)contentText andFont:(UIFont * __nullable)font andForegroundColor:(UIColor * __nullable)foregroundColor;

// 添加常用段落样式
// @lineSpace 行间距
// @fIndent 首行缩进
// @alignment 文字位置
- (void)ht_addLineSpace:(CGFloat)lineSpace andFirstLineHeadIndent:(CGFloat)var_fIndent andAlignment:(NSTextAlignment)alignment;
// 设置某区间富文本属性
// @model 某区间富文本对象
// @rang 区间

- (void)ht_setAttributedModel:(HTAttributedManager *)model andRang:(NSRange)var_rang;
// 富文本对象转字典
- (NSDictionary <NSAttributedStringDocumentReadingOptionKey, id> *)ht_attributedDictionary;

@end

NS_ASSUME_NONNULL_END
