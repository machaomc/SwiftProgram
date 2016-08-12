//
//  TKStringHelper.m
//  TKUtil
//
//  Created by liubao on 14-10-31.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import "TKStringHelper.h"

/**
 *  字符串帮助类
 */
@implementation TKStringHelper

/**
 *  判断字符串是否为空，空格也算空
 *
 *  @param str 需要判断的字符串
 *
 *  @return YES,NO
 */
+(BOOL)isEmpty:(NSString *)str
{
    return ([TKStringHelper stringWithTrim:str].length == 0);
}

/**
 *  判断字符串是否为非空
 *
 *  @param str 需要判断的字符串
 *
 *  @return YES,NO
 */
+(BOOL)isNotEmpty:(NSString *)str
{
    return ([TKStringHelper stringWithTrim:str].length > 0);
}

/**
 *  产生num位随机数
 *
 *  @param num 随机数的位数
 *
 *  @return 生成的随机数
 */
+(NSString *)stringWithRandom:(NSInteger)num
{
    unichar *data = malloc(sizeof(unichar) * num);
    for (NSInteger x = 0; x < num; x ++)
    {
        NSInteger j = '0' + arc4random_uniform(10);
        data[x] = (unichar)j;
    }
    return [NSString stringWithCharacters:data length:num];
}

/**
 *  全部替换字符串，支持正则表达式
 *
 *  @param source 原字符串
 *  @param oldStr 需要替换的字符串，支持正则表达式
 *  @param newStr 用来替换的字符串
 *
 *  @return 替换后新的字符串
 */
+(NSString *)stringWithReplace:(NSString *)srcStr oldStr:(NSString *)oldStr newStr:(NSString *)newStr
{
    if (srcStr && oldStr)
    {
        NSError * error;
        //创建正则表达式
        NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:oldStr options:NSRegularExpressionCaseInsensitive error:&error];
        if (regExp)
        {
            //根据正则表达式替换
            return [regExp stringByReplacingMatchesInString:srcStr options:0 range:NSMakeRange(0, srcStr.length) withTemplate:newStr];
        }
        else
        {
            NSLog(@"创建正则表达式错误！[%@:%@]",oldStr,error.description);
            return [srcStr stringByReplacingOccurrencesOfString:oldStr withString:newStr];
        }
    }
    else
    {
        if (srcStr)
        {
            return srcStr;
        }
        return @"";
    }
}

/**
 *  全部替换字符串，支持正则表达式
 *
 *  @param source 原字符串
 *  @param oldStr 需要替换的字符串，支持正则表达式
 *  @param block  用于处理替换的块函数 NSString* ^(NSString*,NSInteger)
 *
 *  @return 替换后新的字符串
 */
+(NSString *)stringWithReplace:(NSString *)srcStr oldStr:(NSString *)oldStr block:(ReplaceBlock)block
{
    if (srcStr && oldStr && block)
    {
        NSError * error;
        //创建正则表达式
        NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:oldStr options:NSRegularExpressionCaseInsensitive error:&error];
        if (regExp)
        {
            //根据正则表达式替换
            //获取旧字符串匹配的数组结果
            NSArray *checkResultArray = [regExp matchesInString:srcStr options:0 range:NSMakeRange(0, srcStr.length)];
            //循环遍历，根据分割符号的位置截取字符串
            if (checkResultArray && checkResultArray.count > 0)
            {
                //存储最后返回的数组结果
                NSMutableArray *resultStrAry = [NSMutableArray array];
                //索引
                NSInteger index = 0;
                for (NSInteger i = 0; i < checkResultArray.count; i ++)
                {
                    NSTextCheckingResult *checkResult = [checkResultArray objectAtIndex:i];
                    //分割符号的位置区域
                    NSRange splitStrRange = [checkResult range];
                    //根据分隔符截取的区域
                    NSRange resultStrRange = NSMakeRange(index, splitStrRange.location-index);
                    //获取区域内的字符串
                    NSString *resultStr = [srcStr substringWithRange:resultStrRange];
                    //调整索引值
                    index = splitStrRange.location + splitStrRange.length;
                    //加入最终的数组
                    [resultStrAry addObject:resultStr];
                    
                    //匹配上的字符串
                    NSString *replaceStr = [srcStr substringWithRange:splitStrRange];
                    //被替换的字符串
                    NSString *replacedStr = block(replaceStr,i);
                    //加入最终的数值
                    [resultStrAry addObject:replacedStr];
                }
                //获取分隔符后面最后一个字符串
                if (index <= srcStr.length)
                {
                    NSRange resultStrRange = NSMakeRange(index, srcStr.length - index);
                    NSString *resultStr = [srcStr substringWithRange:resultStrRange];
                    [resultStrAry addObject:resultStr];
                }
                return [resultStrAry componentsJoinedByString:@""];
            }
            else
            {
                return srcStr;
            }
        }
        else
        {
            NSLog(@"创建正则表达式错误！[%@:%@]",oldStr,error.description);
            return @"";
        }
    }
    else
    {
        if (srcStr)
        {
            return srcStr;
        }
        return @"";
    }
}

