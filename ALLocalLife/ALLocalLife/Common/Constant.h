//
//  Constant.h
//  ALLocalLife
//
//  Created by 王可成 on 15/11/21.
//  Copyright © 2015年 AL. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#ifdef DEBUG

#define DSLog(...) NSLog(__VA_ARGS__)

#else

#define DSLog(...)

#endif


#define kFirstLogin @"kFirstTimeLogin"

#define kScale kScreenHeight / 480 * 0.5

#define kScreenBounds [UIScreen mainScreen].bounds
#define kScreenWidth kScreenBounds.size.width
#define kScreenHeight kScreenBounds.size.height
#define kStatusBarHeight 20
#define kNavBarHeight 44
#define kTabBarHeight 49
//分组数
#define kHomeGroups 3
#define kIsLogined @"isLogined"

//ALLoginVc
#define kPassword @"password"
#define kUserName @"username"
#define kUserLogo @"userLogo"
#define kKeepPassword @"kKeepPassword"
//#define kWeiBoRedirectURI @"https://api.weibo.com/oauth2/default.html"
#define kWeiBoRedirectURI @"http://sns.whalecloud.com/sina2/callback"
#define kSinaWeiBoAppKey @"1396052786"

//ALHTTPSession
#define kBaseURL @"http://www.qd-life.com/"


#endif /* Constant_h */
