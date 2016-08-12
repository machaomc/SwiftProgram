//
//  TKNumberHelper.m
//  TKUtil
//
//  Created by liubao on 14-11-5.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import "TKNumberHelper.h"

/**
 *  数字相关帮组类
 */
@implementation TKNumberHelper

/**
 *  格式化小数 xxx,xxx.xx
 *
 *  @param number  小数
 *  @param decimal 保留小数点
 *  @param flag    是否分组显示,
 *
 *  @return 格式化的字符串
 */
+(NSString *)formatNumber:(NSNumber *)number decimal:(NSInteger)decimal groupFlag:(BOOL)flag
{
    NSNumberFormatter *format = [[NSNumberFormatter alloc]init];
    format.numberStyle = NSNumberFormatterDecimalStyle;
    if (decimal > 0)
    {
        format.maximumFractionDigits = decimal;
        format.minimumFractionDigits = decimal;
    }
    format.usesGroupingSeparator = flag;
    return [format stringFromNumber:number];
}

/**
 *  格式化小数 xxxx.xx% 例如0.01 = 1%
 *
 *  @param number  小数
 *  @param decimal 保留小数点
 *
 *  @return 格式化的字符串
 */
+(NSString *)formatPerNumber:(NSNumber *)number decimal:(NSInteger)decimal
{
    NSNumberFormatter *format = [[NSNumberFormatter alloc]init];
    format.numberStyle = NSNumberFormatterPercentStyle;
    if (decimal > 0)
    {
        format.maximumFractionDigits = decimal;
        format.minimumFractionDigits = decimal;
    }
    NSNumber *result = [NSNumber numberWithDouble:number.doubleValue];
    return [format stringFromNumber:result];
}

/**
 *  转换格式化的数字字符串为数字 xxx,xxx.xx
 *
 *  @param numberStr 数字字符串
 *
 *  @return 数字
 */
+(NSNumber *)parseNumberStr:(NSString *)numberStr
{
    NSNumberFormatter *format = [[NSNumberFormatter alloc]init];
    format.numberStyle = NSNumberFormatterDecimalStyle;
    format.usesGroupingSeparator = YES;
    return [format numberFromString:numberStr];
}

/**
 *  格式化金钱小数 ￥xxxx,xxx,xxx.xx
 *
 *  @param number  小数
 *  @param decimal 保留小数点
 *  @param flag    是否分组显示,
 *
 *  @return 格式化的字符串
 */
+(NSString *)formatMoneyNumber:(NSNumber *)number decimal:(NSInteger)decimal groupFlag:(BOOL)flag
{
    NSNumberFormatter *format = [[NSNumberFormatter alloc]init];
    format.numberStyle = NSNumberFormatterCurrencyStyle;
    format.currencySymbol = @"￥";
    if (decimal > 0)
    {
        format.maximumFractionDigits = decimal;
        format.minimumFractionDigits = decimal;
    }
    format.usesGroupingSeparator = flag;
    return [format stringFromNumber:number];
}

/**
 *  转换格式化的金钱字符串为数字 ￥xxxx,xxx,xxx.xx
 *
 *  @param numberStr 数字字符串
 *
 *  @return 数字
 */
+(NSNumber *)parseMoneyNumberStr:(NSString *)numberStr
{
    NSNumberFormatter *format = [[NSNumberFormatter alloc]init];
    format.numberStyle = NSNumberFormatterCurrencyStyle;
    format.currencySymbol = @"￥";
    format.usesGroupingSeparator = YES;
    return [format numberFromString:numberStr];
}

/**
 *  转换格式化的百分号字符串为数据 例如1% = 0.01
 *
 *  @param numberStr 百分号字符串
 *
 *  @return 数字
 */
+(NSNumber *)parsePerNumberStr:(NSString *)numberStr
{
    NSNumberFormatter *format = [[NSNumberFormatter alloc]init];
    format.numberStyle = NSNumberFormatterPercentStyle;
    NSNumber *result = [format numberFromString:numberStr];
    return [NSNumber numberWithDouble:result.doubleValue];
}

@end
