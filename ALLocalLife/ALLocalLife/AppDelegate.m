//
//  AppDelegate.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/21.
//  Copyright © 2015年 AL. All rights reserved.
/*-----------------------------------*/
//  umeng:5655dea1e0f55a9608003239
/*-----------------------------------*/
#import "AppDelegate.h"
#import "ALTabBarController.h"
#import "ALGuideViewController.h"
//#import "UMSocial.h"
//#import "UMSocialSinaSSOHandler.h"
#import "SSKeychain.h"
#import "ALBasicViewController.h"
#import "ALNavigationController.h"

@interface AppDelegate ()<WeiboSDKDelegate>

@end

@implementation AppDelegate
@synthesize wbtoken;
@synthesize wbCurrentUserID;
@synthesize wbRefreshToken;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:kScreenBounds];
    
    [self chooseRootViewController];

    
    //第三方登录授权
//    [self SSOAuth];
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kSinaWeiBoAppKey];
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)chooseRootViewController{

    BOOL isFirstTime = [[NSUserDefaults standardUserDefaults] boolForKey:kFirstLogin];
    
    ALTabBarController *tabBarVc = [[ALTabBarController alloc] init];
    
    self.tabVc = tabBarVc;
    
    if (!isFirstTime) {
        self.window.rootViewController = tabBarVc;
    }else{
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        ALGuideViewController *guideView = [[ALGuideViewController alloc] initWithCollectionViewLayout:layout];
        self.window.rootViewController = guideView;
        
        guideView.loginBlock = ^(BOOL login){
            self.window.rootViewController = tabBarVc;
        };
        
    }
}

//umeng 未使用
-(void)SSOAuth{
    
//    [UMSocialData setAppKey:@"5655dea1e0f55a9608003239"];
//    
//    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。若在新浪后台设置我们的回调地址，“http://sns.whalecloud.com/sina2/callback”，这里可以传nil ,需要 #import "UMSocialSinaHandler.h"

//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"2866356252" RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];

}

#pragma mark - Sina WeiboSDKDelegate
//
//-(WBMessageObject *)messageShareToWeibo{
//    WBMessageObject *message = [WBMessageObject message];
//    
//    message.text = @"微博分享测试";
//    
//    return message;
//}
//
-(void)didReceiveWeiboRequest:(WBBaseRequest *)request{
//    WBProvideMessageForWeiboResponse *response = [WBProvideMessageForWeiboResponse responseWithMessage:[self messageShareToWeibo]];
//    [WeiboSDK sendResponse:response];
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    //分享到微博
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        NSString *title = NSLocalizedString(@"发送结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode, NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil),response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];

        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        if (accessToken)
        {
            self.wbtoken = accessToken;
        }
        NSString* userID = [sendMessageToWeiboResponse.authResponse userID];
        if (userID) {
            self.wbCurrentUserID = userID;
        }
        [alert show];
    }
    //SSO授权登录
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        NSString *title = NSLocalizedString(@"认证结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.userId: %@\nresponse.accessToken: %@\n%@: %@\n%@: %@",
                             NSLocalizedString(@"响应状态", nil), (int)response.statusCode,
                             [(WBAuthorizeResponse *)response userID],
                             [(WBAuthorizeResponse *)response accessToken],
                             NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo,
                             NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        
        self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
        self.wbCurrentUserID = [(WBAuthorizeResponse *)response userID];
        self.wbRefreshToken = [(WBAuthorizeResponse *)response refreshToken];
        [alert show];
        //如果登录成功，则退出登录页面，否则不退出

        if ((int)response.statusCode == 0) {
            [self loginSucceed];
        }
        
//        AppDelegate *myDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        ALTabBarController *tabVc = (ALTabBarController *)myDelegate.window.rootViewController;
//        ALNavigationController *navVc = (ALNavigationController *)tabVc.navigationController;
        
        /*保存用户信息并登录*/
        //保存当前用户名为userID
        [[NSUserDefaults standardUserDefaults] setValue:[(WBAuthorizeResponse *)response userID] forKey:@"username"];
        
        //在钥匙串中为 userID 设置 密码为 accessToken
        [SSKeychain setPassword:[(WBAuthorizeResponse *)response accessToken] forService:[NSBundle mainBundle].bundleIdentifier account:[(WBAuthorizeResponse *)response userID]];

        //登录过后修改rootVc 的登录状态 <无法自动修改>
        ALTabBarController *tabVc = (ALTabBarController *)self.window.rootViewController;
        UINavigationController *navVc = tabVc.viewControllers[0];
        ALBasicViewController *basicVc = navVc.viewControllers[0];
        

        
        [basicVc changeRightBtnWithLoginStatus];
    }
}

-(void)loginSucceed{
    ALTabBarController *tabVc = (ALTabBarController *)self.window.rootViewController;
    UINavigationController *navVc = tabVc.viewControllers[0];
    [navVc popViewControllerAnimated:YES];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
