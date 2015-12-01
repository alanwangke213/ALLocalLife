//
//  ALBasicViewController.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/21.
//  Copyright © 2015年 AL. All rights reserved.
//

#import "ALBasicViewController.h"
#import "MBProgressHUD.h"
#import "ALLoginViewController.h"
#import "SSKeychain.h"
#import "ALAccountManager.h"
#import "ALSelfCenterViewController.h"
#import "AppDelegate.h"
#import "ALNavigationController.h"

@interface ALBasicViewController ()
{
    MBProgressHUD *HUD;
}
@end

@implementation ALBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:238/255. green:238/255. blue:238/255. alpha:1.];
    
    [self addNavBar];
}

-(void)addNavBar{
    //navBar
    self.navBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kStatusBarHeight + kNavBarHeight)];
    self.navBar.backgroundColor = [UIColor colorWithRed:53/255. green:174/255. blue:243/255. alpha:1];
    
    //leftButton
    self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, kNavBarHeight, kNavBarHeight)];
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.navBar addSubview:self.leftButton];
    
    NSLog(@"kUserLogo : %@",[[NSUserDefaults standardUserDefaults] valueForKey:kUserLogo]);
    
    //rightButton
    [self changeRightBtnWithLoginStatus];
    
    //titleLabel
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kNavBarHeight, kStatusBarHeight, kScreenWidth - 2 * kNavBarHeight, kNavBarHeight)];
    self.titleLabel.text = @"title";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:19];
    
    self.titleLabel.textColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:1];
    [self.navBar addSubview:self.titleLabel];
    
    
    [self.view addSubview:self.navBar];
    
    self.navigationController.navigationBar.hidden = YES;

}

-(void)changeRightBtnWithLoginStatus{
    [self.rightButton removeFromSuperview];;
    //rightButton
    if ([ALAccountManager checkLoginStatue]) {// 登录了
        self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - kNavBarHeight, kStatusBarHeight, kNavBarHeight, kNavBarHeight)];
        [self.rightButton setBackgroundImage:[UIImage imageNamed:@"login_user"] forState:UIControlStateNormal];
    }else{//未登录
        self.rightButton = [[UIButton alloc] init];
        [self.rightButton setTitle:@"登录/注册" forState:UIControlStateNormal];
        [self.rightButton sizeToFit];
        self.rightButton.frame = CGRectMake(kScreenWidth - self.rightButton.bounds.size.width - 10, (kNavBarHeight - self.rightButton.bounds.size.height)*0.5 + kStatusBarHeight, self.rightButton.frame.size.width, self.rightButton.frame.size.height);
        self.rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        self.rightButton.adjustsImageWhenHighlighted = NO;
    }
    self.rightButton.adjustsImageWhenDisabled = NO;
    
    [self.rightButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navBar addSubview:self.rightButton];

}

-(void)getLoginInfo{
    /*获取用户名，并从钥匙串中取出对应的密码*/
    NSString *name = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
    NSString *accessToken = [SSKeychain passwordForService:[NSBundle mainBundle].bundleIdentifier account:name];
    NSLog(@"name:%@",name);
    NSLog(@"accessToken:%@",accessToken);
}

-(void)showLoadViewWithTitle:(NSString *)title{
    HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [HUD show:YES];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = title;
    [self.view addSubview:HUD];
}
-(void)showNoticeViewWithTitle:(NSString *)title{
    HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [HUD show:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText = title;
    [self.view addSubview:HUD];
}

-(void)hideLoadView{
    if (HUD) {
        [HUD removeFromSuperview];
        [HUD hide:YES];
        HUD = nil;
    }
}

-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)login:(UIButton *)sender{
    if ([[ALAccountManager sharedInstance] isLogined]) {
//    if (NO) {
        NSLog(@"已经登录了");
        ALSelfCenterViewController *selfVc = [[ALSelfCenterViewController alloc] init];
        
        [self.navigationController showViewController:selfVc sender:nil];
//        [self.navigationController pushViewController:selfVc animated:YES];
        
    }else{
        ALLoginViewController *vc = [[ALLoginViewController alloc] init];
        [self.navigationController showViewController:vc sender:nil];
//        [self.navigationController pushViewController:vc animated:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
