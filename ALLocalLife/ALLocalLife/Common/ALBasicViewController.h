//
//  ALBasicViewController.h
//  ALLocalLife
//
//  Created by 王可成 on 15/11/21.
//  Copyright © 2015年 AL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALBasicViewController : UIViewController

@property (nonatomic ,strong) UIView *navBar;

@property (nonatomic ,strong) UIButton *leftButton;

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UIButton *rightButton;

-(void)showLoadView;
-(void)hideLoadView;


@end
