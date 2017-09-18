//
//  HRAccountTool.m
//  OFei
//
//  Created by zeyzeyzey on 16/7/11.
//  Copyright © 2016年 xukun. All rights reserved.
//

#import "HRAccountTool.h"

@implementation HRAccountTool

+ (void)saveAccount:(NSArray *)account{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //保存数据 用户信息；用户名；用户密码
    [userDefaults setObject:account  forKey:@"account" ];
    [userDefaults setObject:[account objectAtIndex:0]  forKey:@"userName" ];
    [userDefaults setObject:[account objectAtIndex:1]  forKey:@"passWord" ];
};


+ (NSArray *)getAccount{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *array = [userDefaults objectForKey:@"account"];
    return array;
};

+ (NSString *)getUserName{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userDefaults objectForKey:@"userName"];
    return userName;
};

+ (NSString *)getPassword{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *passWord = [userDefaults objectForKey:@"passWord"];
    return passWord;
 
}

+(void)deleteUser{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"userName"];
    [userDefaults synchronize];
}


@end
