//
//  ALAccountManager.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/27.
//  Copyright © 2015年 AL. All rights reserved.
//

#import "ALAccountManager.h"
#import "SSKeychain.h"

@implementation ALAccountManager


+(instancetype)sharedInstance{
    static ALAccountManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ALAccountManager alloc] init];
    });
    
    return manager;
}

+(BOOL)checkLoginStatue{
    return [[self sharedInstance] checkLoginStatue];
}

-(BOOL)isLogined{
    
    if (!_isLogined) {
        _isLogined = [self checkLoginStatue];
    }
    return _isLogined;
    
}

-(BOOL)checkLoginStatue{
    
    //取出保存的用户名
    NSString *userID = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
    //取出用户名对应的密码
    NSString *accessToken = [SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:userID];
    //如果密码不空则返回登录成功
    
    if (accessToken == nil) {
        _isLogined = NO;
        return NO;
    }else{
        _isLogined = YES;
        return YES;
    }
}

+(void)logout{
    //取出保存的用户名
    NSString *userID = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
    //删除用户名对应的密码
    [SSKeychain deletePasswordForService:[NSBundle mainBundle].bundleIdentifier account:userID];
}
@end
