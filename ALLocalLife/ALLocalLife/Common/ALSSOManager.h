//
//  ALSSOManager.h
//  ALLocalLife
//
//  Created by 王可成 on 15/11/26.
//  Copyright © 2015年 AL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALSSOManager : NSObject

+(instancetype)sharedInstance;

-(void)weiboSSOLogin;
-(void)weiboSSOLogout;
-(void)shareToSinaWeibo;

//-(void)TencentSSOLogin;
//-(void)TencentSSOLogout;
//-(void)shareToQzone;

//-(void)WeChatSSOLogin;
//-(void)WeChatSSOLogout;
//-(void)shareToWeChat;

@end
