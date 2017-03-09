//
//  THFilterView.m
//  toHomeMerchant
//
//  Created by 木木木 on 15/8/20.
//  Copyright (c) 2015年 sdj. All rights reserved.
//

#import "THFilterView.h"

@interface THFilterView () <UITableViewDelegate, UITableViewDataSource> {
    
    NSArray *_dataSource;
}

@end

@implementation THFilterView

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        _dataSource = [NSArray arrayWithArray:dataSource];
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        UIImage *bgImage = [UIImage imageNamed:@"filter_bg"];
        [bgImageView setImage:[bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(15, 60, 10, 10)]];
        [self addSubview:bgImageView];
        // 4
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 4, frame.size.width, frame.size.height - 4)];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self addSubview:tableView];
        [tableView reloadData];
        
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    
    if (newSuperview == nil) {
        return;
    }
    CGRect currentFrame = self.frame;
    self.frame = CGRectMake(currentFrame.origin.x, currentFrame.origin.y, currentFrame.size.width, 0);
    [UIView animateWithDuration:0.25 delay:0.0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        self.frame = currentFrame;
    } completion:nil];
}

- (void)removeFromSuperview {
    
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 0);
    } completion:^(BOOL finished) {
//        if (_datePicker && _datePicker.superview) {
//            [_datePicker removeFromSuperview];
//            _datePicker = nil;
//        }
//        if (_bgView && _bgView.superview) {
//            [_bgView removeFromSuperview];
//            _bgView = nil;
//        }
        if (self.superview) {
            [super removeFromSuperview];
        }
    }];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"Cell"];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.text = [_dataSource objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 30.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_keyValueBlock) {
        if (indexPath.row < _keys.count) {
            _keyValueBlock(_keys[indexPath.row], _dataSource[indexPath.row]);
            [self removeFromSuperview];
        }
    }
}

@end
