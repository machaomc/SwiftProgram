//
//  TKFileHelper.m
//  ios4
//
//  Created by liubao on 14-10-28.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import "MCFileHelper.h"
#import "TKStringHelper.h"
#import "TKDataHelper.h"
#import "TKNumberHelper.h"
#import "TBXML.h"
#include <sys/stat.h>
#include <dirent.h>

/**
 *  文件帮助类
 */
@implementation MCFileHelper

/**
 *  获取手机的文档document目录路径
 *
 *  @return 手机的文档document目录路径
 */
+(NSString *) documentFolder
{
    //获取Documents文件夹目录,第一个参数是说明获取Doucments文件夹目录，第二个参数说明是在当前应用沙盒中获取，所有应用沙盒目录组成一个数组结构的数据存放
    NSArray *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    return [docPath objectAtIndex:0];
}

/**
 *  获取手机应用包的目录路径
 *
 *  @return 手机应用包的目录路径
 */
+(NSString *) bundleFolder
{
    return [NSBundle mainBundle].bundlePath;
}

/**
 *  @Author 刘宝, 2015-01-29 12:01:26
 *
 *  获取应用的根目录路径
 *
 *  @return 应用的根目录路径
 */
+(NSString *)homeFolder
{
    return NSHomeDirectory();
}

/**
 *  @Author 刘宝, 2015-01-29 12:01:57
 *
 *  获取应用Library目录路径
 *
 *  @return 应用Library目录路径
 */
+(NSString *)libFolder
{
    NSArray *libsPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [libsPath objectAtIndex:0];
}

/**
 *  @Author 刘宝, 2015-01-29 12:01:35
 *
 *  获取应用缓存的目录路径
 *
 *  @return 应用缓存的目录路径
 */
+(NSString *)cacheFolder
{
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [cacPath objectAtIndex:0];
}

/**
 *  @Author 刘宝, 2015-01-29 12:01:07
 *
 *  获取应用的临时目录路径
 *
 *  @return 应用的临时目录路径
 */
+(NSString *)tempFolder
{
    return NSTemporaryDirectory();
}

/**
 *  读取xml内容到数据字典
 *
 *  @param filePath xml文件路径
 *
 *  @return 数据字典
 */
+(NSDictionary *)readXmlForDictionary:(NSString *)filePath
{
    if ([TKStringHelper isNotEmpty:filePath])
    {
        NSError *error;
        NSString *xml = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        if (error)
        {
            NSLog(@"读取xml失败！路径为:[%@],错误信息:%@",filePath,error);
            return nil;
        }
        return [TKDataHelper xmlToDictionary:xml];
    }
    return nil;
}

/**
 *  读取xml内容到树
 *
 *  @param filePath xml文件路径
 *
 *  @return 树
 */
+(TreeNode *)readXmlForTreeNode:(NSString *)filePath
{
    if ([TKStringHelper isNotEmpty:filePath])
    {
        NSError *error;
        NSString *xml = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        if (error)
        {
            NSLog(@"读取xml失败！路径为:[%@],错误信息:%@",filePath,error);
            return nil;
        }
        return [TKDataHelper xmlToTreeNode:xml];
    }
    return nil;
}

/**
 *  写xml内容
 *
 *  @param xml xml内容
 *  @param filePath xml文件路径
 */
+(void)writeXml:(NSString *)xml inPath:(NSString *)filePath
{
    if ([TKStringHelper isNotEmpty:xml] && [TKStringHelper isNotEmpty:filePath])
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL result = [fileManager fileExistsAtPath:filePath];
        if (!result)
        {
            //创建一个文件用于写数据（第一次是必要的）
            result = [fileManager createFileAtPath:filePath contents:nil attributes:nil] ;
            if (!result)
            {
                NSLog(@"创建文件[%@]失败!",filePath);
            }
        }
        if (result)
        {
            NSFileHandle *fileHanle = [NSFileHandle fileHandleForWritingAtPath:filePath];
            if (fileHanle)
            {
                [fileHanle truncateFileAtOffset:0]; //清空文件
                [fileHanle seekToFileOffset:0]; //移动文件偏移量为0
                [fileHanle writeData:[xml dataUsingEncoding:NSUTF8StringEncoding]]; //写xml
                [fileHanle closeFile]; //关闭文件流
                fileHanle = nil;
            }
            else
            {
                NSLog(@"写入文件[%@]失败!",filePath);
            }
        }
    }
}

