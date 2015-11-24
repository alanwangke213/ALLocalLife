//
//  ALBasicViewController.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/21.
//  Copyright © 2015年 AL. All rights reserved.
//

#import "ALBasicViewController.h"
#import "MBProgressHUD.h"

#define kStatusBarHeight 20
#define kNavBarHeight 44
@interface ALBasicViewController ()
{
    MBProgressHUD *HUD;
}
@end

@implementation ALBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:random()%256/255.0 green:random()%256/255.0 blue:random()%256/255.0 alpha:1];
    
    
    [self addNavBar];
}

-(void)addNavBar{
    self.navBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kStatusBarHeight + kNavBarHeight)];
    
    self.navBar.backgroundColor = [UIColor colorWithRed:53/255. green:174/255. blue:243/255. alpha:0.75];
    
    self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, kNavBarHeight, kNavBarHeight)];
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [self.navBar addSubview:self.leftButton];
    
    self.righttButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - kNavBarHeight, kStatusBarHeight, kNavBarHeight, kNavBarHeight)];
    [self.righttButton setBackgroundImage:[UIImage imageNamed:@"login_user"] forState:UIControlStateNormal];
    [self.navBar addSubview:self.righttButton];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kNavBarHeight, kStatusBarHeight, kScreenWidth - 2 * kNavBarHeight, kNavBarHeight)];
    self.titleLabel.text = @"title";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:19];
    self.titleLabel.textColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:1];
    [self.navBar addSubview:self.titleLabel];
    
    
    [self.view addSubview:self.navBar];
    
    self.navigationController.navigationBar.hidden = YES;

}

-(void)showLoadView{
    HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [HUD show:YES];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = @"loading";
    [self.view addSubview:HUD];
}
-(void)hideLoadView{
    if (HUD) {
        [HUD removeFromSuperview];
        [HUD hide:YES];
        HUD = nil;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
