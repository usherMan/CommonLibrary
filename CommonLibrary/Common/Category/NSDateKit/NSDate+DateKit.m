//
//  NSDate+DateKit.m
//  CommonLibrary
//
//  Created by Usher Man on 2018/1/17.
//  Copyright © 2018年 UsherMan. All rights reserved.
//

#import "NSDate+DateKit.h"

static NSDateFormatter *dateFormatter = nil;
static NSString *defaultCalendarIdentifier = nil;
static NSCalendar *implicitCalendar = nil;

static const unsigned int allCalendarUnitFlags = NSCalendarUnitYear | NSCalendarUnitQuarter | NSCalendarUnitMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitWeekOfMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitEra | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitWeekOfYear;

@implementation NSDate (DateKit)

#define kMinuteTimeInterval (60)
#define kHourTimeInterval   (60 * kMinuteTimeInterval)
#define kDayTimeInterval    (24 * kHourTimeInterval)
#define kWeekTimeInterval   (7  * kDayTimeInterval)
#define kMonthTimeInterval  (30 * kDayTimeInterval)
#define kYearTimeInterval   (12 * kMonthTimeInterval)

+ (void)load {
    [self setDefaultCalendarIdentifier:NSCalendarIdentifierGregorian];
}

/**
 创建NSDateFormatter非常耗性能（cpu占用很高），耗时，使用时最好维持一个单例

 @return 时间格式化器
 */
+ (NSDateFormatter *)cachedDateFormatter {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        
    });

    return dateFormatter;
}

//返回 格式时间
- (NSDate *)dateWithDateFormatter:(NSString *)dateFormat
{
    //设置时间输出格式：
    NSDateFormatter *df = [NSDate cachedDateFormatter];
    [df setDateFormat:dateFormat];
    NSString *na = [df stringFromDate:self];
    NSDate *currDate = [df dateFromString:na];
    
    return currDate;
}

- (NSDate *)dateOfYMDHMS
{
    return [self dateWithDateFormatter:US_DateFormatter_Full];
}
#pragma mark NSDate 转 NSString
- (NSString *)stringOfYMDHMS
{
    return [self stringFromDateFormatter:US_DateFormatter_Full];
}

- (NSString *)stringOfYMD
{
    return [self stringFromDateFormatter:US_DateFormatter_YMD];
}

- (NSString*)stringOfHMS
{
    return [self stringFromDateFormatter:US_DateFormatter_HMS];
}

- (NSString*)stringOfHM
{
     return [self stringFromDateFormatter:US_DateFormatter_HM];
}

// 返回 格式字符串
- (NSString *)stringFromDateFormatter:(NSString *)dateFormat
{
    NSDateFormatter *dateformatter = [NSDate cachedDateFormatter];
    [dateformatter setDateFormat:dateFormat];
    
    NSString *string= [dateformatter stringFromDate:self];
    return string;
}

- (NSDateComponents *)returnNSDateComponents
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; //设置成中国阳历
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    comps = [calendar components:unitFlags fromDate:self];
    return comps;
}

+ (NSString*)stringWithTimeInterval:(NSInteger)timeInterval
{
    NSString *resultString = nil;
    NSInteger timeHour = (timeInterval/60)/60;
    NSInteger timeMin = (timeInterval/60)%60;
    NSInteger timeSecond = timeInterval%60;
    
    resultString = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)timeHour, (long)timeMin,(long)timeSecond];
    return resultString;
}

- (NSString *)timeTextOfDate
{
    NSDate *date = self;
    
    NSTimeInterval interval = [date timeIntervalSinceDate:[NSDate date]];
    
    interval = -interval;
    
    // 今天的消息
    NSDateFormatter* dateFormat = [NSDate cachedDateFormatter];
    [dateFormat setDateFormat:@"aHH:mm"];
    [dateFormat setAMSymbol:@"上午"];
    [dateFormat setPMSymbol:@"下午"];
    NSString *dateString = [dateFormat stringFromDate:date];
    
    if ([date isToday])
    {
        // 今天的消息
        return dateString;
    }
    else if ([date isYesterday])
    {
        // 昨天
        return [NSString stringWithFormat:@"昨天 %@", dateString];
    }
    else if (interval < kWeekTimeInterval)
    {
        // 最近一周
        // 实例化一个NSDateFormatter对象
        NSDateFormatter* weekFor = [NSDate cachedDateFormatter];
        weekFor.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [weekFor setDateFormat:@"ccc"];
        NSString *weekStr = [weekFor stringFromDate:date];
        return [NSString stringWithFormat:@"%@ %@", weekStr, dateString];
    }
    else
    {
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
        
        NSDateComponents *today = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
        
        if ([components year] == [today year])
        {
            // 今年
            NSDateFormatter *mdFor = [NSDate cachedDateFormatter];
            [mdFor setDateFormat:@"MM-dd"];
            NSString *mdStr = [mdFor stringFromDate:date];
            return [NSString stringWithFormat:@"%@ %@", mdStr, dateString];
        }
        else
        {
            // 往年
            NSDateFormatter *ymdFormat = [NSDate cachedDateFormatter];
            [ymdFormat setDateFormat:@"yy-MM-dd"];
            NSString *ymdString = [ymdFormat stringFromDate:date];
            return [NSString stringWithFormat:@"%@ %@", ymdString, dateString];
        }
    }
    return nil;
}

