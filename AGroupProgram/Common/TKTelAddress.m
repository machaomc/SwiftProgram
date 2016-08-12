//
//  TelAddress.m
//  TKUtil_V1
//
//  Created by liubao on 14-12-23.
//  Copyright (c) 2014年 liubao. All rights reserved.
//

#import "TKTelAddress.h"

/**
 *  @Author 刘宝, 2014-12-23 11:12:23
 *
 *  通讯录地址薄
 */
#define FIRSTNAME @"firstName"
#define MIDDLENAME @"middleName"
#define LASTNAME @"lastName"
#define NICKNAME @"nickName"
#define COMPANYNAME @"companyName"
#define JOBTITLE @"jobTitle"
#define DEPARTMENTNAME @"departmentName"
#define EMAILS @"emails"
#define BIRTHDAY @"birthday"
#define NOTE @"note"
#define TELPHONES @"telPhones"
#define URLS @"urls"
#define IMAGE @"images"
#define ADDRESSES @"addresses"
#define ZIPS @"zips"

@implementation TKTelAddress

/**
 *  @Author 刘宝, 2014-12-23 11:12:38
 *
 *  首姓名
 */
-(void)setFirstName:(NSString *)firstName
{
    [self setString:firstName withKey:FIRSTNAME];
}

-(NSString *)firstName
{
    return [self getStringWithKey:FIRSTNAME];
}

/**
 *  @Author 刘宝, 2014-12-23 13:12:17
 *
 *  中间名称
 */
-(void)setMiddleName:(NSString *)middleName
{
    [self setString:middleName withKey:MIDDLENAME];
}

-(NSString *)middleName
{
    return [self getStringWithKey:MIDDLENAME];
}

/**
 *  @Author 刘宝, 2014-12-23 11:12:34
 *
 *  尾姓名
 */
-(void)setLastName:(NSString *)lastName
{
    [self setString:lastName withKey:LASTNAME];
}

-(NSString *)lastName
{
    return [self getStringWithKey:LASTNAME];
}

/**
 *  @Author 刘宝, 2014-12-23 11:12:11
 *
 *  昵称
 */
-(void)setNickName:(NSString *)nickName
{
    [self setString:nickName withKey:NICKNAME];
}

-(NSString *)nickName
{
    return [self getStringWithKey:NICKNAME];
}

/**
 *  @Author 刘宝, 2014-12-23 11:12:56
 *
 *  公司名称
 */
-(void)setCompanyName:(NSString *)companyName
{
    [self setString:companyName withKey:COMPANYNAME];
}

-(NSString *)companyName
{
    return [self getStringWithKey:COMPANYNAME];
}

/**
 *  @Author 刘宝, 2014-12-23 11:12:49
 *
 *  职位
 */
-(void)setJobTitle:(NSString *)jobTitle
{
    [self setString:jobTitle withKey:JOBTITLE];
}

-(NSString *)jobTitle
{
    return [self getStringWithKey:JOBTITLE];
}

/**
 *  @Author 刘宝, 2014-12-23 11:12:16
 *
 *  部门
 */
-(void)setDepartmentName:(NSString *)departmentName
{
    [self setString:departmentName withKey:DEPARTMENTNAME];
}

-(NSString *)departmentName
{
    return [self getStringWithKey:DEPARTMENTNAME];
}

/**
 *  @Author 刘宝, 2014-12-23 11:12:47
 *
 *  联系邮箱集合
 */
-(void)setEmails:(NSArray *)emails
{
    [self setObject:emails withKey:EMAILS];
}

-(NSArray *)emails
{
    return (NSArray *)[self getObjectWithKey:EMAILS];
}

/**
 *  @Author 刘宝, 2014-12-23 11:12:46
 *
 *  生日
 */
-(void)setBirthday:(NSString *)birthday
{
    [self setString:birthday withKey:BIRTHDAY];
}

-(NSString *)birthday
{
    return [self getStringWithKey:BIRTHDAY];
}

/**
 *  @Author 刘宝, 2014-12-23 11:12:15
 *
 *  备注
 */
-(void)setNote:(NSString *)note
{
    [self setString:note withKey:NOTE];
}

-(NSString *)note
{
    return [self getStringWithKey:NOTE];
}

/**
 *  @Author 刘宝, 2014-12-23 11:12:57
 *
 *  联系电话集合
 */
-(void)setTelPhones:(NSArray *)telPhones
{
    [self setObject:telPhones withKey:TELPHONES];
}

-(NSArray *)telPhones
{
    return (NSArray *)[self getObjectWithKey:TELPHONES];
}

/**
 *  @Author 刘宝, 2014-12-23 13:12:34
 *
 *  网址集合
 */
-(void)setUrls:(NSArray *)urls
{
    [self setObject:urls withKey:URLS];
}

-(NSArray *)urls
{
    return (NSArray *)[self getObjectWithKey:URLS];
}

/**
 *  @Author 刘宝, 2014-12-23 13:12:43
 *
 *  照片
 */
-(void)setImage:(UIImageView *)image
{
    [self setObject:image withKey:IMAGE];
}

-(UIImageView *)image
{
    return (UIImageView *)[self getObjectWithKey:IMAGE];
}

/**
 *  @Author 刘宝, 2014-12-23 13:12:32
 *
 *  地址集合
 */
-(void)setAddresses:(NSArray *)addresses
{
    [self setObject:addresses withKey:ADDRESSES];
}

-(NSArray *)addresses
{
    return (NSArray *)[self getObjectWithKey:ADDRESSES];
}

/**
 *  @Author 刘宝, 2014-12-23 13:12:31
 *
 *  邮政编码集合
 */
-(void)setZips:(NSArray *)zips
{
    [self setObject:zips withKey:ZIPS];
}

-(NSArray *)zips
{
    return (NSArray *)[self getObjectWithKey:ZIPS];
}
@end