/**
 *  @Author 刘宝, 2014-11-27 14:11:03
 *
 *  读取系统xml配置文件（分为两层,catalog,item）
 *
 *  @param path 文件路径
 *
 *  @return 数据字典
 */
+(NSDictionary *)readSystemConfigXml:(NSString *)path
{
    NSError *error;
    //读取配置文件
    TBXML *pluginXml = [[TBXML alloc] initWithXMLFile:path error:&error];
    if (error)
    {
        NSLog(@"读取XML文件失败:%@",[error description]);
        return nil;
    }
    //获得根节点
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    TBXMLElement *plugins = pluginXml.rootXMLElement;
    if (plugins)
    {
        //解析子节点
        TBXMLElement *pluginx = [TBXML childElementNamed:@"catalog" parentElement:plugins];
        //循环遍历节点插件
        while (pluginx)
        {
            NSString *name = [TBXML valueOfAttributeNamed:@"name" forElement:pluginx];
            TBXMLElement *pluginx1 = [TBXML childElementNamed:@"item" parentElement:pluginx];
            while (pluginx1)
            {
                NSString *name1 = [TBXML valueOfAttributeNamed:@"name" forElement:pluginx1];
                NSString *value = [TBXML valueOfAttributeNamed:@"value" forElement:pluginx1];
                [dic setObject:value forKey:[NSString stringWithFormat:@"%@.%@",name,name1]];
                pluginx1 = [TBXML nextSiblingNamed:@"item" searchFromElement:pluginx1];
            }
            pluginx = [TBXML nextSiblingNamed:@"catalog" searchFromElement:pluginx];
        }
    }
    return dic;
}

/**
 *  @Author 刘宝, 2014-11-27 14:11:11
 *
 *  读取插件的xml配置文件(只有一层 item)
 *
 *  @param path 文件路径
 *
 *  @return 数据字典
 */
+(NSDictionary *)readPlugnConfigXml:(NSString *)path
{
    NSError *error;
    //读取配置文件
    TBXML *pluginXml = [[TBXML alloc] initWithXMLFile:path error:&error];
    if (error)
    {
        NSLog(@"读取XML文件失败%@",[error description]);
        return nil;
    }
    //获得根节点
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    TBXMLElement *plugins = pluginXml.rootXMLElement;
    if (plugins)
    {
        //解析子节点
        TBXMLElement *pluginx = [TBXML childElementNamed:@"item" parentElement:plugins];
        //循环遍历节点插件
        while (pluginx)
        {
            NSString *name = [TBXML valueOfAttributeNamed:@"name" forElement:pluginx];
            NSString *value = [TBXML valueOfAttributeNamed:@"value" forElement:pluginx];
            [dic setObject:value forKey:name];
            pluginx = [TBXML nextSiblingNamed:@"item" searchFromElement:pluginx];
        }
    }
    return dic;
}

/**
 *  @Author 刘宝, 2015-01-29 21:01:34
 *
 *  删除文件或者目录
 *
 *  @param filePath 文件路径
 *
 *  @return 成功标志
 */
+(BOOL)removeFile:(NSString *)filePath
{
    BOOL flag = YES;
    if ([TKStringHelper isNotEmpty:filePath])
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL result = [fileManager fileExistsAtPath:filePath];
        if (result)
        {
            NSError *error = nil;
            flag = [fileManager removeItemAtPath:filePath error:&error];
            if (error)
            {
                flag = NO;
                NSLog(@"删除文件[%@]失败,失败原因:%@",filePath,error);
            }
        }
    }
    else
    {
        flag = NO;
    }
    return flag;
}

/**
 *  @Author 刘宝, 2015-01-29 21:01:57
 *
 *  创建文件或目录
 *
 *  @param filePath       文件路径
 *  @param isDirectory    是否是目录
 *
 *  @return 成功标志
 */
+(BOOL)createFile:(NSString *)filePath isDirectory:(BOOL)isDirectory
{
    BOOL flag = YES;
    if ([TKStringHelper isNotEmpty:filePath])
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isDir = NO;
        BOOL result = [fileManager fileExistsAtPath:filePath isDirectory:&isDir];
        if (result && isDirectory)
        {
            result = isDir;
        }
        if (!result)
        {
            if (isDirectory)
            {
                flag = [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil] ;
            }
            else
            {
                flag = [fileManager createFileAtPath:filePath contents:nil attributes:nil] ;
            }
            if (!flag)
            {
                NSLog(@"创建文件[%@]失败!",filePath);
            }
        }
    }
    else
    {
        flag = NO;
    }
    return flag;
}

