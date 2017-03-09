//
//  SlideToolBarView.h
//  toHomeMerchant
//
//  Created by emperor on 16/4/22.
//  Copyright © 2016年 sdj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPrivateLibrary.h"
@class SlideToolBarView;
@protocol SlideToolBarViewDelegate <NSObject>
-(void)slideToolBarView:(SlideToolBarView *)slideToolBarView SelectedAtIndex:(NSInteger)sIndex;
@end
@interface SlideToolBarView : UIView
@property(nonatomic,assign)id<SlideToolBarViewDelegate>delegate;
-(id)initWithFrame:(CGRect)frame  OffsetX:(CGFloat)offsetX;
-(void)setTitles:(NSArray *)titles;
-(void)setSelectedIndex:(NSInteger)sIndex;
-(NSInteger)selectedIndex;
@end

@interface SlideToolBarView ()<UIScrollViewDelegate>{
    NSInteger _selectedContentIndex;
}
@property(nonatomic,retain)UIScrollView *scrollView;
@property(nonatomic,assign)CGFloat oX;
@property(nonatomic,assign)NSInteger count;
-(void)setDotData:(NSArray *)data;
@end
