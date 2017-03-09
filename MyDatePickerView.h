//
//  MyTimePicker.h
//  TimePicker
//
//  Created by App on 1/13/16.
//  Copyright © 2016 App. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyDatePickerView : UIView

+(void)showDatePickerViewDeadLine:(NSString *)deadLine CompleteBlock:(void (^)(NSDictionary *infoDic))completeBlock;

@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (nonatomic, assign) NSInteger intervalMinute;

@end