#pragma mark - 将某个时间转化成 时间戳
- (NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    NSDateFormatter *formatter = [NSDate cachedDateFormatter];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    NSLog(@"将某个时间转化成 时间戳&&&&&&&timeSp:%ld",(long)timeSp); //时间戳的值
    return timeSp;
}
#pragma mark - 将某个时间戳转化成 时间

- (NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format{
    NSDateFormatter *formatter = [NSDate cachedDateFormatter];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSLog(@"1296035591  = %@",confromTimesp);
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

- (NSString *)timeIntervalToString:(NSString *)time {

    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time.integerValue];
    NSInteger interval = -[date timeIntervalSinceDate:[NSDate new]];
    if (interval < 1) {
        return @"刚刚";
    }else if (interval < 60) {
        return [NSString stringWithFormat:@"%ld秒前",interval];
    }else if (interval < 60*60) {
        return [NSString stringWithFormat:@"%ld分钟前",interval/60];
    }else if (interval < 60*60*24) {
        return [NSString stringWithFormat:@"今天%@",[date stringOfHM]];
    }else if (interval < 60*60*24*2) {
        return [NSString stringWithFormat:@"昨天%@",[date stringOfHM]];
    }else {
        return [date stringOfYMD];
    }

    return nil;
}


#pragma mark 判断NSDate是否是（今天、昨天、明天、周末）
- (BOOL)isToday
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:[NSDate date]];
    NSDate *today = [cal dateFromComponents:components];
    
    components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:self];
    NSDate *otherDate = [cal dateFromComponents:components];
    
    if([today isEqualToDate:otherDate])
    {
        return YES;
    }
    return NO;
}

- (BOOL)isYesterday
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:[NSDate date]];
    NSDate *today = [cal dateFromComponents:components];
    NSDate *yesterday = [today dateByAddingTimeInterval: -kDayTimeInterval];
    
    components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:self];
    NSDate *otherDate = [cal dateFromComponents:components];
    
    if([yesterday isEqualToDate:otherDate])
    {
        return YES;
    }
    return NO;
}
- (BOOL)isTomorrow {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:[[NSDate date] dateByAddingDays:1]];
    NSDate *tomorrow = [cal dateFromComponents:components];
    components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:self];
    NSDate *otherDate = [cal dateFromComponents:components];
    
    return [tomorrow isEqualToDate:otherDate];
}

