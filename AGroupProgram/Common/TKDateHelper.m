//
//  TKDateHelper.m
//  TKUtil
//
//  Created by liubao on 14-11-5.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import "TKDateHelper.h"
#import "TKStringHelper.h"

/**
 *  日期处理帮助类
 */
@implementation TKDateHelper

/**
 *  把Date转换为缺省的日期格式字串，缺省的字转换格式为yyyy-MM-dd 如：2004-10-10
 *
 *  @param date 要转换的日期
 *
 *  @return 格式化以后的日期字符串
 */
+(NSString *)formatDate:(NSDate *)date
{
    return [TKDateHelper formatDate:date format:@"yyyy-MM-dd"];
}

/**
 *  把Date转换日期格式字串
 *
 *  @param date   要转换的日期
 *  @param format 格式串
 *
 *  @return 格式化以后的日期字符串
 */
+(NSString *)formatDate:(NSDate *)date format:(NSString *)format
{
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    formater.dateFormat = format;
    return [formater stringFromDate:date];
}

/**
 *  以缺省的yyyy-MM-dd格式转换字符串为Date,若转换成功，则返回相应的Date对象 若转换失败，则返回nil。
 *
 *  @param str 日期字符串
 *
 *  @return 转换后的日期对象
 */
+(NSDate *)parseDateStr:(NSString *)dateStr
{
    return [TKDateHelper parseDateStr:dateStr format:@"yyyy-MM-dd"];
}

/**
 *  转换字符串为Date,若转换成功，则返回相应的Date对象 若转换失败，则返回nil。
 *
 *  @param str    日期字符串
 *  @param format 格式字符串
 *
 *  @return 转换后的日期对象
 */
+(NSDate *)parseDateStr:(NSString *)dateStr format:(NSString *)format
{
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    formater.dateFormat = format;
    return [formater dateFromString:dateStr];
}

/**
 *  获得特定日期的星期字串
 *
 *  @param date 日期
 *
 *  @return 星期字符串
 */
+(NSString *)getWeekStr:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSWeekdayCalendarUnit fromDate:date];
    NSString *weekStr = @"";
    switch (components.weekday)
    {
        case 2:
            weekStr = @"星期一";
            break;
        case 3:
            weekStr = @"星期二";
            break;
        case 4:
            weekStr = @"星期三";
            break;
        case 5:
            weekStr = @"星期四";
            break;
        case 6:
            weekStr = @"星期五";
            break;
        case 7:
            weekStr = @"星期六";
            break;
        case 1:
            weekStr = @"星期日";
            break;
        default:
            break;
    }
    return weekStr;
}

/**
 *  获得特定日期的星期数，7是星期天，1是星期一，如此类推
 *
 *  @param date 日期
 *
 *  @return 星期数
 */
+(NSInteger)getWeek:(NSDate *)date
{
    NSCalendar *calender = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calender components:NSWeekdayCalendarUnit fromDate:date];
    NSInteger weekday = components.weekday;
    weekday --;
    if (weekday == 0)
    {
        weekday = 7;
    }
    return weekday;
}

/**
 *  获取指定日期的年份
 *
 *  @param date 日期
 *
 *  @return 年份
 */
+(NSInteger)getYear:(NSDate *)date
{
    NSCalendar *calender = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calender components:NSYearCalendarUnit fromDate:date];
    return components.year;
}

/**
 *  获取指定日期的月份
 *
 *  @param date 日期
 *
 *  @return 月份
 */
+(NSInteger)getMonth:(NSDate *)date
{
    NSCalendar *calender = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calender components:NSMonthCalendarUnit fromDate:date];
    return components.month;
}

/**
 *  获取指定日期的天数
 *
 *  @param date 日期
 *
 *  @return 天数
 */
+(NSInteger)getDay:(NSDate *)date
{
    NSCalendar *calender = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calender components:NSDayCalendarUnit fromDate:date];
    return components.day;
}

/**
 *  提取当前时间的星期数，7是星期天，1是星期一，如此类推
 *
 *  @return 星期数
 */
