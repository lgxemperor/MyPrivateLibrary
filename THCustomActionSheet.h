//
//  YXCustomActionSheet.h
//  YXCustomActionSheet
//
//  Created by Houhua Yan on 16/7/14.
//  Copyright © 2016年 YanHouhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THActionSheetButton.h"

@protocol THCustomActionSheetDelegate <NSObject>

@optional

- (void) customActionSheetButtonClick:(THActionSheetButton *) btn;

@end


@interface THCustomActionSheet : UIView

/**展示*/
- (void)showInView:(UIView *)superView contentArray:(NSArray *)contentArray;

@property (nonatomic, weak) id<THCustomActionSheetDelegate> delegate;

@end
