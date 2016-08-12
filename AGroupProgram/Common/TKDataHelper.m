//
//  TKDataHelper.m
//  TKUtil
//
//  Created by liubao on 14-10-31.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import "TKDataHelper.h"
#import "XMLParser.h"
#import "TKStringHelper.h"
#import "XMLDictionary.h"
#import <objc/runtime.h>

/**
 *  数据转换帮组类
 */
@implementation TKDataHelper

/**
 *  NSString* 转 NSData*
 *
 *  @param string NSString*
 *
 *  @return NSData*
 */
+(NSData *)stringToData:(NSString *)string
{
    return [string dataUsingEncoding:NSUTF8StringEncoding];
}

/**
 *  NSData* 转 NSString*
 *
 *  @param data NSData*
 *
 *  @return NSString*
 */
+(NSString *)dataToString:(NSData *)data
{
    if (data && data.length > 0)
    {
        return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    }
    return @"";
}

/**
 *  NSString* 转 char *
 *
 *  @param string NSString*
 *
 *  @return char*
 */
+(const char *)stringToChars:(NSString *)string
{
    if ([TKStringHelper isEmpty:string])
    {
        string = @"";
    }
    return [string UTF8String];
}

/**
 *  char* 转 NSString*
 *
 *  @param chars char*
 *
 *  @return NSString
 */
+(NSString *)charsToString:(char *)chars
{
    if (chars && strlen(chars) > 0)
    {
        return [NSString stringWithUTF8String:chars];
    }
    return @"";
}

/**
 *  NSData* 转 char*
 *
 *  @param data NSData*
 *
 *  @return char*
 */
+(char *)dataToChars:(NSData *)data
{
    if (data && data.length > 0)
    {
        return (char *)[data bytes];
    }
    return (char *)[[NSData data] bytes];
}

/**
 *  char* 转 NSData*
 *
 *  @param chars char*
 *
 *  @return NSData*
 */
+(NSData *)charsToData:(char *)chars
{
    if (chars && strlen(chars) > 0)
    {
        return [NSData dataWithBytes:chars length:strlen(chars)];
    }
    return [NSData data];
}

/**
 *  xml转json
 *
 *  @param xml xml字符串
 *
 *  @return json字符串
 */
+(NSString *)xmlToJson:(NSString *)xml
{
    if ([TKStringHelper isNotEmpty:xml])
    {
        NSDictionary *dic = [TKDataHelper xmlToDictionary:xml];
        return [TKDataHelper dictionaryToJson:dic];
    }
    return @"";
}

/**
 *  json转Xml
 *
 *  @param json json字符串
 *
 *  @return xml字符串
 */
+(NSString *)jsonToXml:(NSString *)json
{
    if ([TKStringHelper isNotEmpty:json])
    {
        NSDictionary *dic = [TKDataHelper jsonToDictionary:json];
        return [TKDataHelper dictionaryToXml:dic];
    }
    return @"";
}

/**
 *  json转数据字典
 *
 *  @param json json字符串
 *
 *  @return 数据字典
 */
+(NSDictionary *)jsonToDictionary:(NSString *)json
{
    NSObject *obj = [TKDataHelper jsonToObject:json];
    if ([obj isKindOfClass:[NSDictionary class]])
    {
        return (NSDictionary *)obj;
    }
    return nil;
}

/**
 *  json转对象
 *
 *  @param json json字符串
 *
 *  @return 对象
 */
+(NSObject *)jsonToObject:(NSString *)json
{
    if ([TKStringHelper isNotEmpty:json])
    {
        NSData * data = [json dataUsingEncoding:NSUTF8StringEncoding];
        NSError *parseError = nil;
        NSObject *obj = (NSObject *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&parseError];
        if (parseError)
        {
            NSLog(@"json转对象失败!%@",parseError);
            return nil;
        }
        return obj;
    }
    return nil;
}

/**
 *  @Author 刘宝, 2014-11-27 11:11:00
 *
 *  json转数组
 *
 *  @param json json字符串
 *
 *  @return 数组
 */
+(NSArray *)jsonTOArray:(NSString *)json
{
    NSObject *obj = [TKDataHelper jsonToObject:json];
    if ([obj isKindOfClass:[NSArray class]])
    {
        return (NSArray *)obj;
    }
    return nil;
}

/**
 *  数据字典转json
 *
 *  @param dic 数据字典
 *
 *  @return json字符串
 */
+(NSString *)dictionaryToJson:(NSDictionary *)dic
{
    if (dic && dic.count > 0)
    {
        return [TKDataHelper objectToJson:dic];
    }
    return @"";
}

/**
 *  @Author 刘宝, 2014-11-27 11:11:00
 *
 *  对象转json
 *
 *  @param obj 对象
 *
 *  @return json字符串
 */
