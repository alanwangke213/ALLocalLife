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
#define kScreenBounds [UIScreen mainScreen].bounds
#define kScreenWidth kScreenBounds.size.width
#define kScreenHeight kScreenBounds.size.height
#define kTabBarHeight 49
//分组数
#define kHomeGroups 3


#define kBaseURL @"http://www.qd-life.com/"


#endif /* Constant_h */
