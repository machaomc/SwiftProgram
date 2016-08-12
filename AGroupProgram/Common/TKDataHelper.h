//
//  TKDataHelper.h
//  TKUtil
//
//  Created by liubao on 14-10-31.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TreeNode.h"

/**
 图片类型
 */
typedef enum
{
    ImageType_PNG,
    ImageType_JPEG
}ImageType;

/**
 *  数据转换帮助类
 */
@interface TKDataHelper : NSObject

/**
 *  NSString* 转 NSData*
 *
 *  @param string NSString*
 *
 *  @return NSData*
 */
+(NSData *)stringToData:(NSString *)string;

/**
 *  NSData* 转 NSString*
 *
 *  @param data NSData*
 *
 *  @return NSString*
 */
+(NSString *)dataToString:(NSData *)data;

/**
 *  NSString* 转 char *
 *
 *  @param string NSString*
 *
 *  @return char*
 */
+(const char *)stringToChars:(NSString *)string;

/**
 *  char* 转 NSString*
 *
 *  @param chars char*
 *
 *  @return NSString
 */
+(NSString *)charsToString:(char *)chars;

/**
 *  NSData* 转 char*
 *
 *  @param data NSData*
 *
 *  @return char*
 */
+(char *)dataToChars:(NSData *)data;

/**
 *  char* 转 NSData*
 *
 *  @param chars char*
 *
 *  @return NSData*
 */
+(NSData *)charsToData:(char *)chars;

/**
 *  xml转json
 *
 *  @param xml xml字符串
 *
 *  @return json字符串
 */
+(NSString *)xmlToJson:(NSString *)xml;

/**
 *  json转Xml
 *
 *  @param json json字符串
 *
 *  @return xml字符串
 */
+(NSString *)jsonToXml:(NSString *)json;

/**
 *  json转数据字典
 *
 *  @param json json字符串
 *
 *  @return 数据字典
 */
+(NSDictionary *)jsonToDictionary:(NSString *)json;

/**
 *  json转对象
 *
 *  @param json json字符串
 *
 *  @return 对象
 */
+(NSObject *)jsonToObject:(NSString *)json;

/**
 *  @Author 刘宝, 2014-11-27 11:11:00
 *
 *  json转数组
 *
 *  @param json json字符串
 *
 *  @return 数组
 */
+(NSArray *)jsonTOArray:(NSString *)json;

/**
 *  数据字典转json
 *
 *  @param dic 数据字典
 *
 *  @return json字符串
 */
+(NSString *)dictionaryToJson:(NSDictionary *)dic;

/**
 *  @Author 刘宝, 2014-11-27 11:11:00
 *
 *  对象转json
 *
 *  @param obj 对象
 *
 *  @return json字符串
 */
+(NSString *)objectToJson:(NSObject *)obj;

/**
 *  @Author 刘宝, 2014-11-27 11:11:05
 *
 *  数组转json
 *
 *  @param jsonArray 数据字典数组
 *
 *  @return json字符串
 */
+(NSString *)arrayToJson:(NSArray *)jsonArray;

/**
 *  xml转数据字典
 *
 *  @param xml xml字符串
 *
 *  @return 数据字典
 */
+(NSDictionary *)xmlToDictionary:(NSString *)xml;

/**
 *  数据字典转xml
 *
 *  @param dic 数据字典
 *
 *  @return xml字符串
 */
+(NSString *)dictionaryToXml:(NSDictionary *)dic;

/**
 *  xml转成树
 *
 *  @param xml xml数据
 *
 *  @return 树
 */
+(TreeNode *)xmlToTreeNode:(NSString *)xml;

/**
 *  树转xml
 *
 *  @param treeNode 树
 *
 *  @return xml数据
 */
+(NSString *)treeNodeToXml:(TreeNode *)treeNode;

/**
 *  树转数据字典
 *
 *  @param treeNode 树
 *  @param dic  数据字典
 *  @param flag 是否包含当前根节点
 */
+(void)treeNode:(TreeNode *)treeNode ToDictionary:(NSMutableDictionary **)dic hasRoot:(BOOL)flag;

/**
 * 复制数据字典到另外一个数据字典
 *
 *  @param srcDic  源数据字典
 *  @param destDic 目标数据字典
 *  @param flag    是否强复制，NO:只有替换的字段的值不为空，才替换，否则保留原来的值 YES:全部复制替换
 */
+(void) copyDictionay:(NSDictionary *)srcDic toDictionary:(NSMutableDictionary *)destDic isStrong:(BOOL)flag;

/**
 *  数据字典转字符串
 *
 *  @param dic    要转换的数据字典
 *  @param split0 第一层分割符号   ,
 *  @param split1 第二层分隔符    =
 *
 *  @return 转换后的字符串 name=liubao,age=20,lover=xiaozhu
 */
+(NSString *)dictionayToString:(NSDictionary *)dic firstSplit:(NSString *)split0 secondSplit:(NSString *)split1;

/**
 *  字符串转成对象
 *
 *  @param str    要转换的字符串 例如name=liubao,age=20,lover=xiaozhu
 *  @param split0 第一层分割符号  ,
 *  @param split1 第二层分隔符    =
 *
 *  @return 转换后的数据字典
 */
+(NSDictionary *)stringToDictionay:(NSString *)str firstSplit:(NSString *)split0 secondSplit:(NSString *)split1;

/**
 *  对象转成数据字典
 *
 *  @param obj 对象
 *
 *  @return 数据字典
 */
+(NSDictionary *)objectToDictionary:(NSObject *)obj;

/**
 *  数据字典转成对象
 *
 *  @param srcDic  数据字典
 *  @param destObj 目标对象
 */
+(void)dictionary:(NSDictionary *)srcDic ToObject:(NSObject *)destObj;

/**
 *  根据类名得到类的实例
 *
 *  @param className 类名
 *
 *  @return 实例
 */
+(id) getClassInstanceByName: (NSString *)className;

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
+(NSData *)imageToData:(UIImage *)image imageType:(ImageType)imageType compress:(CGFloat)compress;

/**
 *  @Author 刘宝, 2015-04-22 16:04:07
 *
 *  数据转换图片
 *
 *  @param data 数据
 *
 *  @return 图片
 */
+(UIImage *)dataToImage:(NSData *)data;

/**
 *  @Author 刘宝, 2015-07-03 16:07:41
 *
 *  位转字节
 *
 *  @param bits 位数组
 *
 *  @return 字节
 */
+(Byte)bitsToByte:(NSArray *)bits;

/**
 *  @Author 刘宝, 2015-07-03 16:07:52
 *
 *  字节转位数组
 *
 *  @param byte 字节
 *
 *  @return 位数组
 */
+(NSArray *)byteToBits:(Byte)byte;

@end
