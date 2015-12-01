//
//  ALNavigationController.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/27.
//  Copyright © 2015年 AL. All rights reserved.
//

#import "ALNavigationController.h"
#import "AppDelegate.h"
#import "ALTabBarController.h"

@interface ALNavigationController ()

@end

@implementation ALNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    AppDelegate *myDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [myDelegate.tabVc hideBottomBar:YES];
    [super pushViewController:viewController animated:animated];
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
    AppDelegate *myDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [myDelegate.tabVc hideBottomBar:NO];
    return [super popViewControllerAnimated:animated];
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
