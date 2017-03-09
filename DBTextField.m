//
//  DBTextField.m
//  toHomeMerchant
//
//  Created by emperor on 16/4/16.
//  Copyright © 2016年 sdj. All rights reserved.
//

#import "DBTextField.h"

@implementation DBTextField

-(void)deleteBackward{
    [super deleteBackward];
    if (_keyInputDelegate &&[_keyInputDelegate respondsToSelector:@selector(textFieldDidDeleteBackward:)]) {
        [_keyInputDelegate textFieldDidDeleteBackward:self];
    }
}

@end