+(NSInteger)getCurrentWeek
{
    return [TKDateHelper getWeek:[NSDate date]];
}

/**
 *  提取当前的星期数的中文字串，星期一...星期日
 *
 *  @return 星期数
 */
+(NSString *)getCurrentWeekStr
{
    return [TKDateHelper getWeekStr:[NSDate date]];
}

/**
 *  获取当前年份
 *
 *  @return 年份
 */
+(NSInteger)getCurrentYear
{
    return [TKDateHelper getYear:[NSDate date]];
}

/**
 *  获取当前月份
 *
 *  @return 月份
 */
+(NSInteger)getCurrentMonth
{
    return [TKDateHelper getMonth:[NSDate date]];
}

/**
 *  获取当前的天数
 *
 *  @return 天数
 */
+(NSInteger)getCurrentDay
{
    return [TKDateHelper getDay:[NSDate date]];
}

/**
 *  获取两个日期差的秒数
 *
 *  @param date0 日期1
 *  @param date1 日期2
 *
 *  @return 日期差的秒数 date0 - date1
 */
+(NSInteger)getTwoDateDiffSecsFrom:(NSDate *)date0 to:(NSDate *)date1
{
    if (date0 && date1)
    {
        return [date0 timeIntervalSinceDate:date1];
    }
    return 0;
}

/**
 *  获取两个日期差的天数
 *
 *  @param date0 日期1 yyyy-MM-dd
 *  @param date1 日期2 yyyy-MM-dd
 *
 *  @return 日期差的天数 date0 - date1
 */
+(NSInteger)getTwoDateDiffDaysFrom:(NSDate *)date0 to:(NSDate *)date1
{
    if (date0 && date1)
    {
        NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [calendar components:NSDayCalendarUnit fromDate:date1 toDate:date0 options:0];
        return components.day;
    }
    return 0;
}

/**
 *  日期减去天数，得到新的日期
 *
 *  @param date 日期
 *  @param days 天数
 *
 *  @return 新的日期
 */
+(NSDate *)getDateDiffDate:(NSDate *)date days:(NSInteger)days
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc]init];
    components.day = -1 * days;
    return [calendar dateByAddingComponents:components toDate:date options:0];
}

/**
 *  日期减去天数，得到新的日期
 *
 *  @param dateStr 日期字符串 yyyy-MM-dd
 *  @param days    天数
 *
 *  @return 新的日期
 */
+(NSDate *)getDateDiffDateStr:(NSString *)dateStr days:(NSInteger)days
{
    NSDate *date = [TKDateHelper parseDateStr:dateStr];
    return [TKDateHelper getDateDiffDate:date days:days];
}

/**
 *  日期减去天数，得到新的日期
 *
 *  @param date 日期
 *  @param days 天数
 *
 *  @return 新的日期字符串 yyyy-MM-dd
 */
+(NSString *)getDateStrDiffDate:(NSDate *)date days:(NSInteger)days
{
    NSDate *newDate = [TKDateHelper getDateDiffDate:date days:days];
    return [TKDateHelper formatDate:newDate];
}

/**
 *  日期减去天数，得到新的日期
 *
 *  @param dateStr 日期字符串 yyyy-MM-dd
 *  @param days 天数
 *
 *  @return 新的日期字符串 yyyy-MM-dd
 */
+(NSString *)getDateStrDiffDateStr:(NSString *)dateStr days:(NSInteger)days
{
    NSDate *newDate = [TKDateHelper getDateDiffDateStr:dateStr days:days];
    return [TKDateHelper formatDate:newDate];
}

/**
 *  获取指定日期所在年的第几周
 *
 *  @param date 日期
 *
 *  @return 第几周
 */
+(NSInteger)getWeekNumOfYear:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSWeekOfYearCalendarUnit fromDate:date];
    return components.weekOfYear;
}

/**
 *  获取当前日期所在年的第几周
 *
 *  @param date 日期
 *
 *  @return 第几周
 */
+(NSInteger)getCurrentWeekNumOfYear
{
    return [TKDateHelper getWeekNumOfYear:[NSDate date]];
}

@end