/**
 *  @Author 刘宝, 2015-01-29 21:01:10
 *
 *  移动文件
 *
 *  @param srcPath  原始文件
 *  @param destPath 目标文件
 *
 *  @return 成功标志
 */
+(BOOL)moveFile:(NSString *)srcPath to:(NSString *)destPath
{
    BOOL flag = YES;
    if ([TKStringHelper isNotEmpty:srcPath] && [TKStringHelper isNotEmpty:destPath])
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL result = [fileManager fileExistsAtPath:srcPath];
        if (result)
        {
            result = [fileManager fileExistsAtPath:destPath];
            if (result)
            {
                NSError *error = nil;
                flag = [fileManager removeItemAtPath:destPath error:&error];
                if (error)
                {
                    flag = NO;
                    NSLog(@"删除文件[%@]失败,失败原因:%@",destPath,error);
                }
            }
            if (flag)
            {
                NSInteger index = [TKStringHelper string:destPath lastIndexOf:@"/"];
                NSString *dirPath = [TKStringHelper subStringWith:destPath fromIndex:0 toIndex:index];
                BOOL isDir = YES;
                if (![fileManager fileExistsAtPath:dirPath isDirectory:&isDir] || !isDir)
                {
                    [MCFileHelper createFile:dirPath isDirectory:YES];
                }
                NSError *error = nil;
                flag = [fileManager moveItemAtPath:srcPath toPath:destPath error:&error];
                if (error)
                {
                    NSLog(@"移动文件[%@]到[%@]失败,失败原因:%@",srcPath,destPath,error);
                }
            }
        }
        else
        {
            flag = NO;
            NSLog(@"移动文件[%@]到[%@]失败,失败原因:源文件[%@]不存在!",srcPath,destPath,srcPath);
        }
    }
    else
    {
        flag = NO;
    }
    return flag;
}

/**
 *  @Author 刘宝, 2015-01-29 21:01:23
 *
 *  复制文件
 *
 *  @param srcPath  原始文件
 *  @param destPath 目标文件
 *
 *  @return 成功标志
 */
+(BOOL)copyFile:(NSString *)srcPath to:(NSString *)destPath
{
    BOOL flag = YES;
    if ([TKStringHelper isNotEmpty:srcPath] && [TKStringHelper isNotEmpty:destPath])
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL result = [fileManager fileExistsAtPath:srcPath];
        if (result)
        {
            result = [fileManager fileExistsAtPath:destPath];
            if (result)
            {
                NSError *error = nil;
                flag = [fileManager removeItemAtPath:destPath error:&error];
                if (error)
                {
                    flag = NO;
                    NSLog(@"删除文件[%@]失败,失败原因:%@",destPath,error);
                }
            }
            if (flag)
            {
                NSInteger index = [TKStringHelper string:destPath lastIndexOf:@"/"];
                NSString *dirPath = [TKStringHelper subStringWith:destPath fromIndex:0 toIndex:index];
                BOOL isDir = YES;
                if (![fileManager fileExistsAtPath:dirPath isDirectory:&isDir] || !isDir)
                {
                    [MCFileHelper createFile:dirPath isDirectory:YES];
                }
                NSError *error = nil;
                flag = [fileManager copyItemAtPath:srcPath toPath:destPath error:&error];
                if (error)
                {
                    NSLog(@"复制文件[%@]到[%@]失败,失败原因:%@",srcPath,destPath,error);
                }
            }
        }
        else
        {
            flag = NO;
            NSLog(@"复制文件[%@]到[%@]失败,失败原因:源文件[%@]不存在!",srcPath,destPath,srcPath);
        }
    }
    else
    {
        flag = NO;
    }
    return flag;
}

/**
 *  @Author 刘宝, 2015-01-30 10:01:21
 *
 *  写数据到文件中
 *
 *  @param content  内容
 *  @param filePath 路径
 *  @param isExtend 是否用追加模式
 *
 *  @return 成功标志
 */
