//
//  TKSystemHelper.m
//  TKUtil_V1
//
//  Created by liubao on 14-11-10.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import "MCSystemHelper.h"
#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import "TKTelAddress.h"
#import "TKDateHelper.h"
#import "TKStringHelper.h"
#import "MCFileHelper.h"


@implementation MCSystemHelper

/**
 *  @Author 刘宝, 2015-04-30 14:04:01
 *
 *  内存管理对象
 */
static NSMutableDictionary *memCache;

/**
 *  @Author 刘宝, 2015-04-30 14:04:30
 *
 *  系统配置
 */
static NSMutableDictionary *sysConfig;

/**
 *  @Author 刘宝, 2014-11-26 12:11:27
 *
 *  系统配置
 *
 *  @return 系统配置
 */
+(NSMutableDictionary *)config
{
    @synchronized(sysConfig)
    {
        if (!sysConfig)
        {
            sysConfig = [NSMutableDictionary dictionary];
            NSString *confFilePath = [[MCFileHelper documentFolder]stringByAppendingPathComponent:@"Configuration.plist"];
            if (![MCFileHelper isFileExists:confFilePath])
            {
                [MCFileHelper createFile:confFilePath isDirectory:NO];
                NSMutableDictionary *configDic = [[MCFileHelper readSystemConfigXml:@"Configuration.xml"]mutableCopy];
                if (!configDic)
                {
                    NSString *srcConfFilePath = [[MCFileHelper bundleFolder]stringByAppendingPathComponent:@"Configuration.plist"];
                    if ([TKStringHelper isNotEmpty:srcConfFilePath])
                    {
                        configDic = [[NSMutableDictionary alloc] initWithContentsOfFile:srcConfFilePath];
                    }
                }
                if (configDic)
                {
                    for (NSString *key in configDic.allKeys)
                    {
                        NSObject *value = configDic[key];
                        if ([value isKindOfClass:[NSDictionary class]])
                        {
                            for (NSString *key1 in ((NSDictionary*)value).allKeys)
                            {
                                NSObject *value1 = ((NSDictionary*)value)[key1];
                                [sysConfig setObject:value1 forKey:[NSString stringWithFormat:@"%@.%@",key,key1]];
                            }
                        }
                        else
                        {
                            [sysConfig setObject:value forKey:key];
                        }
                    }
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        [sysConfig writeToFile:confFilePath atomically:YES];
                    });
                }
            }
            if ([MCFileHelper isFileExists:confFilePath])
            {
                if (!sysConfig || sysConfig.allKeys.count == 0)
                {
                    sysConfig = [[NSMutableDictionary alloc] initWithContentsOfFile:confFilePath];
                }
            }
        }
    }
    return sysConfig;
}

/**
 *  读取系统配置
 *
 *  @param key key
 *
 *  @return 配置value
 */
+(NSString*)getConfigByKey:(NSString*)key
{
    return (NSString *)[[self config] objectForKey:key];
}

/**
 *  修改系统配置
 *
 *  @param _key      key
 *  @param _newValue value
 *
 *  @return 成功标志
 */
+(BOOL)setConfigWithKey:(NSString*)key value:(NSString*)newValue
{
    BOOL flag = NO;
    NSString *confFilePath = [[MCFileHelper documentFolder]stringByAppendingPathComponent:@"Configuration.plist"];
    @try
    {
        [[self config] setValue:newValue forKey:key];
        [[self config] writeToFile:confFilePath atomically:YES];
        flag = YES;
    }
    @catch (NSException *exception)
    {
        NSLog(@"[ERROR]保存配置出现异常:%@",exception);
    }
    return flag;
}

/**
 *  @Author 刘宝, 2015-04-30 14:04:02
 *
 *  刷新重载系统配置
 */
+(void)refreshConfig
{
    @synchronized(sysConfig)
    {
        //重新复制配置文件
        sysConfig = nil;
        [MCFileHelper removeFile:[[MCFileHelper documentFolder]stringByAppendingPathComponent:@"Configuration.plist"]];
        [self config];
    }
}

/**
 *  获得升级展示版本号
 *
 *  @return 获取升级展示版本号
 */
+(NSString*) getVersion
{
    NSString *version = [MCSystemHelper getConfigByKey:@"update.version"];
    if ([TKStringHelper isEmpty:version])
    {
        version = [MCSystemHelper getAppVersion];
        //初始软件更新展示版本号
        [MCSystemHelper setConfigWithKey:@"update.version" value:version];
    }
    return version;
}