- (BOOL)isWeekend {
    NSCalendar *calendar            = [NSCalendar currentCalendar];
    NSRange weekdayRange            = [calendar maximumRangeOfUnit:NSCalendarUnitWeekday];
    NSDateComponents *components    = [calendar components:NSCalendarUnitWeekday
                                                  fromDate:self];
    NSUInteger weekdayOfSomeDate    = [components weekday];
    
    BOOL result = NO;
    
    if (weekdayOfSomeDate == weekdayRange.location || weekdayOfSomeDate == weekdayRange.length)
        result = YES;
    
    return result;
}
#pragma mark - NSDate 编辑
#pragma mark 增加时间
- (NSDate *)dateByAddingYears:(NSInteger)years{
    NSCalendar *calendar = [[self class] implicitCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:years];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAddingMonths:(NSInteger)months{
    NSCalendar *calendar = [[self class] implicitCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:months];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAddingWeeks:(NSInteger)weeks{
    NSCalendar *calendar = [[self class] implicitCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeekOfYear:weeks];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAddingDays:(NSInteger)days{
    NSCalendar *calendar = [[self class] implicitCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:days];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAddingHours:(NSInteger)hours{
    NSCalendar *calendar = [[self class] implicitCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setHour:hours];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAddingMinutes:(NSInteger)minutes{
    NSCalendar *calendar = [[self class] implicitCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMinute:minutes];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAddingSeconds:(NSInteger)seconds{
    NSCalendar *calendar = [[self class] implicitCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setSecond:seconds];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

#pragma mark 减少时间
- (NSDate *)dateBySubtractingYears:(NSInteger)years{
    NSCalendar *calendar = [[self class] implicitCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:-1*years];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateBySubtractingMonths:(NSInteger)months{
    NSCalendar *calendar = [[self class] implicitCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:-1*months];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateBySubtractingWeeks:(NSInteger)weeks{
    NSCalendar *calendar = [[self class] implicitCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeekOfYear:-1*weeks];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

/**
 *  Returns a date representing the receivers date shifted earlier by the provided number of days.
 *
 *  @param days NSInteger - Number of days to subtract
 *
 *  @return NSDate - Date modified by the number of desired days
 */
- (NSDate *)dateBySubtractingDays:(NSInteger)days{
    NSCalendar *calendar = [[self class] implicitCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:-1*days];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateBySubtractingHours:(NSInteger)hours{
    NSCalendar *calendar = [[self class] implicitCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setHour:-1*hours];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateBySubtractingMinutes:(NSInteger)minutes{
    NSCalendar *calendar = [[self class] implicitCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMinute:-1*minutes];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateBySubtractingSeconds:(NSInteger)seconds{
    NSCalendar *calendar = [[self class] implicitCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setSecond:-1*seconds];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

#pragma mark - Date Comparison
#pragma mark Time From
-(NSInteger)yearsFrom:(NSDate *)date{
    return [self yearsFrom:date calendar:nil];
}

-(NSInteger)monthsFrom:(NSDate *)date{
    return [self monthsFrom:date calendar:nil];
}

-(NSInteger)weeksFrom:(NSDate *)date{
    return [self weeksFrom:date calendar:nil];
}

-(NSInteger)daysFrom:(NSDate *)date{
    return [self daysFrom:date calendar:nil];
}

-(double)hoursFrom:(NSDate *)date{
    return ([self timeIntervalSinceDate:date])/kHourTimeInterval;
}

-(double)minutesFrom:(NSDate *)date{
    return ([self timeIntervalSinceDate:date])/kMinuteTimeInterval;
}

-(double)secondsFrom:(NSDate *)date{
    return [self timeIntervalSinceDate:date];
}

#pragma mark Time From With Calendar
-(NSInteger)yearsFrom:(NSDate *)date calendar:(NSCalendar *)calendar{
    if (!calendar) {
        calendar = [[self class] implicitCalendar];
    }
    
    NSDate *earliest = [self earlierDate:date];
    NSDate *latest = (earliest == self) ? date : self;
    NSInteger multiplier = (earliest == self) ? -1 : 1;
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:earliest toDate:latest options:0];
    return multiplier*components.year;
}

-(NSInteger)monthsFrom:(NSDate *)date calendar:(NSCalendar *)calendar{
    if (!calendar) {
        calendar = [[self class] implicitCalendar];
    }
    
    NSDate *earliest = [self earlierDate:date];
    NSDate *latest = (earliest == self) ? date : self;
    NSInteger multiplier = (earliest == self) ? -1 : 1;
    NSDateComponents *components = [calendar components:allCalendarUnitFlags fromDate:earliest toDate:latest options:0];
    return multiplier*(components.month + 12*components.year);
}

-(NSInteger)weeksFrom:(NSDate *)date calendar:(NSCalendar *)calendar{
    if (!calendar) {
        calendar = [[self class] implicitCalendar];
    }
    
    NSDate *earliest = [self earlierDate:date];
    NSDate *latest = (earliest == self) ? date : self;
    NSInteger multiplier = (earliest == self) ? -1 : 1;
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekOfYear fromDate:earliest toDate:latest options:0];
    return multiplier*components.weekOfYear;
}

-(NSInteger)daysFrom:(NSDate *)date calendar:(NSCalendar *)calendar{
    if (!calendar) {
        calendar = [[self class] implicitCalendar];
    }
    
    NSDate *earliest = [self earlierDate:date];
    NSDate *latest = (earliest == self) ? date : self;
    NSInteger multiplier = (earliest == self) ? -1 : 1;
    NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:earliest toDate:latest options:0];
    return multiplier*components.day;
}

#pragma mark Earlier Than
-(NSInteger)yearsEarlierThan:(NSDate *)date{
    NSLog(@"当前时间==%ld",[self yearsFrom:date]);
    return (MIN([self yearsFrom:date], 0));
}

-(NSInteger)monthsEarlierThan:(NSDate *)date{
    return (MIN([self monthsFrom:date], 0));
}

-(NSInteger)weeksEarlierThan:(NSDate *)date{
    return (MIN([self weeksFrom:date], 0));
}

-(NSInteger)daysEarlierThan:(NSDate *)date{
    return (MIN([self daysFrom:date], 0));
}

-(double)hoursEarlierThan:(NSDate *)date{
    return (MIN([self hoursFrom:date], 0));
}

-(double)minutesEarlierThan:(NSDate *)date{
    return (MIN([self minutesFrom:date], 0));
}

-(double)secondsEarlierThan:(NSDate *)date{
    return (MIN([self secondsFrom:date], 0));
}

#pragma mark Later Than
-(NSInteger)yearsLaterThan:(NSDate *)date{
    return MAX([self yearsFrom:date], 0);
}

-(NSInteger)monthsLaterThan:(NSDate *)date{
    return MAX([self monthsFrom:date], 0);
}

-(NSInteger)weeksLaterThan:(NSDate *)date{
    return MAX([self weeksFrom:date], 0);
}

-(NSInteger)daysLaterThan:(NSDate *)date{
    return MAX([self daysFrom:date], 0);
}

-(double)hoursLaterThan:(NSDate *)date{
    return MAX([self hoursFrom:date], 0);
}

-(double)minutesLaterThan:(NSDate *)date{
    return MAX([self minutesFrom:date], 0);
}

-(double)secondsLaterThan:(NSDate *)date{
    return MAX([self secondsFrom:date], 0);
}

#pragma mark Comparators
-(BOOL)isEarlierThan:(NSDate *)date{
    if (self.timeIntervalSince1970 < date.timeIntervalSince1970) {
        return YES;
    }
    return NO;
}

-(BOOL)isLaterThan:(NSDate *)date{
    if (self.timeIntervalSince1970 > date.timeIntervalSince1970) {
        return YES;
    }
    return NO;
}

-(BOOL)isEarlierThanOrEqualTo:(NSDate *)date{
    if (self.timeIntervalSince1970 <= date.timeIntervalSince1970) {
        return YES;
    }
    return NO;
}

-(BOOL)isLaterThanOrEqualTo:(NSDate *)date{
    if (self.timeIntervalSince1970 >= date.timeIntervalSince1970) {
        return YES;
    }
    return NO;
}

-(BOOL)isEqualTo:(NSDate *)date{
    if (self.timeIntervalSince1970 == date.timeIntervalSince1970) {
        return YES;
    }
    return NO;
}
#pragma mark - Date Creating
+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    
    return [self dateWithYear:year month:month day:day hour:0 minute:0 second:0];
}

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second {
    
    NSDate *nsDate = nil;
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year   = year;
    components.month  = month;
    components.day    = day;
    components.hour   = hour;
    components.minute = minute;
    components.second = second;
    nsDate = [[[self class] implicitCalendar] dateFromComponents:components];
    
    return nsDate;
}

+ (NSDate *)dateWithString:(NSString *)dateString formatString:(NSString *)formatString {
    
    return [self dateWithString:dateString formatString:formatString timeZone:[NSTimeZone systemTimeZone]];
}

+ (NSDate *)dateWithString:(NSString *)dateString formatString:(NSString *)formatString timeZone:(NSTimeZone *)timeZone {
    
    static NSDateFormatter *parser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        parser = [[NSDateFormatter alloc] init];
    });
    parser.dateStyle = NSDateFormatterNoStyle;
    parser.timeStyle = NSDateFormatterNoStyle;
    parser.timeZone = timeZone;
    parser.dateFormat = formatString;
    
    return [parser dateFromString:dateString];
}


+(NSString *)defaultCalendarIdentifier {
    return defaultCalendarIdentifier;
}

+ (NSCalendar *)implicitCalendar {
    return implicitCalendar;
}

+ (void)setDefaultCalendarIdentifier:(NSString *)identifier {
    defaultCalendarIdentifier = [identifier copy];
    implicitCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:defaultCalendarIdentifier ?: NSCalendarIdentifierGregorian];
}

@end
