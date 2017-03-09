//
//  SlideToolBarView.m
//  toHomeMerchant
//
//  Created by emperor on 16/4/22.
//  Copyright © 2016年 sdj. All rights reserved.
//

#import "SlideToolBarView.h"
#import "SlideToucheView.h"
#define SLIDETOUCHVIEWTAG  100
@implementation SlideToolBarView
-(id)initWithFrame:(CGRect)frame OffsetX:(CGFloat)offsetX{
    self=[super initWithFrame:frame];
    if (self) {
        _oX=offsetX;
        UIScrollView *sView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-1)];
        sView.backgroundColor=[UIColor clearColor];
        sView.delegate=self;
        sView.pagingEnabled=YES;
        sView.showsHorizontalScrollIndicator=NO;
        sView.showsVerticalScrollIndicator=NO;
        [self addSubview:sView];
        _scrollView=sView;
        UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-1,self.frame.size.width, 1)];
        lineView.backgroundColor=RGBACOLOR(234, 234, 234, 1.0);
    }
    return self;
}
-(void)setTitles:(NSArray *)titles{
    _count=titles.count;
    for (int i=0; i<titles.count; i++) {
        SlideToucheView *touchView=[[SlideToucheView alloc] initWithFrame:CGRectMake(i*_oX, 0, _oX, self.scrollView.frame.size.height)];
        [touchView addTarget:self action:@selector(selectedSlideTouchView:) forControlEvents:UIControlEventTouchDown];
        touchView.tag=SLIDETOUCHVIEWTAG+i;
        touchView.selectedColor=[UIColor colorWithRed:0.866 green:0.031 blue:0.127 alpha:1.000];
        touchView.normalColor=UIColorFromRGB(0x807f7f);
        NSString *titleTxt=titles[i];
        CGSize rmSize = CGSizeMake(MAXFLOAT,touchView.frame.size.height-2);  //上限
        UIFont *font=[UIFont systemFontOfSize:16];
        
        CGSize rSize = [titleTxt boundingRectWithSize:rmSize options: NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(touchView.frame.size.width/2-rSize.width/2, 0, rSize.width, touchView.frame.size.height)];
        titleLabel.text=titles[i];
        titleLabel.numberOfLines=0;
        titleLabel.textColor=[UIColor blackColor];
        titleLabel.textAlignment=NSTextAlignmentCenter;
        titleLabel.font=font;
        [touchView addSubview:titleLabel];
        
        UILabel *dotLabel=[[UILabel alloc] initWithFrame:CGRectMake(titleLabel.right-2, titleLabel.centerY-20, 16, 16)];
        dotLabel.text=@"12";
        dotLabel.backgroundColor=[UIColor colorWithRed:0.866 green:0.031 blue:0.127 alpha:1.000];
        dotLabel.layer.cornerRadius=8;
        dotLabel.layer.shadowRadius=8;
        dotLabel.layer.masksToBounds=YES;
        dotLabel.numberOfLines=0;
        dotLabel.textColor=[UIColor whiteColor];
        dotLabel.textAlignment=NSTextAlignmentCenter;
        dotLabel.font=[UIFont boldSystemFontOfSize:12];
        dotLabel.hidden=YES;
        [touchView addSubview:dotLabel];
        touchView.roundDotLable=dotLabel;
        
        touchView.lable=titleLabel;
        [self.scrollView addSubview:touchView];
    }
    self.scrollView.contentSize=CGSizeMake(_oX*titles.count, self.scrollView.frame.size.height);
    if (self.scrollView.contentSize.width<=self.frame.size.width) {
        self.scrollView.scrollEnabled=NO;
    }
    if (titles.count>0) {
        SlideToucheView *touchView=(SlideToucheView *)[_scrollView viewWithTag:0+SLIDETOUCHVIEWTAG];
        UIImageView *lineView=[[UIImageView alloc] initWithFrame:CGRectMake(touchView.frame.origin.x,touchView.frame.size.height-3, touchView.frame.size.width,3)];
        lineView.backgroundColor=[UIColor colorWithRed:0.866 green:0.031 blue:0.127 alpha:1.000];
        lineView.tag=SLIDETOUCHVIEWTAG*SLIDETOUCHVIEWTAG;
        [_scrollView addSubview:lineView];
    }
}
-(void)setSelectedIndex:(NSInteger)sIndex{
    _selectedContentIndex=sIndex;
    SlideToucheView *touchView=(SlideToucheView *)[_scrollView viewWithTag:sIndex+SLIDETOUCHVIEWTAG];
    touchView.selected=YES;
    for (int i=0; i<_count; i++) {
        if (i!=sIndex) {
            SlideToucheView *nTouchView=(SlideToucheView *)[_scrollView viewWithTag:i+SLIDETOUCHVIEWTAG];
            nTouchView.selected=NO;
        }
    }
    if ([self.delegate respondsToSelector:@selector(slideToolBarView:SelectedAtIndex:)]) {
        [self.delegate slideToolBarView:self SelectedAtIndex:sIndex];
    }
//    [_scrollView scr:CGRectMake(_oX * sIndex, 0.0f, _oX, self.scrollView.frame.size.height) animated:YES];
    UIImageView *lineView=(UIImageView*)[self.scrollView viewWithTag:SLIDETOUCHVIEWTAG*SLIDETOUCHVIEWTAG];
    [UIView animateWithDuration:0.35 animations:^{
        lineView.frame=CGRectMake(touchView.frame.origin.x, lineView.frame.origin.y, touchView.frame.size.width, lineView.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}
-(NSInteger)selectedIndex{
    return  _selectedContentIndex;
}
-(void)selectedSlideTouchView:(id)sender{
    SlideToucheView *touchView=(SlideToucheView *)sender;
    NSInteger scrollToPageIndex=touchView.tag-SLIDETOUCHVIEWTAG;
    [self setSelectedIndex:scrollToPageIndex];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

}
-(void)setDotData:(NSArray *)data{
    for (int i=0; i<data.count; i++) {
        SlideToucheView *nTouchView=(SlideToucheView *)[_scrollView viewWithTag:i+SLIDETOUCHVIEWTAG];
        int dotNum=[[data objectAtIndex:i] intValue];
        if ([nTouchView.lable.text isEqualToString:@"全部"]) {
            nTouchView.roundDotLable.hidden=YES;
            nTouchView.roundDotLable.text=@"";
        }else{
            if (dotNum>0) {
                nTouchView.roundDotLable.hidden=NO;
                NSString *roundtitle=[NSString stringWithFormat:@"%d",[[data objectAtIndex:i] intValue]];
                CGSize rSize = [roundtitle boundingRectWithSize:nTouchView.roundDotLable.size options: NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:nTouchView.roundDotLable.font} context:nil].size;
                rSize.width=rSize.width+6;
                if (rSize.width<16) {
                    rSize.width=16;
                }
                if (rSize.width>nTouchView.width-nTouchView.lable.right) {
                    nTouchView.roundDotLable.width=rSize.width;
                    nTouchView.roundDotLable.right=nTouchView.width;
                }else{
                    nTouchView.roundDotLable.width=rSize.width;
                    nTouchView.roundDotLable.left=nTouchView.lable.right-2;
                }
                nTouchView.roundDotLable.text=roundtitle;
            }else{
                nTouchView.roundDotLable.hidden=YES;
                nTouchView.roundDotLable.text=@"";
            }
        }
    }
    
}
@end
