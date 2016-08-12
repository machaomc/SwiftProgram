//
//  DynModel.m
//  TKDataBase_V1
//
//  Created by liubao on 14-11-12.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import "DynModel.h"
#import "NSMutableDictionary+DataRow.h"

/**
 *  动态模型Bean
 */
@implementation DynModel
{
    NSMutableDictionary *_innerMap;
}

/**
 *  初始化
 */
-(id)init
{
    self = [super init];
    if (self)
    {
        _innerMap = [NSMutableDictionary dictionary];
    }
    return self;
}

/**
 *  设置字符串
 *
 *  @param value
 *  @param key
 */
-(void)setString:(NSString *)value withKey:(NSString *)key
{
    [_innerMap setString:value withKey:key];
}

/**
 *  设置Int类型
 *
 *  @param value
 *  @param key
 */
-(void)setInt:(int)value withKey:(NSString *)key
{
    [_innerMap setInt:value withKey:key];
}

/**
 *  设置Long类型
 *
 *  @param value
 *  @param key
 */
-(void)setLong:(long)value withKey:(NSString *)key
{
    [_innerMap setLong:value withKey:key];
}

/**
 *  设置Long Long类型
 *
 *  @param value
 *  @param key
 */
-(void)setLongLong:(long long)value withKey:(NSString *)key
{
    [_innerMap setLongLong:value withKey:key];
}

/**
 *  设置Float类型
 *
 *  @param value
 *  @param key
 */
-(void)setFloat:(float)value withKey:(NSString *)key
{
    [_innerMap setFloat:value withKey:key];
}

/**
 *  设置Double类型
 *
 *  @param value
 *  @param key
 */
-(void)setDouble:(double)value withKey:(NSString *)key
{
    [_innerMap setDouble:value withKey:key];
}

/*
 *  设置数字类型
 *
 *  @param value
 *  @param key
 */
-(void)setInteger:(NSInteger)value withKey:(NSString *)key
{
    [_innerMap setInteger:value withKey:key];
}

/**
 *  设置Number类型
 *
 *  @param value
 *  @param key
 */
-(void)setNumber:(NSNumber *)value withKey:(NSString *)key
{
    [_innerMap setNumber:value withKey:key];
}

/**
 *  设置bool类型
 *
 *  @param value
 *  @param key
 */
-(void)setBool:(BOOL)value withKey:(NSString *)key
{
    [_innerMap setBool:value withKey:key];
}

/**
 *  设置对象
 *
 *  @param obj
 *  @param key
 */
-(void)setObject:(NSObject *)value withKey:(NSString *)key
{
    [_innerMap setObject:value withKey:key];
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
    return [_innerMap getStringWithKey:key];
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
    return [_innerMap getIntWithKey:key];
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
    return [_innerMap getLongWithKey:key];
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
    return [_innerMap getLongLongWithKey:key];
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
    return [_innerMap getFloatWithKey:key];
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
    return [_innerMap getDoubleWithKey:key];
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
    return [_innerMap getIntegerWithKey:key];
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
    return [_innerMap getNumberWithKey:key];
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
    return [_innerMap getBoolWithKey:key];
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
    return [_innerMap getObjectWithKey:key];
}

/**
 *  长度
 */
-(NSUInteger)count
{
    return _innerMap.count;
}

/**
 *  返回所有的内部属性名称
 *
 *  @return 所有的内部属性名称
 */
-(NSArray *)allKeys
{
    return _innerMap.allKeys;
}

/**
 *  返回所有的内部属性值
 *
 *  @return 所有的内部属性值
 */
-(NSArray *)allValues
{
    return _innerMap.allValues;
}

/**
 *  数据字典转DynModel
 */
-(void)setDictionary:(NSMutableDictionary *)dictionary
{
    if (dictionary && dictionary.count > 0)
    {
        [_innerMap removeAllObjects];
        [_innerMap setValuesForKeysWithDictionary:dictionary];
    }
}

/**
 *  DynModel转数据字典
 *
 *  @return 数据字典
 */
-(NSMutableDictionary *)dictionary
{
    return _innerMap;
}

/**
 *  清除所有数据
 */
-(void)clearAll
{
    [_innerMap removeAllObjects];
}

/**
 *  @Author 刘宝, 2015-01-21 14:01:14
 *
 *  归档需要实现的NSCoding接口
 *
 *  @param aCoder
 */
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_innerMap forKey:@"DynModel_innerMap"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        _innerMap = [aDecoder decodeObjectForKey:@"DynModel_innerMap"];
    }
    return self;
}

/**
 *  @Author 刘宝, 2015-01-21 14:01:29
 *
 *  copy需要实现的NSCopying接口
 *
 *  @param zone
 *
 *  @return
 */
-(id)copyWithZone:(NSZone *)zone
{
    DynModel *result = [[[self class] allocWithZone:zone] init];
    result.dictionary = [_innerMap copy];
    return result;
}

/**
 *  @Author 刘宝, 2015-01-21 14:01:52
 *
 *  NSMutableCopying接口
 *
 *  @param zone
 *
 *  @return 
 */
-(id)mutableCopyWithZone:(NSZone *)zone
{
    DynModel *result = [[[self class] allocWithZone:zone] init];
    result.dictionary = [_innerMap mutableCopy];
    return result;
}

@end