+(BOOL)writeContent:(NSObject *)content inFile:(NSString *)filePath isExtend:(BOOL)isExtend
{
    BOOL success = YES;
    if (content && [TKStringHelper isNotEmpty:filePath])
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL result = [fileManager fileExistsAtPath:filePath];
        if (!result)
        {
            //创建一个文件用于写数据（第一次是必要的）
            result = [fileManager createFileAtPath:filePath contents:nil attributes:nil] ;
            if (!result)
            {
                NSLog(@"创建文件[%@]失败!",filePath);
            }
        }
        if (result)
        {
            NSFileHandle *fileHanle = [NSFileHandle fileHandleForWritingAtPath:filePath];
            if (fileHanle)
            {
                NSData *myEncodedObject = nil;
                if ([content isKindOfClass:[NSString class]])
                {
                    myEncodedObject = [((NSString *)content) dataUsingEncoding:NSUTF8StringEncoding];
                }
                else if([content isKindOfClass:[NSData class]])
                {
                    myEncodedObject = (NSData *)content;
                }
                else if([content isKindOfClass:[NSNumber class]])
                {
                    myEncodedObject = [[NSString stringWithFormat:@"%@",content] dataUsingEncoding:NSUTF8StringEncoding];
                }
                else
                {
                    myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:content];
                }
                if (!isExtend)
                {
                    [fileHanle truncateFileAtOffset:0]; //清空文件
                    [fileHanle seekToFileOffset:0]; //移动文件偏移量为0
                }
                else
                {
                    [fileHanle seekToEndOfFile]; //移动到文件末尾
                }
                [fileHanle writeData:myEncodedObject]; //写文件
                [fileHanle closeFile]; //关闭文件流
                fileHanle = nil;
                success = YES;
            }
            else
            {
                NSLog(@"写入文件[%@]失败!",filePath);
                success = NO;
            }
        }
        else
        {
            success = NO;
        }
    }
    else
    {
        success = NO;
    }
    return success;
}

/**
 *  @Author 刘宝, 2015-01-30 10:01:03
 *
 *  读取文件的内容
 *
 *  @param filePath 文件路径
 *
 *  @return 内容
 */
+(NSData *)readContentOfFile:(NSString *)filePath
{
    NSData *content = nil;
    if ([TKStringHelper isNotEmpty:filePath])
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL result = [fileManager fileExistsAtPath:filePath];
        if (result)
        {
            NSFileHandle *fileHanle = [NSFileHandle fileHandleForReadingAtPath:filePath];
            if (fileHanle)
            {
                content = [fileHanle readDataToEndOfFile];
            }
            else
            {
                NSLog(@"读取文件[%@]失败!",filePath);
            }
        }
        else
        {
             NSLog(@"读取文件内容失败!源文件[%@]不存在!",filePath);
        }
    }
    return content;
}

/**
 *  @Author 刘宝, 2015-02-04 10:02:40
 *
 *  判断文件是否存在
 *
 *  @param filePath 文件路径
 *
 *  @return 存在标识
 */
+(BOOL)isFileExists:(NSString *)filePath
{
    if ([TKStringHelper isNotEmpty:filePath])
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        return [fileManager fileExistsAtPath:filePath];
    }
    return NO;
}

/**
 *  @Author 刘宝, 2015-02-04 10:02:18
 *
 *  获取目录下面的子目录
 *
 *  @param filePath 目录路径
 *
 *  @return 子文件数组
 */
+(NSArray *)listFiles:(NSString *)filePath
{
    if ([TKStringHelper isNotEmpty:filePath])
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isDir = NO;
        //isDir是出参，判读是否为目录
        if ([fileManager fileExistsAtPath:filePath isDirectory:&isDir] && isDir)
        {
            return [fileManager contentsOfDirectoryAtPath:filePath error:nil];
        }
    }
    return nil;
}

/**
 *  @Author 刘宝, 2015-02-04 14:02:16
 *
 *  判断是否是目录
 *
 *  @param filePath 文件路径
 *
 *  @return 是否是目录
 */
+(BOOL)isDirectory:(NSString *)filePath
{
    if ([TKStringHelper isNotEmpty:filePath])
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL flag = NO;
        if ([fileManager fileExistsAtPath:filePath isDirectory:&flag])
        {
            return flag;
        }
    }
    return NO;
}

/**
 *  @Author 刘宝, 2015-04-23 14:04:31
 *
 *  获取文件
 *
 *  @param filePath    文件目录的路径
 *  @param isDirectory 是否是目录
 *  @param decimal     小数点位数
 *
 *  @return 大小
 */
