//
//  NSDictionary+Extern.m
//  toHomeMerchant
//
//  Created by 木木木 on 15/8/17.
//  Copyright (c) 2015年 sdj. All rights reserved.
//

#import "NSDictionary+Extern.h"
#import <sys/xattr.h>
#import <CommonCrypto/CommonDigest.h>
@implementation NSString  (mogujieString)
#pragma mark - MD5
- (NSString *) MD5 {
    // Create pointer to the string as UTF8
    const char* ptr = [self UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(ptr, strlen(ptr), md5Buffer);
    
    // Convert MD5 value in the buffer to NSString of hex values
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",md5Buffer[i]];
    }
    
    return output;
}
-(NSString *)trim{
    return  [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
-(NSString * )URLEncode{
    NSString *result =
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              NULL,
                                                              CFSTR("!*'();:@&;=+$,/?%#[] "),
                                                              kCFStringEncodingUTF8));
    return [result trim];
}
- (BOOL)isValidCardNumber:(NSString*) cardNo{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}
+(BOOL)isMobileNumber:(NSString *)mobileNum{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
@end
@implementation NSDictionary (Extern)

- (id)checkedObjectForKey:(id)key {
    
    if (![self objectForKey:key] || ((NSNull *)[self objectForKey:key] == [NSNull null])) {
        return @"";
    }
    NSString *dValue=[NSString stringWithFormat:@"%@",[self objectForKey:key]];
    if ([dValue isEqualToString:@"null"]) {
        return @"";
    }
    
    return [self objectForKey:key];
}
- (id)getObjectForKey:(id)key {
    
    if (![self objectForKey:key] || ((NSNull *)[self objectForKey:key] == [NSNull null])) {
        return @"";
    }
    NSString *dValue=[NSString stringWithFormat:@"%@",[self objectForKey:key]];
    if ([dValue isEqualToString:@"null"]) {
        return @"";
    }
    
    return dValue;//非数组，字典类型返回字符串
}
@end
@implementation NSDate (Addition)
+(NSString *)dateFromString:(NSString *)string withFormat:(NSString *)format{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
//    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:format];
    NSDate *date = [inputFormatter dateFromString:string];
    
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate: date];
//    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}
+(NSDate *)dateWithString:(NSString *)string withFormat:(NSString *)format{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:format];
    NSDate *date = [inputFormatter dateFromString:string];
    
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate: date];
//    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    return date;
}
+(NSDate *)getDateFromString:(NSString *)string withFormat:(NSString *)format{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSDate *date = [inputFormatter dateFromString:string];
    
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate: date];
//    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return date;
}
+ (NSString *)currentDateStringWithFormat:(NSString *)format
{
    NSDate *chosenDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:format];
    NSString *date = [formatter stringFromDate:chosenDate];
    return date;
}
+(NSString *)stringFromDate:(NSDate *)date WithFormatter:(NSString *)formatter{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [dateFormatter setDateFormat:@"yy-MM-dd"];
    if (formatter.length>0) {
        [dateFormatter setDateFormat:formatter];//@"yyyy-MM-dd HH:mm:ss"
    }
    return [dateFormatter stringFromDate:date];
}
+(NSString *)timeStampToDate:(NSString *)timeStamp{
    NSDate *date  = [NSDate dateWithTimeIntervalSince1970:[timeStamp doubleValue]];
    
//    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
//    //设置转换后的目标日期时区
//    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
//    //得到源日期与世界标准时间的偏移量
//    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:date];
//    //目标日期与本地时区的偏移量
//    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:date];
//    //得到时间偏移量的差值
//    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    NSTimeInterval interval = 0.0;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:date];
    
    return [NSDate stringFromDate:destinationDateNow WithFormatter:@"yyyy-MM-dd HH:mm:ss"];
}
+(NSDate *)dateFromTimeStamp:(NSString *)timeStamp{
    NSDate *date  = [NSDate dateWithTimeIntervalSince1970:[timeStamp doubleValue]];
    return  date;
}
- (NSString *)dateWithFormat:(NSString *)format
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [dateFormatter setDateFormat:format];
    NSString *date = [dateFormatter stringFromDate:self];
    return date;
}
+(NSString *)currentTimeStamp{
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    return timeSp;
}
- (NSString *)weekday
{
    NSCalendar*calendar = [[NSLocale currentLocale] objectForKey:NSLocaleCalendar];
    NSDateComponents*comps;
    
    comps =[calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit)
                       fromDate:self];
    NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    NSString *week = @"";
    switch (weekday) {
        case 1:
            week = @"周日";
            break;
        case 2:
            week = @"周一";
            break;
        case 3:
            week = @"周二";
            break;
        case 4:
            week = @"周三";
            break;
        case 5:
            week = @"周四";
            break;
        case 6:
            week = @"周五";
            break;
        case 7:
            week = @"周六";
            break;
            
        default:
            break;
    }
    
    return week;
}
+(NSArray *)getCurrentWeekDays{
    NSMutableArray *wArray=[NSMutableArray array];
    NSCalendar*calendar = [[NSLocale currentLocale] objectForKey:NSLocaleCalendar];
    NSDateComponents*comps;
    NSDate *date=[NSDate  date];
    
    comps =[calendar components:(NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal |NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay)
                       fromDate:date];
    
    for (int i=0; i<7; i++) {
        NSInteger cYear=comps.year;
        NSInteger cMonth=comps.month;
        NSInteger cDay=comps.day-(6-i);
        if (cDay<=0) {
            cMonth=cMonth-1;
            if (cMonth<=0) {
                cMonth=12;
                cYear=cYear-1;
            }
            NSInteger monthDays=[NSDate dayFromMonth:cMonth WithYear:cYear];
            cDay=monthDays+cDay-1;
        }
        [wArray addObject:[NSString stringWithFormat:@"%02ld-%02ld",cMonth,cDay]];
    }
    return wArray;
}
+(BOOL)bissextile:(NSInteger)year {
    if ((year%4==0 && year %100 !=0) || year%400==0) {
        return YES;
    }else {
        return NO;
    }
    return NO;
}
+(NSInteger)dayFromMonth:(NSInteger)month WithYear:(NSInteger)year{
    int days=30;
    switch(month)
    {
        case 1:
            days=31;
            break;
        case 2:
        {
            if ([NSDate bissextile:year]) {
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
    return days;
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
            if ([NSDate bissextile:year]) {
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
#pragma mark - Data component
- (NSInteger)year
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitYear fromDate:self];
    return [components year];
}

- (NSInteger)month
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitMonth fromDate:self];
    return [components month];
}

- (NSInteger)day
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay fromDate:self];
    return [components day];
}

- (NSInteger)hour
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components: NSCalendarUnitMonth |NSCalendarUnitYear | NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute  fromDate:self];
    return [dateComponents hour];
}

- (NSInteger)minute
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth |NSCalendarUnitYear | NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute  fromDate:self];
    return [dateComponents minute];
}

- (NSInteger)second
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth |NSCalendarUnitYear | NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute  fromDate:self];
    return [dateComponents second];
}

@end