+(NSString *)objectToJson:(NSObject *)obj
{
    if (obj)
    {
        NSError *parseError = nil;
        NSData *data = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&parseError];
        if (parseError)
        {
            NSLog(@"对象转json格式失败!%@",parseError);
            return @"";
        }
        return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    }
    return @"";
}

/**
 *  @Author 刘宝, 2014-11-27 11:11:05
 *
 *  数组转json
 *
 *  @param jsonArray 数据字典数组
 *
 *  @return json字符串
 */
+(NSString *)arrayToJson:(NSArray *)jsonArray
{
    if (jsonArray && jsonArray.count > 0)
    {
        return [TKDataHelper objectToJson:jsonArray];
    }
    return @"";
}

/**
 *  xml转数据字典
 *
 *  @param xml xml字符串
 *
 *  @return 数据字典
 */
+(NSDictionary *)xmlToDictionary:(NSString *)xml
{
    if ([TKStringHelper isNotEmpty:xml])
    {
        NSDictionary *xmlDictionary = [NSDictionary dictionaryWithXMLString:xml];
        return xmlDictionary;
    }
    return [NSMutableDictionary dictionary];
}

/**
 *  数据字典转xml
 *
 *  @param dic 数据字典
 *
 *  @return xml字符串
 */
+(NSString *)dictionaryToXml:(NSDictionary *)dic
{
    if (dic && dic.count > 0)
    {
       return [dic XMLString];
    }
    return @"";
}

/**
 *  xml转成树
 *
 *  @param xml xml数据
 *
 *  @return 树
 */
+(TreeNode *)xmlToTreeNode:(NSString *)xml
{
    if ([TKStringHelper isNotEmpty:xml])
    {
        NSData *data = [xml dataUsingEncoding:NSUTF8StringEncoding];
        return [[XMLParser sharedInstance]parseXMLFromData:data];
    }
    return nil;
}

/**
 *  树转xml
 *
 *  @param treeNode 树
 *
 *  @return xml数据
 */
+(NSString *)treeNodeToXml:(TreeNode *)treeNode
{
    if (treeNode)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [TKDataHelper treeNode:treeNode ToDictionary:&dic hasRoot:NO];
        return [TKDataHelper dictionaryToXml:dic];
    }
    return @"";
}

 /**
 *  树转数据字典
 *
 *  @param treeNode 树
 *  @param dic  数据字典
 *  @param flag 是否包含当前根节点
 */
+(void)treeNode:(TreeNode *)treeNode ToDictionary:(NSMutableDictionary **)dic hasRoot:(BOOL)flag
{
    if (treeNode)
    {
        if (dic == NULL || *dic == nil)
        {
            *dic = [NSMutableDictionary dictionary];
        }
        if ([treeNode isLeaf])
        {
            [*dic setObject:treeNode.leafvalue forKey:treeNode.key];
        }
        else
        {
            NSMutableDictionary *childDic ;
            if (flag)
            {
                childDic = [treeNode dictionaryForChildren];
                //这个取出来的只是叶子节点构成的数据字典，其他节点需要递归获取
                [*dic setObject:childDic forKey:treeNode.key];
            }
            else
            {
                *dic = [treeNode dictionaryForChildren];
                childDic = *dic;
            }
            NSArray *childs = [treeNode children];
            for (TreeNode *child in childs)
            {
                if (!child.isLeaf)
                {
                    [TKDataHelper treeNode:child ToDictionary:&childDic hasRoot:YES];
                }
            }
        }
    }
}

/**
 * 复制数据字典到另外一个数据字典
 *
 *  @param srcDic  源数据字典
 *  @param destDic 目标数据字典
 *  @param flag    是否强复制，NO:只有替换的字段的值不为空，才替换，否则保留原来的值 YES:全部复制替换
 */
+(void) copyDictionay:(NSDictionary *)srcDic toDictionary:(NSMutableDictionary *)destDic isStrong:(BOOL)flag
{
    if (srcDic && destDic)
    {
        for (NSString *key in [srcDic allKeys])
        {
            NSString *temp = [srcDic objectForKey:key];
            if (flag)
            {
                [destDic setObject:temp forKey:key];
            }
            else
            {
                if ([TKStringHelper isNotEmpty:temp])
                {
                    [destDic setObject:temp forKey:key];
                }
            }
        }
    }
}

/**
 *  数据字典转字符串
 *
 *  @param dic    要转换的数据字典
 *  @param split0 第一层分割符号   ,
 *  @param split1 第二层分隔符    =
 *
 *  @return 转换后的字符串 name=liubao,age=20,lover=xiaozhu
 */