/**
 *  获得内部升级版本序号
 *
 *  @return 获取内部升级版本序号
 */
+(NSString *) getVersionSn
{
    NSString *versionSn = [MCSystemHelper getConfigByKey:@"update.versionSn"];
    if ([TKStringHelper isEmpty:versionSn])
    {
        versionSn = @"0";
        //初始软件更新版本号
        [MCSystemHelper setConfigWithKey:@"update.versionSn" value:versionSn];
    }
    return versionSn;
}

/**
 *  @Author 刘宝, 2015-05-18 14:05:25
 *
 *  获取系统应用版本号
 *
 *  @return 系统应用版本号
 */
+(NSString *)getAppVersion
{
    NSString *build = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return build;
}

/**
 *  获取应用名称
 *
 *  @return 应用名称
 */
+(NSString *)getAppName
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //当前应用名称
    NSString *appCurName = [infoDictionary objectForKey:@"CFBundleName"];
    return appCurName;
}

/**
 *  @Author 刘宝, 2014-12-23 16:12:21
 *
 *  获取应用描述名
 *
 *  @return 应用描述
 */
+(NSString *)getAppDisplayName
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //当前应用描述名称
    NSString *appCurDisplayName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    return appCurDisplayName;
}

/**
 *  @Author 刘宝, 2014-12-23 16:12:06
 *
 *  获取应用唯一值
 *
 *  @return 应用唯一值
 */
+(NSString *)getAppIdentifier
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //当前应用唯一描述
    NSString *appIdentifier = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    return appIdentifier;
}

/**
 *  @Author 刘宝, 2014-12-23 16:12:57
 *
 *  获取系统最低版本
 *
 *  @return 获取支持的系统最低版本
 */
+(NSString *)getAppLowerSystemVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //当前应用支持系统的最低版本
    NSString *appLowerSystemVersion = [infoDictionary objectForKey:@"CFBundleInfoDictionaryVersion"];
    return appLowerSystemVersion;
}

/**
 *  @Author 刘宝, 2014-12-23 16:12:10
 *
 *  获取应用的URL标示
 *
 *  @return
 */
+(NSString *)getAppURLName
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSArray *CFBundleURLTypes = (NSArray *)[infoDictionary objectForKey:@"CFBundleURLTypes"];
    if (CFBundleURLTypes && CFBundleURLTypes.count > 0)
    {
        NSDictionary *dic = CFBundleURLTypes[0];
        return (NSString *)[dic objectForKey:@"CFBundleURLName"];
    }
    return @"";
}

/**
 *  @Author 刘宝, 2014-12-23 16:12:03
 *
 *  获取URLSchemes
 *
 *  @return
 */
+(NSString *)getAppURLScheme
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSArray *CFBundleURLTypes = (NSArray *)[infoDictionary objectForKey:@"CFBundleURLTypes"];
    if (CFBundleURLTypes && CFBundleURLTypes.count > 0)
    {
        NSDictionary *dic = CFBundleURLTypes[0];
        NSArray *URLSchemes = (NSArray *)[dic objectForKey:@"CFBundleURLSchemes"];
        if (URLSchemes && URLSchemes.count > 0)
        {
            return (NSString *)URLSchemes[0];
        }
    }
    return @"";
}

/**
 *  @Author 刘宝, 2014-12-22 19:12:12
 *
 *  打电话
 *
 *  @param telPhone 电话号码
 */
+(void)callTelPhone:(NSString *)telPhone
{
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",telPhone]];
    static UIWebView *phoneCallWebView;
    if (!phoneCallWebView )
    {
        phoneCallWebView = [[UIWebView alloc]initWithFrame:CGRectZero];
    }
    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}

/**
 *  @Author 刘宝, 2014-12-23 10:12:26
 *
 *  读取通信录
 *
 *  @return 通讯录列表
 */
