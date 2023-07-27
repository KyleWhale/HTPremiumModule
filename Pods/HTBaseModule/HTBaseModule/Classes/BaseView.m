//
//  BaseView.m
//  Hucolla
//
//  Created by mac on 2022/9/13.
//

#import "BaseView.h"

@implementation BaseView

- (instancetype)init {
    self = [super init];
    if ( self ) {
        [self ht_addViewSubViews];
    }
    return self;
}

- (void)ht_addViewSubViews {
    
}

- (void)ht_updateViewWithData:(id)data {
    
}


@end