+(NSString *)dictionayToString:(NSDictionary *)dic firstSplit:(NSString *)split0 secondSplit:(NSString *)split1
{
    NSMutableArray *result = [NSMutableArray array];
    if(dic != nil && dic != NULL)
    {
        for(NSString *key in [dic allKeys])
        {
            NSString *value = [dic objectForKey:key];
            if([TKStringHelper isEmpty:value])
            {
                value = @"";
            }
            [result addObject:[[key stringByAppendingString:split1]stringByAppendingString:value]];
        }
    }
    return [result componentsJoinedByString:split0];
}

/**
 *  字符串转成对象
 *
 *  @param str    要转换的字符串 例如name=liubao,age=20,lover=xiaozhu
 *  @param split0 第一层分割符号  ,
 *  @param split1 第二层分隔符    =
 *
 *  @return 转换后的数据字典
 */
+(NSDictionary *)stringToDictionay:(NSString *)str firstSplit:(NSString *)split0 secondSplit:(NSString *)split1
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    if ([TKStringHelper isNotEmpty:str] && [TKStringHelper isNotEmpty:split0] && [TKStringHelper isNotEmpty:split1])
    {
        NSArray *first = [TKStringHelper string:str splitWith:split0];
        if (first && first.count > 0)
        {
            for (NSString *temp in first)
            {
                NSArray *second = [TKStringHelper string:temp splitWith:split1];
                if (second && second.count == 2)
                {
                    [result setObject:[second objectAtIndex:1] forKey:[second objectAtIndex:0]];
                }
            }
        }
    }
    return result;
}

/**
 *  对象转成数据字典
 *
 *  @param obj 对象
 *
 *  @return 数据字典
 */
+(NSDictionary *)objectToDictionary:(NSObject *)obj
{
    if (obj)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        unsigned int propsCount;
        objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
        for(int i = 0;i < propsCount; i ++)
        {
            objc_property_t prop = props[i];
            NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
            id value = [obj valueForKey:propName];
            if(value == nil)
            {
                value = [NSNull null];
            }
            else
            {
                value = [TKDataHelper getObjectInternal:value];
            }
            [dic setObject:value forKey:propName];
        }
        free(props);
        return dic;
    }
    return nil;
}

/**
 *  获取objc对象
 *
 *  @param obj id对象
 *
 *  @return objc对象
 */
