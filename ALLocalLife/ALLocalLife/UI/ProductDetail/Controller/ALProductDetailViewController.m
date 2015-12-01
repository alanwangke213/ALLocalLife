//
//  ALProductDetailViewController.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/27.
//  Copyright © 2015年 AL. All rights reserved.
//

#import "ALProductDetailViewController.h"
#import "ALProductDetailTableView.h"

@interface ALProductDetailViewController ()

@end

@implementation ALProductDetailViewController

-(void)awakeFromNib{
    [self addSubviews];
        [self.view bringSubviewToFront:self.navBar];
    self.titleLabel.text = @"商品详情";
}

-(void)addSubviews{
    ALProductDetailTableView *proDetailTableView = [[ALProductDetailTableView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, kScreenWidth, kScreenHeight - kStatusBarHeight) style:UITableViewStyleGrouped];
    
    [self.view addSubview:proDetailTableView];
}

#pragma mark - UITableViewDelegate

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