/**
 * 去掉两边的空格，如果入参是nil自动转换为空字符串
 *
 *  @param str 需要操作的字符串
 *
 *  @return
 */
+(NSString *)stringWithTrim:(NSString *)str
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
        result = [self stringWithReplace:result oldStr:@"\0" newStr:@""];
    }
    return result;
}

/**
 *  判断字符串是否以指定的字符串开头
 *
 *  @param source 源字符串
 *  @param str    要判断的字符串的值
 *
 *  @return YES,NO
 */
+(BOOL)string:(NSString *)srcStr beginWith:(NSString *)str
{
    if(srcStr && str)
    {
        return [srcStr hasPrefix:str];
    }
    return NO;
}

/**
 *  判断字符串是否以指定的字符串结尾
 *
 *  @param source 源字符串
 *  @param str    要判断的字符串的值
 *
 *  @return YES,NO
 */
+(BOOL)string:(NSString *)srcStr endWith:(NSString *)str
{
    if(srcStr && str)
    {
        return [srcStr hasSuffix:str];
    }
    return NO;
}

/**
 *  查找字符串
 *
 *  @param srcStr 原字符串
 *  @param str    要查找的字符串
 *
 *  @return 返回字符串的位置，没有返回-1
 */

+(NSInteger) string:(NSString *)srcStr indexOf:(NSString *)str
{
    if (srcStr && str)
    {
        NSRange range = [srcStr rangeOfString:str];
        if (range.length > 0)
        {
            return range.location;
        }
        return -1;
    }
    return -1;
}

/**
 *  查找最后匹配的字符串
 *
 *  @param srcStr 原字符串
 *  @param str    要查找的字符串
 *
 *  @return 返回字符串的位置，没有返回-1
 */
+(NSInteger)string:(NSString *)srcStr lastIndexOf:(NSString *)str
{
    if (srcStr && str)
    {
        NSError *error;
        //匹配分割符号的正则表达式
        NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:str options:NSRegularExpressionCaseInsensitive error:&error];
        if (regExp)
        {
            //获取分割符号匹配的数组结果
            NSArray *checkResultArray = [regExp matchesInString:srcStr options:0 range:NSMakeRange(0, srcStr.length)];
            //循环遍历，根据分割符号的位置截取字符串
            if (checkResultArray && checkResultArray.count > 0)
            {
                NSTextCheckingResult *checkResult = checkResultArray[checkResultArray.count - 1];
                //查找字符串的最后位置区域
                NSRange strRange = [checkResult range];
                if (strRange.length > 0)
                {
                    return strRange.location;
                }
                return -1;
            }
            else
            {
                return -1;
            }
        }
        else
        {
            NSLog(@"创建正则表达式错误！[%@:%@]",str,error.description);
            return -1;
        }
    }
    else
    {
        return -1;
    }
}

/**
 *  截取字符串
 *
 *  @param source 原字符串
 *  @param begin  开始索引
 *  @param end    结束索引
 *
 *  @return 截取的字符串
 */
+(NSString *)subStringWith:(NSString *)srcStr fromIndex:(NSInteger)begin toIndex:(NSInteger)end
{
    if (srcStr)
    {
        return [srcStr substringWithRange:NSMakeRange(begin, end-begin)];
    }
    return @"";
}

/**
 *  截取字符串
 *
 *  @param source 原字符串
 *  @param begin  开始索引
 *  @param count  截取的数目
 *
 *  @return 截取的字符串
 */
+(NSString *)subStringWith:(NSString *)srcStr fromIndex:(NSInteger)begin count:(NSInteger)count
{
    if (srcStr)
    {
        return [srcStr substringWithRange:NSMakeRange(begin, count)];
    }
    return @"";
}

/**
 *  分割字符串,分隔符支持正则表达式
 *
 *  @param srcStr 原字符串
 *  @param str    分割符,支持正则表达式
 *
 *  @return 字符串数组
 */
