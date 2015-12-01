//
//  ALSSOManager.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/26.
//  Copyright © 2015年 AL. All rights reserved.
//

#import "ALSSOManager.h"
#import "WeiboSDK.h"
#import "AppDelegate.h"

@interface ALSSOManager ()

@end

@implementation ALSSOManager

+(instancetype)sharedInstance{
    
    static ALSSOManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ALSSOManager alloc] init];
    });
    
    return manager;
}

-(void)weiboSSOLogin{
    
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kWeiBoRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"ALLoginKikiVc",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

-(void)weiboSSOLogout{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [WeiboSDK logOutWithToken:myDelegate.wbtoken delegate:self withTag:@"user1"];
}

-(void)shareToSinaWeibo{
    
}

@end
