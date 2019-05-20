//
//  NSDate+DateKit.h
//  CommonLibrary
//
//  Created by Usher Man on 2018/1/17.
//  Copyright © 2018年 UsherMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "USCategoryConst.h"
@interface NSDate (DateKit)

/**
 创建NSDateFormatter非常耗性能（cpu占用很高），耗时，使用时最好维持一个单例
 
 @return 时间格式化器
 */
+ (NSDateFormatter *)cachedDateFormatter;

#pragma mark NSDate 转成指定格式
/**
 返回 yyyy-MM-dd HH:mm:ss 格式时间

 @return 格式时间
 */
- (NSDate *)dateOfYMDHMS;

#pragma mark NSDate 转 NSString
/**
 返回 yyyy-MM-dd HH:mm:ss 格式时间字符串

 @return 格式时间字符串
 */
- (NSString *)stringOfYMDHMS;
/**
 返回 年-月-日  格式时间字符串

 @return 格式时间字符串
 */
- (NSString *)stringOfYMD;
/**
 返回 HH：mm：ss 格式时间字符串
 
 @return 格式时间字符串
 */
- (NSString*)stringOfHMS;
/**
 返回 HH：mm 格式时间字符串
 
 @return 格式时间字符串
 */
- (NSString*)stringOfHM;

/**
 返回格式化自定义的时间字符串

 @param format 自定义的时间格式
 @return 字符串
 */
- (NSString *)stringFromDateFormatter:(NSString *)dateFormat
/**
 返回 HH：mm：ss 格式时间字符串
 
 @param timeInterval 描述
 @return 格式时间字符串（时：分：秒）
 */
+ (NSString*)stringWithTimeInterval:(NSInteger)timeInterval;
/**
 返回 特定格式的字符串（今天，昨天，周几，今年，去年）
 
 @return 时间字符串
 */
- (NSString *)timeTextOfDate;

/**
 将某个时间转化成 时间戳
 */
- (NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;

/**
 将某个时间戳转化成时间
 */
- (NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;

/**
 格式化时间 由时间戳 转化成 时间间隔（几秒前、几分钟）
 @return 几分钟前
 */
- (NSString *)timeIntervalToString:(NSString *)time;

#pragma mark 判断NSDate是否是（今天、昨天、明天、周末）
- (BOOL)isToday;
- (BOOL)isYesterday;
- (BOOL)isTomorrow;
- (BOOL)isWeekend;

#pragma mark - NSDate 编辑
#pragma mark 增加时间
- (NSDate *)dateByAddingYears:(NSInteger)years;
- (NSDate *)dateByAddingMonths:(NSInteger)months;
- (NSDate *)dateByAddingWeeks:(NSInteger)weeks;
- (NSDate *)dateByAddingDays:(NSInteger)days;
- (NSDate *)dateByAddingHours:(NSInteger)hours;
- (NSDate *)dateByAddingMinutes:(NSInteger)minutes;
- (NSDate *)dateByAddingSeconds:(NSInteger)seconds;
#pragma mark 减少时间
- (NSDate *)dateBySubtractingYears:(NSInteger)years;
- (NSDate *)dateBySubtractingMonths:(NSInteger)months;
- (NSDate *)dateBySubtractingWeeks:(NSInteger)weeks;
- (NSDate *)dateBySubtractingDays:(NSInteger)days;
- (NSDate *)dateBySubtractingHours:(NSInteger)hours;
- (NSDate *)dateBySubtractingMinutes:(NSInteger)minutes;
- (NSDate *)dateBySubtractingSeconds:(NSInteger)seconds;

#pragma mark - Date Comparison
#pragma mark Time From
-(NSInteger)yearsFrom:(NSDate *)date;
-(NSInteger)monthsFrom:(NSDate *)date;
-(NSInteger)weeksFrom:(NSDate *)date;
-(NSInteger)daysFrom:(NSDate *)date;
-(double)hoursFrom:(NSDate *)date;
-(double)minutesFrom:(NSDate *)date;
-(double)secondsFrom:(NSDate *)date;
#pragma mark Time From With Calendar
-(NSInteger)yearsFrom:(NSDate *)date calendar:(NSCalendar *)calendar;
-(NSInteger)monthsFrom:(NSDate *)date calendar:(NSCalendar *)calendar;
-(NSInteger)weeksFrom:(NSDate *)date calendar:(NSCalendar *)calendar;
-(NSInteger)daysFrom:(NSDate *)date calendar:(NSCalendar *)calendar;

#pragma mark Earlier Than
-(NSInteger)yearsEarlierThan:(NSDate *)date;
-(NSInteger)monthsEarlierThan:(NSDate *)date;
-(NSInteger)weeksEarlierThan:(NSDate *)date;
-(NSInteger)daysEarlierThan:(NSDate *)date;
-(double)hoursEarlierThan:(NSDate *)date;
-(double)minutesEarlierThan:(NSDate *)date;
-(double)secondsEarlierThan:(NSDate *)date;
#pragma mark Later Than
-(NSInteger)yearsLaterThan:(NSDate *)date;
-(NSInteger)monthsLaterThan:(NSDate *)date;
-(NSInteger)weeksLaterThan:(NSDate *)date;
-(NSInteger)daysLaterThan:(NSDate *)date;
-(double)hoursLaterThan:(NSDate *)date;
-(double)minutesLaterThan:(NSDate *)date;
-(double)secondsLaterThan:(NSDate *)date;

#pragma mark Comparators
-(BOOL)isEarlierThan:(NSDate *)date;
-(BOOL)isLaterThan:(NSDate *)date;
-(BOOL)isEarlierThanOrEqualTo:(NSDate *)date;
-(BOOL)isLaterThanOrEqualTo:(NSDate *)date;
-(BOOL)isEqualTo:(NSDate *)date;//date是否相等

#pragma mark - Date Creating
+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;
+ (NSDate *)dateWithString:(NSString *)dateString formatString:(NSString *)formatString;
+ (NSDate *)dateWithString:(NSString *)dateString formatString:(NSString *)formatString timeZone:(NSTimeZone *)timeZone;

#pragma mark - 设置默认的日历
+(NSString *)defaultCalendarIdentifier;
+ (void)setDefaultCalendarIdentifier:(NSString *)identifier;
@end