+(NSString *)getFileSize:(NSString *)filePath isDirectory:(BOOL)isDirectory decimal:(NSInteger)decimal
{
    double fileSize = 0;
    if ([MCFileHelper isFileExists:filePath])
    {
        if (isDirectory)
        {
            if ([MCFileHelper isDirectory:filePath])
            {
                const char *folderPath = [filePath cStringUsingEncoding:NSUTF8StringEncoding];
                fileSize = [self getFolderSizeAtPath:folderPath];
            }
        }
        else
        {
            struct stat st;
            if(lstat([filePath cStringUsingEncoding:NSUTF8StringEncoding], &st) == 0)
            {
                fileSize = st.st_size;
            }
        }
        if (fileSize < 1024)
        {
            return [NSString stringWithFormat:@"%f",fileSize];
        }
        else if (fileSize < (1024 * 1024))
        {
            fileSize = (fileSize / 1024);
            if (decimal > 0)
            {
                return [NSString stringWithFormat:@"%@K",[TKNumberHelper formatNumber:[NSNumber numberWithDouble:fileSize] decimal:decimal groupFlag:YES]];
            }
            return [NSString stringWithFormat:@"%fK",fileSize];
        }
        else
        {
            fileSize = fileSize / (1024 * 1024);
            if (decimal > 0)
            {
                return [NSString stringWithFormat:@"%@M",[TKNumberHelper formatNumber:[NSNumber numberWithDouble:fileSize] decimal:decimal groupFlag:YES]];
            }
            return [NSString stringWithFormat:@"%fM",fileSize];
        }
    }
    return @"0";
}

/**
 *  @Author 刘宝, 2015-04-23 15:04:11
 *
 *  目录的大小
 *
 *  @param folderPath 目录路径
 *
 *  @return
 */
+ (long long)getFolderSizeAtPath:(const char*)folderPath
{
    long long folderSize = 0;
    DIR* dir = opendir(folderPath);
    if (dir == NULL) return 0;
    struct dirent* child;
    while ((child = readdir(dir)) != NULL)
    {
        if (child->d_type == DT_DIR && (
                                        (child->d_name[0] == '.' && child->d_name[1] == 0) || // 忽略目录 .
                                        (child->d_name[0] == '.' && child->d_name[1] == '.' && child->d_name[2] == 0) // 忽略目录 ..
                                        )) continue;
        int folderPathLength = strlen(folderPath);
        char childPath[1024]; // 子文件的路径地址
        stpcpy(childPath, folderPath);
        if (folderPath[folderPathLength-1] != '/')
        {
            childPath[folderPathLength] = '/';
            folderPathLength ++;
        }
        stpcpy(childPath+folderPathLength, child->d_name);
        childPath[folderPathLength + child->d_namlen] = 0;
        if (child->d_type == DT_DIR)
        {
            // directory
            folderSize += [self getFolderSizeAtPath:childPath]; // 递归调用子目录
            // 把目录本身所占的空间也加上
            struct stat st;
            if(lstat(childPath, &st) == 0) folderSize += st.st_size;
        }
        else if (child->d_type == DT_REG || child->d_type == DT_LNK)
        {
            // file or link
            struct stat st;
            if(lstat(childPath, &st) == 0) folderSize += st.st_size;
        }
    }
    return folderSize;
}

/**
 *  @Author 刘宝, 2015-07-09 01:07:09
 *
 *  获取指定目录下面的文件路径，递归查找
 *
 *  @param name              文件名
 *  @param folder            目录名
 *
 *  @return
 */
+(NSString *)getFilePathByName:(NSString *)name inFiolder:(NSString *)folder
{
    if ([TKStringHelper isNotEmpty:name] && [TKStringHelper isNotEmpty:folder])
    {
        //遍历文件路径
        NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:folder];
        NSString * file;
        while ((file = [enumerator nextObject]))
        {
            NSString *temp = [file lastPathComponent];
            NSInteger index = [TKStringHelper string:name indexOf:@"."];
            if (index < 0)
            {
                index = [TKStringHelper string:temp indexOf:@"."];
                if (index >= 0)
                {
                    temp = [TKStringHelper subStringWith:temp fromIndex:0 toIndex:index];
                }
            }
            //比较文件名
            if ([temp caseInsensitiveCompare:name] == NSOrderedSame)
            {
                file = [folder stringByAppendingPathComponent:file];
                return file;
            }
        }
    }
    return nil;
}

@end