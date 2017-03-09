//
//  SlideToucheView.m
//  toHomeMerchant
//
//  Created by emperor on 16/4/22.
//  Copyright © 2016年 sdj. All rights reserved.
//

#import "SlideToucheView.h"



@implementation SlideToucheView
-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        [self addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}
-(void)removeFromSuperview{
    [self removeObserver:self forKeyPath:@"selected"];
    [super removeFromSuperview];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (self.selected) {
        _lable.textColor=_selectedColor;
        _lineView.backgroundColor=_selectedColor;
    }else{
        _lable.textColor=_normalColor;
        _lineView.backgroundColor=[UIColor clearColor];
    }
}
@end