+(NSArray *)readTelAddressBook
{
    NSMutableArray *telAddressBook = [NSMutableArray array];
    //取得本地通信录名柄
    ABAddressBookRef tmpAddressBook = nil;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
    {
        tmpAddressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(tmpAddressBook, ^(bool greanted, CFErrorRef error){
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    else
    {
        tmpAddressBook = ABAddressBookCreate();
    }
    //取得本地所有联系人记录
    if (tmpAddressBook != nil && tmpAddressBook != NULL)
    {
        NSArray* tmpPeoples = (__bridge NSArray*) ABAddressBookCopyArrayOfAllPeople(tmpAddressBook);
        if (tmpPeoples && tmpPeoples.count > 0)
        {
            for(id tmpPerson in tmpPeoples)
            {
                TKTelAddress *telAddress = [[TKTelAddress alloc]init];
                
                //获取的联系人单一属性:First name
                NSString* tmpFirstName = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonFirstNameProperty);
                telAddress.firstName = [TKStringHelper stringWithTrim:tmpFirstName];
                
                //读取middlename
                NSString *tmpMiddlename = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonMiddleNameProperty);
                telAddress.middleName = [TKStringHelper stringWithTrim:tmpMiddlename];
                
                //获取的联系人单一属性:Last name
                NSString* tmpLastName = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonLastNameProperty);
                telAddress.lastName = [TKStringHelper stringWithTrim:tmpLastName];
                
                //获取的联系人单一属性:Nickname
                NSString* tmpNickname = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonNicknameProperty);
                telAddress.nickName = [TKStringHelper stringWithTrim:tmpNickname];
                
                //获取的联系人单一属性:Company name
                NSString* tmpCompanyname = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonOrganizationProperty);
                telAddress.companyName = [TKStringHelper stringWithTrim:tmpCompanyname];
                
                //获取的联系人单一属性:Job Title
                NSString* tmpJobTitle= (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonJobTitleProperty);
                telAddress.jobTitle = [TKStringHelper stringWithTrim:tmpJobTitle];
                
                //获取的联系人单一属性:Department name
                NSString* tmpDepartmentName = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonDepartmentProperty);
                telAddress.departmentName = [TKStringHelper stringWithTrim:tmpDepartmentName];
                
                //获取的联系人单一属性:Email(s)
                ABMultiValueRef tmpEmails = ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonEmailProperty);
                NSMutableArray *emails = [NSMutableArray array];
                for(NSInteger j = 0; ABMultiValueGetCount(tmpEmails); j++)
                {
                    NSString* tmpEmail = (__bridge NSString*)ABMultiValueCopyValueAtIndex(tmpEmails, j);
                    [emails addObject:[TKStringHelper stringWithTrim:tmpEmail]];
                }
                telAddress.emails = emails;
                CFRelease(tmpEmails);
                
                //获取的联系人单一属性:Birthday
                NSDate* tmpBirthday = (__bridge NSDate*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonBirthdayProperty);
                if (tmpBirthday)
                {
                    telAddress.birthday = [TKDateHelper formatDate:tmpBirthday];
                }
                
                //获取的联系人单一属性:Note
                NSString* tmpNote = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonNoteProperty);
                telAddress.note = [TKStringHelper stringWithTrim:tmpNote];
                
                //获取的联系人单一属性:Generic phone number
                ABMultiValueRef tmpPhones = ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonPhoneProperty);
                NSMutableArray *telPhones = [NSMutableArray array];
                for(NSInteger j = 0; j < ABMultiValueGetCount(tmpPhones); j++)
                {
                    NSString* tmpPhone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(tmpPhones, j);
                    [telPhones addObject:[TKStringHelper stringWithTrim:tmpPhone]];
                }
                telAddress.telPhones = telPhones;
                CFRelease(tmpPhones);
                
                //获取URL多值
                ABMultiValueRef tmpUrls = ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonURLProperty);
                NSMutableArray *urls = [NSMutableArray array];
                for (int m = 0; m < ABMultiValueGetCount(tmpUrls); m ++)
                {
                    NSString *tmpUrl = (__bridge NSString*)ABMultiValueCopyValueAtIndex(tmpUrls,m);
                    [urls addObject:[TKStringHelper stringWithTrim:tmpUrl]];
                }
                telAddress.urls = urls;
                CFRelease(tmpUrls);
                
                //读取照片
                NSData *imageData = (__bridge NSData*)ABPersonCopyImageData((__bridge ABRecordRef)(tmpPerson));
                if (imageData)
                {
                    UIImageView *myImage = [[UIImageView alloc] initWithFrame:CGRectMake(200, 0, 50, 50)];
                    [myImage setImage:[UIImage imageWithData:imageData]];
                    myImage.opaque = YES;
                    telAddress.image = myImage;
                }
                
                //读取地址多值
                ABMultiValueRef tmpAddresses = ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonAddressProperty);
                NSMutableArray *addresses = [NSMutableArray array];
                NSMutableArray *zips = [NSMutableArray array];
                for(int j = 0; j < ABMultiValueGetCount(tmpAddresses); j ++)
                {
                    NSDictionary* personaddress =(__bridge NSDictionary*) ABMultiValueCopyValueAtIndex(tmpAddresses, j);
                    NSMutableString *address = [NSMutableString string];
                    //国家
                    NSString* country = [personaddress valueForKey:(NSString *)kABPersonAddressCountryKey];
                    [address appendString:[TKStringHelper stringWithTrim:country]];
                    //省份
                    NSString* state = [personaddress valueForKey:(NSString *)kABPersonAddressStateKey];
                    [address appendString:[TKStringHelper stringWithTrim:state]];
                    //城市
                    NSString* city = [personaddress valueForKey:(NSString *)kABPersonAddressCityKey];
                    [address appendString:[TKStringHelper stringWithTrim:city]];
                    //街道
                    NSString* street = [personaddress valueForKey:(NSString *)kABPersonAddressStreetKey];
                    [address appendString:[TKStringHelper stringWithTrim:street]];
                    [addresses addObject:address];
                    
                    NSString* zip = [personaddress valueForKey:(NSString *)kABPersonAddressZIPKey];
                    [zips addObject:[TKStringHelper stringWithTrim:zip]];
                }
                telAddress.addresses = addresses;
                telAddress.zips = zips;
                CFRelease(tmpAddresses);
                
                [telAddressBook addObject:telAddress];
            }
        }
        CFRelease(tmpAddressBook);
    }
    return telAddressBook;
}

