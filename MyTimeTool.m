//
//  TimeTool.m
//  TimePicker
//
//  Created by App on 1/14/16.
//  Copyright © 2016 App. All rights reserved.
//

#import "MyTimeTool.h"
#define MAXCOUNTDAYS 366

@implementation MyTimeTool
+(NSArray *)yearsFromNow{
    NSDate *date=[NSDate date];
    NSCalendar *gregorianCalendar =[NSCalendar currentCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:date];
    NSMutableArray *dayArray = [NSMutableArray array];
    [dayArray addObject:[@(components.year) stringValue]];
    [dayArray addObject:[@(components.year+1) stringValue]];
    return dayArray;
}
+(NSArray *)monthsFromNow{
    NSMutableArray *monthArray = [NSMutableArray array];
    for (int i=0; i<12; i++) {
        [monthArray addObject:[@(i+1) stringValue]];
    }
    return monthArray;
}
+(BOOL)bissextile:(NSInteger)year {
    if ((year%4==0 && year %100 !=0) || year%400==0) {
        return YES;
    }else {
        return NO;
    }
    return NO;
}
+(NSArray *)daysFromMonth:(NSInteger)month WithYear:(NSInteger)year{
    NSMutableArray *mArray=[[NSMutableArray alloc] init];
    int days=30;
    switch(month)
    {
        case 1:
            days=31;
            break;
        case 2:
        {
            if ([MyTimeTool bissextile:year]) {
                days=29;
            }else{
                days=28;
            }
        }
            break;
        case 3:
            days=31;
            break;
        case 4:
            days=30;
            break;
        case 5:
            days=31;
            break;
        case 6:
            days=30;
            break;
        case 7:
            days=31;
            break;
        case 8:
            days=31;
            break;
        case 9:
            days=30;
            break;
        case 10:
            days=31;
            break;
        case 11:
            days=30;
            break;
        case 12:
            days=31;
            break;
        default:
            break;
    }
    for (int i=0; i<days; i++) {
        [mArray addObject:[NSString stringWithFormat:@"%d",i+1]];
    }
    return mArray;
}
+(NSArray *)daysFromNowToDeadLine:(NSString *)deadLine{
    
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyyMMdd"];
    NSDate *startDate = [f dateFromString:[self summaryTimeUsingDate:[NSDate date]]];
    NSDate *endDate = [NSDate dateWithTimeInterval:[deadLine integerValue] sinceDate: startDate];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:NSCalendarWrapComponents];
    int diffDays = components.day;
    if(diffDays==0) return @[[self summaryTimeUsingDate:[NSDate date]]];
    NSMutableArray *dayArray = [NSMutableArray array];
    if(diffDays > MAXCOUNTDAYS) diffDays = MAXCOUNTDAYS;
    for (int i = 0; i <= abs(diffDays); i++) {
        NSTimeInterval  iDay = 24*60*60*i;  //1天的长度
        if (diffDays < 0) {
            iDay *= -1;
        }
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:iDay];
        [dayArray addObject:[self summaryTimeUsingDate:date]];
    }
    return dayArray;
}
+(NSInteger)currentYear{
    return [self dateComponents].year;
}
+(NSInteger)currentMonth{
    return [self dateComponents].month;
}
+(NSInteger)currentDay{
    return [self dateComponents].day;
}
+(int)currentDateHour{
    NSLog(@"hour is: %d", [self dateComponents].hour);
    return [self dateComponents].hour;
}

+(int)currentDateMinute{
    NSLog(@"minute is: %d", [self dateComponents].minute);
    return [self dateComponents].minute;
}

+(NSDateComponents *)dateComponents{
    NSDate *currentDate = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:currentDate];
    return dateComponent;
}

+(NSString *)summaryTimeUsingDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+(NSString *)summaryTimeUsingDate1:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+(NSString *)displayedSummaryTimeUsingString:(NSString *)string
{
    NSMutableString *result = [[NSMutableString alloc] initWithString:[string substringWithRange:NSMakeRange(0, 4)]];
    [result appendString:@"-"];
    [result appendString:[string substringWithRange:NSMakeRange(4, 2)]];
    [result appendString:@"-"];
    [result appendString:[string substringWithRange:NSMakeRange(6, 2)]];
    return result;
}
+(NSString *)convertSummaryTimeUsingString:(NSString *)datestr  WithDuration:(NSString *)duration
{
    NSString *fomatstr=@"yyyy-MM-dd HH:mm:ss";
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:fomatstr];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSDate *date = [inputFormatter dateFromString:datestr];
    NSDate *nDate=[date dateByAddingTimeInterval:[duration doubleValue]*3600];
    NSString *result=[NSString stringWithFormat:@"%@%d时%d分-%d时%d分",[MyTimeTool dateToStr:date],[date hour],[date minute],[nDate hour],[nDate minute]];
    return result;
}
+(NSString *)dateToStr:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    NSDate *startDate = [calendar dateFromComponents:components];
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    NSDate *endDate1 = [calendar dateByAddingUnit:NSCalendarUnitDay value:2 toDate:startDate options:0];
    if ([date compare:endDate]<0) {
        return @"今天";
    }else if ([date compare:endDate1]<0){
        return @"明天";
    }else{
        return @"后天";
    }
}
+(NSString *)convertDate:(NSString *)datestr WithDuration:(NSString *)duration{
    NSString *fomatstr=@"yyyy-MM-dd HH:mm:ss";
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:fomatstr];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSDate *date = [inputFormatter dateFromString:datestr];
    NSDate *nDate=[date dateByAddingTimeInterval:[duration doubleValue]*3600];
    return [inputFormatter stringFromDate:nDate];
}
+(NSString *)differenceBetween:(NSString *)startTime EndTime:(NSString *)endTime{
    NSString *fomatstr=@"yyyy-MM-dd HH:mm:ss";
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:fomatstr];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSDate *sdate = [inputFormatter dateFromString:startTime];
    NSDate *edate = [inputFormatter dateFromString:endTime];
    NSTimeInterval diff=[edate timeIntervalSinceDate:sdate]/3600;
    return [@(diff) stringValue];
}
+(NSDictionary *)currentDateDescrip{
    NSDate *date=[NSDate date];
    NSDate *nDate=[NSDate dateWithString:[NSString stringWithFormat:@"%d-%02d-%02d %02d:00:00",[date year],[date month],[date day],[date hour]] withFormat:@"yyyy-MM-dd HH:mm:ss"];
    if([date minute]+30<=45){
        nDate=[nDate dateByAddingTimeInterval:45*60];
    }else if ([date minute]+30<=60){
        nDate=[nDate dateByAddingTimeInterval:60*60];
    }else{
        nDate=[nDate dateByAddingTimeInterval:90*60];
    }
    NSDate *eDate=[nDate dateByAddingTimeInterval:60*60];
    NSString *reservedTime=[NSDate stringFromDate:nDate WithFormatter:@"yyyy-MM-dd HH:mm:ss"];
    NSString *bespeaktime_end=[NSDate stringFromDate:eDate WithFormatter:@"yyyy-MM-dd HH:mm:ss"];;
    NSString *timedescrip=[MyTimeTool convertSummaryTimeUsingString:reservedTime WithDuration:@"1"];
    return @{@"reservedtime":reservedTime,@"bespeaktime_end":bespeaktime_end,@"timedescrip":timedescrip};
}
@end