+ (id)getObjectInternal:(id)obj
{
    if (obj)
    {
        if([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSNull class]])
        {
            return obj;
        }
        if([obj isKindOfClass:[NSArray class]])
        {
            NSArray *objarr = obj;
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
            for(int i = 0;i < objarr.count; i ++)
            {
                [arr setObject:[TKDataHelper getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
            }
            return arr;
        }
        
        if([obj isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *objdic = obj;
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
            for(NSString *key in objdic.allKeys)
            {
                [dic setObject:[TKDataHelper getObjectInternal:[objdic objectForKey:key]] forKey:key];
            }
            return dic;
        }
        return [TKDataHelper objectToDictionary:obj];
    }
    return [NSNull null];
}

/**
 *  数据字典转成对象
 *
 *  @param srcDic  数据字典
 *  @param destObj 目标对象
 */
+(void)dictionary:(NSDictionary *)srcDic ToObject:(NSObject *)destObj
{
    unsigned int outCount, i;
    Class c = [destObj class];
    objc_property_t *properties = class_copyPropertyList(c, &outCount);
    for (i = 0; i < outCount; i ++)
    {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        NSString *propertyType = [NSString stringWithUTF8String:property_getAttributes(property)];
        if ([[srcDic allKeys] containsObject:propertyName])
        {
            id value = [srcDic valueForKey:propertyName];
            if (![value isKindOfClass:[NSNull class]] && value != nil)
            {
                if ([value isKindOfClass:[NSDictionary class]])
                {
                    NSString *className = [TKDataHelper getClassNameFromObjectAttrType:propertyType];
                    id pro = [TKDataHelper getClassInstanceByName:className];
                    [TKDataHelper dictionary:value ToObject:pro];
                    [destObj setValue:pro forKey:propertyName];
                }
                else
                {
                    [destObj setValue:value forKey:propertyName];
                }
            }
        }
    }
    free(properties);
}

/**
 *  根据对象的属性类型获取类名
 *
 *  @param attrType 属性
 *
 *  @return 类名
 */
+(NSString *)getClassNameFromObjectAttrType:(NSString *)attrType
{
    NSString *str = [TKStringHelper firstSubStringWith:attrType byRegExp:@"\"\\w+\""];
    if (str && str.length > 2)
    {
        str = [TKStringHelper subStringWith:str fromIndex:1 count:(str.length - 1)];
    }
    return str;
}

/**
 *  根据类名得到类的实例
 *
 *  @param className 类名
 *
 *  @return 实例
 */
+(id) getClassInstanceByName: (NSString *)className
{
    Class aClass = NSClassFromString(className);
    if (aClass)
    {
        id anInstance = [[aClass alloc] init];
        return anInstance;
    }
    return nil;
}

//{
//    if (!destObj)
//    {
//        return;
//    }
//    // 本类的类名
//    Class c = [destObj class];
//    while (c)
//    {
//        // 获得本类 所有的成员变量
//        unsigned int outCount = 0;
//        Ivar *ivars = class_copyIvarList(c, &outCount);
//        for (int i = 0; i < outCount; i ++)
//        {
//            // 属性名
//            Ivar ivar = ivars[i];
//            NSMutableString *name = [NSMutableString stringWithUTF8String:ivar_getName(ivar)];
//            // 删除最前面的_
//            if ([name hasPrefix:@"_"])
//            {
//                [name replaceCharactersInRange:NSMakeRange(0, 1) withString:@""];
//            }
//            // 取出属性值
//            NSString *key = name;
//            if ([key isEqualToString:@"desc"])
//            {
//                key = @"description";
//            }
//            if ([key isEqualToString:@"ID"])
//            {
//                key = @"id";
//            }
//            // 取出参数字典中对应的值
//            id value = dict[key];
//            // 健壮性判断,如果字典中没有这个键对应的值,则进入下一次for循环
//            if (!value)
//            {
//                continue;
//            }
//            //构造SEL
//            // 首字母
//            NSString *cap = [name substringToIndex:1];
//            // 首字母变大写
//            cap = cap.uppercaseString;
//            // 将大写字母调换掉原首字母
//            [name replaceCharactersInRange:NSMakeRange(0, 1) withString:cap];
//            // 拼接set
//            [name insertString:@"set" atIndex:0];
//            // 拼接冒号:
//            [name appendString:@":"];
//            SEL selector = NSSelectorFromString(name);
//            // 属性类型,如果是基本类型,要转成对象
//            NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
//            if ([type hasPrefix:@"@"])
//            {
//                // 若为对象类型,直接发送消息
//                objc_msgSend(self, selector, value);
//            }
//            else
//            {
//                // 若为非对象类型,即基本对象类型,则要转成对象类型
//                if ([type isEqualToString:@"d"])
//                {
//                    objc_msgSend(self, selector, [value doubleValue]);
//                }
//                else if ([type isEqualToString:@"f"])
//                {
//                    objc_msgSend(self, selector, [value floatValue]);
//                }
//                else if ([type isEqualToString:@"i"])
//                {
//                    objc_msgSend(self, selector, [value intValue]);
//                }else
//                {
//                    objc_msgSend(self, selector, [value longLongValue]);
//                }
//            }
//        }
//        // for循环遍历完了本类中所有的成员之后,获取其父类继续上述操作,直至其父类为空
//        c = class_getSuperclass(c);
//    }
//}


/**
 *  @Author 刘宝, 2015-04-22 16:04:00
 *
 *  图片转数据
 *
 *  @param image      图片
 *  @param imageType  图片类型
 *  @param compress   压缩率
 *
 *  @return 数据
 */
+(NSData *)imageToData:(UIImage *)image imageType:(ImageType)imageType compress:(CGFloat)compress
{
    NSData *data = nil;
    switch (imageType)
    {
        case ImageType_JPEG:
        {
            data = UIImageJPEGRepresentation(image, compress);
            break;
        }
        case ImageType_PNG:
        {
            data = UIImagePNGRepresentation(image);
            break;
        }
        default:
            break;
    }
    return data;
}

/**
 *  @Author 刘宝, 2015-04-22 16:04:07
 *
 *  数据转换图片
 *
 *  @param data 数据
 *
 *  @return 图片
 */
+(UIImage *)dataToImage:(NSData *)data
{
    return [UIImage imageWithData: data];
}

/**
 *  @Author 刘宝, 2015-07-03 16:07:41
 *
 *  位转字节
 *
 *  @param bits 位数组
 *
 *  @return 字节
 */
+(Byte)bitsToByte:(NSArray *)bits
{
    Byte byte = 0;
    NSInteger count = bits.count - 1;
    for (NSInteger i = count; i >= 0; i --)
    {
        NSNumber *value = bits[i];
        byte |= (value.intValue) << count - i;
    }
    return byte;
}

/**
 *  @Author 刘宝, 2015-07-03 16:07:52
 *
 *  字节转位数组
 *
 *  @param byte 字节
 *
 *  @return 位数组
 */
+(NSArray *)byteToBits:(Byte)byte
{
    NSMutableArray *bits = [NSMutableArray arrayWithCapacity:8];
    for(int i = 7; i >= 0; i --)
    {
        if(byte & (1 << i))
        {
            [bits addObject:@1];
        }
        else
        {
            [bits addObject:@0];
        }
    }
    return bits;
}

@end
