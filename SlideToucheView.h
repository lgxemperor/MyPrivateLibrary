//
//  SlideToucheView.h
//  toHomeMerchant
//
//  Created by emperor on 16/4/22.
//  Copyright © 2016年 sdj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideToucheView : UIControl{
    
}

@property(nonatomic,retain)UIColor *normalColor;
@property(nonatomic,retain)UIColor *selectedColor;
@property(nonatomic,weak)IBOutlet UILabel *lable;
@property(nonatomic,weak)IBOutlet UIImageView *lineView;
@property(nonatomic,weak)IBOutlet UILabel *roundDotLable;
@end
