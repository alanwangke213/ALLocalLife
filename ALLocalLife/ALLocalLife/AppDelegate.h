//
//  AppDelegate.h
//  ALLocalLife
//
//  Created by 王可成 on 15/11/21.
//  Copyright © 2015年 AL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"
@class ALTabBarController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSString* wbtoken;
    NSString* wbCurrentUserID;
}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic ,strong) ALTabBarController *tabVc;
//sinaWeiboSDK
@property (strong, nonatomic) NSString *wbtoken;
@property (strong, nonatomic) NSString *wbRefreshToken;
@property (strong, nonatomic) NSString *wbCurrentUserID;

-(void)chooseRootViewController;
//-(void)hideBottomView;
@end

