//
//  NSDictionary+Extern.h
//  toHomeMerchant
//
//  Created by 木木木 on 15/8/17.
//  Copyright (c) 2015年 sdj. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSString (mogujieString)
- (NSString *) MD5;
-(NSString * )URLEncode;
- (BOOL)isValidCardNumber:(NSString*) cardNo;
+(BOOL)isMobileNumber:(NSString *)mobileNum;
@end
@interface NSDictionary (Extern)

- (id)checkedObjectForKey:(id)key;
- (id)getObjectForKey:(id)key ;
-(NSDictionary *)configRequestParamWithIsEncrypt:(BOOL)isEncrypt;
@end

@interface NSDate (Addition)
+(NSString *)currentTimeStamp;
+(NSString *)stringFromDate:(NSDate *)date WithFormatter:(NSString *)formatter;
+ (NSString *)dateFromString:(NSString *)string withFormat:(NSString *)format;
+(NSDate *)dateWithString:(NSString *)string withFormat:(NSString *)format;
+(NSDate *)getDateFromString:(NSString *)string withFormat:(NSString *)format;
+ (NSString *)currentDateStringWithFormat:(NSString *)format;
+(NSString *)timeStampToDate:(NSString *)timeStamp;
+(NSDate *)dateFromTimeStamp:(NSString *)timeStamp;
- (NSString *)dateWithFormat:(NSString *)format;
- (NSString *)weekday;
+(NSArray *)getCurrentWeekDays;
- (NSInteger)year;
- (NSInteger)month;
- (NSInteger)day;
- (NSInteger)hour;
- (NSInteger)minute;
- (NSInteger)second;
@end
