//
//  HTPremiumViewVipCell.m
//  Hucolla
//
//  Created by mac on 2022/9/16.
//

#import "HTPremiumViewVipCell.h"
#import "HTPremiumVipCellManager.h"

@interface HTPremiumViewVipCell()<UICollectionViewDelegate, UICollectionViewDataSource, UITextViewDelegate>

@property (nonatomic, strong) UICollectionView      * collectionView;
@property (nonatomic, strong) NSArray               * dataArray;
@property (nonatomic, strong) UITextView            * textView;

@end

@implementation HTPremiumViewVipCell

- (void)ht_addCellSubViews {
    
    CGFloat scale = [HTPremiumVipCellManager lgjeropj_getScale];
    
    self.collectionView = [HTPremiumVipCellManager lgjeropj_collectionView:self];
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(17);
        make.height.equalTo(@(210*scale));
    }];
    
    self.textView = [HTPremiumVipCellManager lgjeropj_textView:self];
    [self.contentView addSubview: self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).inset(16);
        make.top.equalTo(self.collectionView.mas_bottom).offset(24);
        make.height.equalTo(@(18*scale));
    }];
        
    UIView *line = [HTPremiumVipCellManager lgjeropj_line];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.contentView);
        make.height.equalTo(@1);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSDictionary *dict = self.dataArray[indexPath.row];
    HTPremiumItemVipCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HTPremiumItemVipCell class]) forIndexPath:indexPath];
    [cell ht_updateCellWithData:dict];
    cell.vipBlock = ^(id data) {
        if ( self.cellBlock ) {
            self.cellBlock(data);
        }
    };
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)ht_updateCellWithData:(id)data {
    self.dataArray = (NSArray *)data;
    [self.collectionView reloadData];
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    NSLog(@"%@",URL.absoluteString);
    if( self.vipBlock ) {
        self.vipBlock();
    }
    return YES;
}

@end
