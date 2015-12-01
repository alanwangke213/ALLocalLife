//
//  ALHomeViewController.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/21.
//  Copyright © 2015年 AL. All rights reserved.
//

#import "ALCircleViewController.h"
#import "ALLocationManager.h"

@interface ALCircleViewController ()

@end

@implementation ALCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        self.titleLabel.text = @"圈子";
    
    [ALLocationManager locateSuccess:^(CLLocationCoordinate2D coordinate2D) {
        NSLog(@"coordinate2D --> %f,%f",coordinate2D.latitude,coordinate2D.longitude);
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
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