+(NSArray *)string:(NSString *)srcStr splitWith:(NSString *)str;
{
    if (srcStr && str)
    {
        NSError *error;
        //匹配分割符号的正则表达式
        NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:str options:NSRegularExpressionCaseInsensitive error:&error];
        if (regExp)
        {
            //获取分割符号匹配的数组结果
            NSArray *checkResultArray = [regExp matchesInString:srcStr options:0 range:NSMakeRange(0, srcStr.length)];
            //循环遍历，根据分割符号的位置截取字符串
            if (checkResultArray && checkResultArray.count > 0)
            {
                //存储最后返回的数组结果
                NSMutableArray *resultStrAry = [NSMutableArray array];
                //索引
                NSInteger index = 0;
                for (NSTextCheckingResult *checkResult in checkResultArray)
                {
                    //分割符号的位置区域
                    NSRange splitStrRange = [checkResult range];
                    //根据分隔符截取的区域
                    NSRange resultStrRange = NSMakeRange(index, splitStrRange.location-index);
                    //获取区域内的字符串
                    NSString *resultStr = [srcStr substringWithRange:resultStrRange];
                    //调整索引值
                    index = splitStrRange.location + splitStrRange.length;
                    //加入最终的数组
                    [resultStrAry addObject:resultStr];
                }
                //获取分隔符后面最后一个字符串
                if (index <= srcStr.length)
                {
                    NSRange resultStrRange = NSMakeRange(index, srcStr.length - index);
                    NSString *resultStr = [srcStr substringWithRange:resultStrRange];
                    [resultStrAry addObject:resultStr];
                }
                return resultStrAry;
            }
            else
            {
                return [srcStr componentsSeparatedByString:str];
            }
        }
        else
        {
            NSLog(@"创建正则表达式错误！[%@:%@]",str,error.description);
            return [srcStr componentsSeparatedByString:str];
        }
    }
    else
    {
        if (srcStr)
        {
            return [NSArray arrayWithObjects:srcStr, nil];
        }
        return nil;
    }
}

/**
 *  字符串数组链接
 *
 *  @param array 字符串数组
 *
 *  @return 链接后的字符串
 */
+(NSString *)stringWithArray:(NSArray *)array;
{
    if (array)
    {
        return [array componentsJoinedByString:@""];
    }
    return @"";
}

/**
 *  获取Url的参数
 *
 *  @param url 地址
 *
 *  @return 参数数据字典
 */
+(NSDictionary *)getUrlParam:(NSString *)url
{
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
    NSString *regex = @".*\\?";
    NSString *urlStr = [TKStringHelper stringWithReplace:url oldStr:regex newStr:@""];
    if ([TKStringHelper string:urlStr indexOf:@"="] > -1)
    {
        // 通过&拆分成数组name=value，保存为String类型数据
        NSArray *params = [TKStringHelper string:urlStr splitWith:@"&"];
        if (params && params.count > 0)
        {
            for (NSString *paramStr in params)
            {
                NSArray *param = [TKStringHelper string:paramStr splitWith:@"="];
                if (param && param.count >= 2)
                {
                    NSString *key = [param objectAtIndex:0];
                    NSString *value = [param objectAtIndex:1];
                    [resultDic setObject:value forKey:key];
                }
                else
                {
                    [resultDic setObject:@"" forKey:paramStr];
                }
            }
        }
    }
    return resultDic;
}

/**
 *  根据正则表达式找到第一个满足的子串
 *
 *  @param srcStr 原字符串
 *  @param regExp 正则表达式
 *
 *  @return 子字符串
 */
+(NSString *)firstSubStringWith:(NSString *)srcStr byRegExp:(NSString *)regExpStr
{
    NSString *resultStr = @"";
    if (srcStr && regExpStr)
    {
        NSError * error;
        //创建正则表达式
        NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:regExpStr options:NSRegularExpressionCaseInsensitive error:&error];
        if (regExp)
        {
            //根据正则表达式替换
            //获取旧字符串匹配的数组结果
            NSArray *checkResultArray = [regExp matchesInString:srcStr options:0 range:NSMakeRange(0, srcStr.length)];
            //循环遍历，根据分割符号的位置截取字符串
            if (checkResultArray && checkResultArray.count > 0)
            {
                NSTextCheckingResult *checkResult = [checkResultArray objectAtIndex:0];
                //字符串位置区域
                NSRange resultStrRange = [checkResult range];
                //获取区域内的字符串
                resultStr = [srcStr substringWithRange:resultStrRange];
            }
        }
        else
        {
            NSLog(@"创建正则表达式错误！[%@:%@]",regExpStr,error.description);
        }
    }
    return resultStr;
}

/**
 *  根据正则表达式找到最后一个满足的子串
 *
 *  @param srcStr 原字符串
 *  @param regExp 正则表达式
 *
 *  @return 子字符串
 */
