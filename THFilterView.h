//
//  THFilterView.h
//  toHomeMerchant
//
//  Created by 木木木 on 15/8/20.
//  Copyright (c) 2015年 sdj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^KeyValueBlock)(NSString *key, NSString *value);

@interface THFilterView : UIView

@property (copy, nonatomic) KeyValueBlock keyValueBlock;
@property (strong, nonatomic) NSArray *keys;

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource;

@end