/**
 *  @Author 刘宝, 2014-12-23 16:12:23
 *
 *  是否已经安装了自己
 *
 *  @return
 */
+(BOOL)isInstallCurrentApp
{
    NSString *urlScheme = [MCSystemHelper getAppURLScheme];
    NSString *urlName = [MCSystemHelper getAppURLName];
    return [MCSystemHelper isInstallAppWithURLScheme:urlScheme urlName:urlName];
}

/**
 *  @Author 刘宝, 2014-12-23 16:12:58
 *
 *  是否安装指定的软件
 *
 *  @param urlSchemes
 *  @param urlName
 *
 *  @return
 */
+(BOOL)isInstallAppWithURLScheme:(NSString *)urlScheme urlName:(NSString *)urlName
{
    urlScheme = [TKStringHelper stringWithTrim:urlScheme];
    urlName = [TKStringHelper stringWithTrim:urlName];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@",urlScheme,urlName]];
    return [[UIApplication sharedApplication] canOpenURL:url];
}

/**
 *  @Author 刘宝, 2015-04-20 20:04:33
 *
 *  设置全局缓存
 *
 *  @param value 值
 *  @param key   键
 */
+(void)setMemcache:(NSObject *)value WithKey:(NSString *)key
{
    @synchronized(memCache)
    {
        if (!memCache)
        {
            memCache = [NSMutableDictionary dictionary];
        }
    }
    [memCache setObject:value forKey:key];
}

/**
 *  @Author 刘宝, 2015-04-20 20:04:18
 *
 *  获取全局缓存
 *
 *  @param key 键
 *
 *  @return 值
 */
+(NSObject *)getMemcacheWithKey:(NSString *)key
{
    @synchronized(memCache)
    {
        if (!memCache)
        {
            memCache = [NSMutableDictionary dictionary];
        }
    }
    return [memCache objectForKey:key];
}

/**
 *  @Author 刘宝, 2015-07-08 16:07:08
 *
 *  删除缓存值
 *
 *  @param key 键
 */
+(void)removeMemcacheWithKey:(NSString *)key
{
    @synchronized(memCache)
    {
        if (memCache)
        {
            [memCache removeObjectForKey:key];
        }
    }
}

/**
 *  @Author 刘宝, 2015-04-23 11:04:28
 *
 *  获取系统字体
 *
 *  @param size 大小
 *
 *  @return
 */
+(UIFont *)getSystemFontWithSize:(CGFloat)size
{
    //320*640为标准
    CGFloat scale = [UIScreen mainScreen].scale;
    return [UIFont systemFontOfSize:(size * scale)];
}

/**
 *  @Author 刘宝, 2015-04-23 11:04:28
 *
 *  获取系统粗体
 *
 *  @param size 大小
 *
 *  @return
 */
+(UIFont *)getBoldSystemFontOfSize:(CGFloat)size
{
    //320*640为标准
    CGFloat scale = [UIScreen mainScreen].scale;
    return [UIFont boldSystemFontOfSize:(size * scale)];
}

@end
