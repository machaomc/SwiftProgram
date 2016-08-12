//
//  NSMutableDictionary+DataRow.m
//  TKDataBase_V1
//
//  Created by liubao on 14-11-14.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import "NSMutableDictionary+DataRow.h"

/**
 *  DataRow
 */
@implementation NSMutableDictionary (DataRow)

/**
 *  判断字符串是否为空
 *
 *  @param str 字符串
 *
 *  @return
 */
+(BOOL)isEmpty:(NSString *)str
{
    NSString *result;
    if (str == nil || str == NULL || [str isKindOfClass:[NSNull class]])
    {
        result = @"";
    }
    else
    {
        str = str.description;
        NSCharacterSet *charSet = [NSCharacterSet whitespaceAndNewlineCharacterSet]; //空格或者回车符号
        result = [str stringByTrimmingCharactersInSet:charSet];
    }
    return (result.length == 0);
}

/**
 *  设置字符串
 *
 *  @param value
 *  @param key
 */
-(void)setString:(NSString *)value withKey:(NSString *)key
{
    if ([NSMutableDictionary isEmpty:value])
    {
        value = @"";
    }
    [self setObject:value withKey:key];
}

/**
 *  设置Int类型
 *
 *  @param value
 *  @param key
 */
-(void)setInt:(int)value withKey:(NSString *)key
{
    [self setObject:[NSNumber numberWithInt:value] withKey:key];
}

/**
 *  设置Long类型
 *
 *  @param value
 *  @param key
 */
-(void)setLong:(long)value withKey:(NSString *)key
{
    [self setObject:[NSNumber numberWithLong:value] withKey:key];
}

/**
 *  设置Long Long类型
 *
 *  @param value
 *  @param key
 */
-(void)setLongLong:(long long)value withKey:(NSString *)key
{
    [self setObject:[NSNumber numberWithLongLong:value] withKey:key];
}

/**
 *  设置Float类型
 *
 *  @param value
 *  @param key
 */
-(void)setFloat:(float)value withKey:(NSString *)key
{
    [self setObject:[NSNumber numberWithFloat:value] withKey:key];
}

/**
 *  设置Double类型
 *
 *  @param value
 *  @param key
 */
-(void)setDouble:(double)value withKey:(NSString *)key
{
    [self setObject:[NSNumber numberWithDouble:value] withKey:key];
}

/*
 *  设置数字类型
 *
 *  @param value
 *  @param key
 */
-(void)setInteger:(NSInteger)value withKey:(NSString *)key
{
    [self setObject:[NSNumber numberWithInteger:value] withKey:key];
}

/**
 *  设置Number类型
 *
 *  @param value
 *  @param key
 */
-(void)setNumber:(NSNumber *)value withKey:(NSString *)key
{
    [self setObject:value withKey:key];
}

/**
 *  设置bool类型
 *
 *  @param value
 *  @param key
 */
-(void)setBool:(BOOL)value withKey:(NSString *)key
{
    [self setObject:[NSNumber numberWithBool:value] withKey:key];
}

/**
 *  设置对象
 *
 *  @param obj
 *  @param key
 */
-(void)setObject:(NSObject *)value withKey:(NSString *)key
{
    if ([NSMutableDictionary isEmpty:key])
    {
        key = @"";
    }
    if (!value)
    {
        value = [NSNull null];
    }
    [self setObject:value forKey:key];
}

/**
 *  获取字符串
 *
 *  @param key
 *
 *  @return
 */
-(NSString *)getStringWithKey:(NSString *)key
{
    NSObject *value = [self getObjectWithKey:key];
    if (value)
    {
        return value.description;
    }
    return @"";
}

/**
 *  获取int
 *
 *  @param key
 *
 *  @return
 */
-(int)getIntWithKey:(NSString *)key
{
    NSObject *value = [self getObjectWithKey:key];
    if (value)
    {
        return value.description.intValue;
    }
    return 0;
}

/**
 *  获取Long
 *
 *  @param key
 *
 *  @return
 */
-(long)getLongWithKey:(NSString *)key
{
    NSObject *value = [self getObjectWithKey:key];
    if (value)
    {
        return value.description.integerValue;
    }
    return 0;
}

/**
 *  获取Long Long
 *
 *  @param key
 *
 *  @return
 */
-(long long)getLongLongWithKey:(NSString *)key
{
    NSObject *value = [self getObjectWithKey:key];
    if (value)
    {
        return value.description.longLongValue;
    }
    return 0;
}

/**
 *  获取float
 *
 *  @param key
 *
 *  @return
 */
-(float)getFloatWithKey:(NSString *)key
{
    NSObject *value = [self getObjectWithKey:key];
    if (value)
    {
        return value.description.floatValue;
    }
    return 0;
}

/**
 *  获取double
 *
 *  @param key
 *
 *  @return
 */
-(double)getDoubleWithKey:(NSString *)key
{
    NSObject *value = [self getObjectWithKey:key];
    if (value)
    {
        return value.description.doubleValue;
    }
    return 0;
    
}

/**
 *  获取数字
 *
 *  @param key
 *
 *  @return
 */
-(NSInteger)getIntegerWithKey:(NSString *)key
{
    NSObject *value = [self getObjectWithKey:key];
    if (value)
    {
        return value.description.integerValue;
    }
    return 0;
}

/**
 *  获取Number
 *
 *  @param key
 *
 *  @return
 */
-(NSNumber *)getNumberWithKey:(NSString *)key
{
    NSObject *value = [self getObjectWithKey:key];
    if (value)
    {
        return [NSNumber numberWithDouble:value.description.doubleValue];
    }
    return nil;
}

/**
 *  获取Bool
 *
 *  @param key
 *
 *  @return
 */
-(BOOL)getBoolWithKey:(NSString *)key
{
    NSObject *value = [self getObjectWithKey:key];
    if (value)
    {
        return value.description.boolValue;
    }
    return NO;
}

/**
 *  获取对象
 *
 *  @param key
 *
 *  @return
 */
-(NSObject *)getObjectWithKey:(NSString *)key
{
    if ([NSMutableDictionary isEmpty:key])
    {
        return nil;
    }
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSObject class]])
    {
        return (NSObject *)value;
    }
    return nil;
}

@end
