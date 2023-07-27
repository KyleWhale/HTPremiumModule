//
//  HTAttributedManager.m
//  Hucolla
//
//  Created by mac on 2020/12/28.
//  Copyright © 2020 Jerry. All rights reserved.
//

#import "HTAttributedManager.h"

@implementation HTAttributedManager

- (instancetype)initWithText:(NSString * __nullable)contentText andFont:(UIFont * __nullable)font andForegroundColor:(UIColor * __nullable)foregroundColor{
    self = [super init];
    if ( self ) {
        self.contentText = contentText;
        self.font = font;
        self.foregroundColor = foregroundColor;
    }
    return self;
}

- (NSAttributedString *)contentAttributed{
    if (self.contentText) {
        return [[NSAttributedString alloc] initWithString:self.contentText attributes:[self ht_attributedDictionary]];
    }
    return nil;
}

- (NSMutableAttributedString *)contentMutableAttributed{
    if ( _contentMutableAttributed == nil && self.contentText) {
        _contentMutableAttributed = [[NSMutableAttributedString alloc] initWithString:self.contentText attributes:[self ht_attributedDictionary]];
    }
    return _contentMutableAttributed;
}

- (void)ht_setAttributedModel:(HTAttributedManager *)model andRang:(NSRange)var_rang {
    [self.contentMutableAttributed setAttributes:[model ht_attributedDictionary] range:var_rang];
}

- (void)ht_addLineSpace:(CGFloat)lineSpace andFirstLineHeadIndent:(CGFloat)var_fIndent andAlignment:(NSTextAlignment)alignment {
    if ( self.paragraphStyle == nil ) {
        self.paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        //self.paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    
    if ( lineSpace != 0 ) {
        self.paragraphStyle.lineSpacing = lineSpace;
    }
    
    if ( var_fIndent != 0 ) {
        self.paragraphStyle.firstLineHeadIndent = var_fIndent;
    }
    
    if ( alignment != NSTextAlignmentLeft ) {
        self.paragraphStyle.alignment = alignment;
    }
}

- (NSDictionary <NSAttributedStringDocumentReadingOptionKey, id> *)ht_attributedDictionary{
    NSMutableDictionary *var_multDict = [NSMutableDictionary dictionary];
    if ( self.font ) {
        [var_multDict setObject:self.font forKey:NSFontAttributeName];
    }
    if ( self.paragraphStyle ) {
        [var_multDict setObject:self.paragraphStyle forKey:NSParagraphStyleAttributeName];
    }
    if ( self.foregroundColor ) {
        [var_multDict setObject:self.foregroundColor forKey:NSForegroundColorAttributeName];
    }
    if ( self.backgroundColor ) {
        [var_multDict setObject:self.backgroundColor forKey:NSBackgroundColorAttributeName];
    }
    if ( self.ligature ) {
        [var_multDict setObject:self.ligature forKey:NSLigatureAttributeName];
    }
    if ( self.kern ) {
        [var_multDict setObject:self.kern forKey:NSKernAttributeName];
    }
    if ( self.strikethrough ) {
        [var_multDict setObject:self.strikethrough forKey:NSStrikethroughStyleAttributeName];
    }
    if ( self.strikethroughColor ) {
        [var_multDict setObject:self.strikethroughColor forKey:NSStrikethroughColorAttributeName];
    }
    if ( self.underline ) {
        [var_multDict setObject:self.underline forKey:NSUnderlineStyleAttributeName];
    }
    if ( self.underlineColor ) {
        [var_multDict setObject:self.underlineColor forKey:NSUnderlineColorAttributeName];
    }
    if ( self.strokeColor ) {
        [var_multDict setObject:self.strokeColor forKey:NSStrokeColorAttributeName];
    }
    if ( self.strokeWidth ) {
        [var_multDict setObject:self.strokeWidth forKey:NSStrokeWidthAttributeName];
    }
    if ( self.shadow ) {
        [var_multDict setObject:self.shadow forKey:NSShadowAttributeName];
    }
    if ( self.textEffect ) {
        [var_multDict setObject:self.textEffect forKey:NSTextEffectAttributeName];
    }
    if ( self.attachment ) {
        [var_multDict setObject:self.attachment forKey:NSAttachmentAttributeName];
    }
    if ( self.link ) {
        [var_multDict setObject:self.link forKey:NSLinkAttributeName];
    }
    if ( self.baseline ) {
        [var_multDict setObject:self.baseline forKey:NSBaselineOffsetAttributeName];
    }
    if ( self.underlineColor ) {
        [var_multDict setObject:self.underlineColor forKey:NSUnderlineColorAttributeName];
    }
    if ( self.obliqueness ) {
        [var_multDict setObject:self.obliqueness forKey:NSObliquenessAttributeName];
    }
    if ( self.expansion ) {
        [var_multDict setObject:self.expansion forKey:NSExpansionAttributeName];
    }
    if ( self.writingDirection ) {
        [var_multDict setObject:self.writingDirection forKey:NSWritingDirectionAttributeName];
    }
    if ( self.verticalGlyph ) {
        [var_multDict setObject:self.verticalGlyph forKey:NSVerticalGlyphFormAttributeName];
    }
    return var_multDict;
}
@end
