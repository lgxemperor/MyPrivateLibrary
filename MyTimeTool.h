//
//  TimeTool.h
//  TimePicker
//
//  Created by App on 1/14/16.
//  Copyright © 2016 App. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyTimeTool : NSObject

+(NSArray *)daysFromNowToDeadLine:(NSString *)deadLine;

+(int)currentDateHour;

+(int)currentDateMinute;

+(NSString *)displayedSummaryTimeUsingString:(NSString *)string;

+(NSArray *)yearsFromNow;
+(NSArray *)monthsFromNow;
+(NSArray *)daysFromMonth:(NSInteger)month WithYear:(NSInteger)year;


+(NSInteger)currentYear;

+(NSInteger)currentMonth;
+(NSInteger)currentDay;

+(NSString *)convertDate:(NSString *)datestr WithDuration:(NSString *)duration;
+(NSString *)convertSummaryTimeUsingString:(NSString *)datestr  WithDuration:(NSString *)duration;

+(NSString *)differenceBetween:(NSString *)startTime EndTime:(NSString *)endTime;

+(NSDictionary *)currentDateDescrip;
@end