+(NSString *)lastSubStringWith:(NSString *)srcStr byRegExp:(NSString *)regExpStr
{
    NSString *resultStr = @"";
    if (srcStr && regExpStr)
    {
        NSError * error;
        //创建正则表达式
        NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:regExpStr options:NSRegularExpressionCaseInsensitive error:&error];
        if (regExp)
        {
            //根据正则表达式替换
            //获取旧字符串匹配的数组结果
            NSArray *checkResultArray = [regExp matchesInString:srcStr options:0 range:NSMakeRange(0, srcStr.length)];
            //循环遍历，根据分割符号的位置截取字符串
            if (checkResultArray && checkResultArray.count > 0)
            {
                NSTextCheckingResult *checkResult = [checkResultArray objectAtIndex:(checkResultArray.count - 1)];
                //字符串位置区域
                NSRange resultStrRange = [checkResult range];
                //获取区域内的字符串
                resultStr = [srcStr substringWithRange:resultStrRange];
            }
        }
        else
        {
            NSLog(@"创建正则表达式错误！[%@:%@]",regExpStr,error.description);
        }
    }
    return resultStr;
}

/**
 *  根据正则表达式找到所有满足的字符串
 *
 *  @param srcStr 原字符串
 *  @param regExp 正则表达式
 *
 *  @return 子字符串数组
 */
+(NSArray *)subStringsWith:(NSString *)srcStr byRegExp:(NSString *)regExpStr
{
    NSMutableArray *resultStrAry;
    if (srcStr && regExpStr)
    {
        NSError * error;
        //创建正则表达式
        NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:regExpStr options:NSRegularExpressionCaseInsensitive error:&error];
        if (regExp)
        {
            //根据正则表达式替换
            //获取旧字符串匹配的数组结果
            NSArray *checkResultArray = [regExp matchesInString:srcStr options:0 range:NSMakeRange(0, srcStr.length)];
            //循环遍历，根据分割符号的位置截取字符串
            if (checkResultArray && checkResultArray.count > 0)
            {
                //存储最后返回的数组结果
                resultStrAry = [NSMutableArray array];
                //索引
                for (NSInteger i = 0; i < checkResultArray.count; i ++)
                {
                    NSTextCheckingResult *checkResult = [checkResultArray objectAtIndex:i];
                    //字符串位置区域
                    NSRange resultStrRange = [checkResult range];
                    //获取区域内的字符串
                    NSString *resultStr = [srcStr substringWithRange:resultStrRange];
                    //加入最终的数组
                    [resultStrAry addObject:resultStr];
                }
            }
        }
        else
        {
            NSLog(@"创建正则表达式错误！[%@:%@]",regExpStr,error.description);
        }
    }
    return resultStrAry;
}

/**
 *  URL编码
 *
 *  @param url
 *
 *  @return utf-8编码的结果
 */
+(NSString *)encodeURL:(NSString *)url
{
    if (url)
    {
        NSString *encodedString =
        //CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(nil,(CFStringRef)url,nil,
        //                                        (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
        //                                        kCFStringEncodingUTF8));
        CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(nil,(CFStringRef)url,nil,
                                                                  (CFStringRef)@"$'()*+,@~%#[]",
                                                                  kCFStringEncodingUTF8));
        encodedString = [self stringWithReplace:encodedString oldStr:@"%23" newStr:@"#"];
        return encodedString;
    }
    return @"";
}

/**
 *  URL解码
 *
 *  @param url
 *
 *  @return utf-8解码的结果
 */
+(NSString *)decodeURL:(NSString *)url
{
    if (url)
    {
        NSString *encodedString =
        CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(nil, (CFStringRef)url, (CFStringRef)@"", kCFStringEncodingUTF8));
        return encodedString;
    }
    return @"";
}

/**
 *  @Author 刘宝, 2015-04-20 10:04:15
 *
 *  UTF-8转Unicode
 *
 *  @param str 字符串
 *
 *  @return Unicode字符串
 */
+(NSString *)utfToUnicode:(NSString *)str
{
    NSUInteger length = [str length];
    NSMutableString *s = [NSMutableString stringWithCapacity:0];
    for (int i = 0; i < length; i ++)
    {
        unichar _char = [str characterAtIndex:i];
        //判断是否为英文和数字
        if (_char <= '9' && _char >= '0')
        {
            [s appendFormat:@"%@",[str substringWithRange:NSMakeRange(i, 1)]];
        }
        else if(_char >= 'a' && _char <= 'z')
        {
            [s appendFormat:@"%@",[str substringWithRange:NSMakeRange(i, 1)]];
        }
        else if(_char >= 'A' && _char <= 'Z')
        {
            [s appendFormat:@"%@",[str substringWithRange:NSMakeRange(i, 1)]];
        }
        else
        {
            [s appendFormat:@"\\u%x",[str characterAtIndex:i]];
        }
    }
    return s;
}

/**
 *  @Author 刘宝, 2015-04-20 10:04:16
 *
 *  Unicode转成UTF-8
 *
 *  @param str 字符串
 *
 *  @return UTF-8
 */
+(NSString *)unicodeToUTF:(NSString *)str
{
    NSString *tempStr1 = [str stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

@end
