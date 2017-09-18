//
//  HRAccountTool.h
//  OFei
//
//  Created by zeyzeyzey on 16/7/11.
//  Copyright © 2016年 xukun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HRAccountTool : NSObject

/**
 *  存储账号信息
 *  @param account 需要存储的账号信息：第一个值为用户名；第二个值为密码
 */
+ (void)saveAccount:(NSArray *)account;

/**
 *  返回存储的账号信息
 * @return NSArray
 */
+ (NSArray *)getAccount;

/**
 *  返回存储的登陆用户名
 *  @return NSString
 */
+ (NSString *)getUserName;

/**
 *  返回存储的登陆用户密码
 *  @return NSString
 */
+ (NSString *)getPassword;

+(void)deleteUser;

@end
