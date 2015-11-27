//
//  ALTabViewController.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/21.
//  Copyright © 2015年 AL. All rights reserved.
//

#import "ALTabBarController.h"
#import "ALAroundViewController.h"
#import "ALCircleViewController.h"
#import "ALHomeViewController.h"
#import "ALNewsViewController.h"
#import "ALServicesViewController.h"
#import "ALToolsViewController.h"
#import "ALUsViewController.h"
#import "ALOnLiveViewController.h"
#import "ALNavigationController.h"

#define kTabBarBtnCount 5
#define kMoreViewBtnCount 4
#define kTabBarButtnWidth self.tabBar.frame.size.width/kTabBarBtnCount
//#define kTabBarHeight self.tabBar.frame.size.height
#define kMoreViewHeight 44
@interface ALTabBarController ()
@property (nonatomic ,weak) UIButton *currBtn;
@property (nonatomic ,weak) UIView *moreView;
@property (nonatomic ,assign ,getter=isShow) BOOL show;
@end

@implementation ALTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTabView];
    [self addMoreView];
    [self addChildViewControllers];
}

-(void)addTabView{
    UIView *tabView = [[UIView alloc] initWithFrame:self.tabBar.frame];
    tabView.backgroundColor = [UIColor redColor];
    
    for (int i = 0; i < kTabBarBtnCount; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat btnW = kTabBarButtnWidth;
        CGFloat btnH = kTabBarHeight;
        CGFloat btnX = i * btnW;
        CGFloat btnY = 0;
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"home_%d",i]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"home_%d_pressed",i]] forState:UIControlStateSelected];
        
        btn.tag = i;
        
        [btn addTarget:self action:@selector(changeVc:) forControlEvents:UIControlEventTouchDown];
        btn.adjustsImageWhenHighlighted = NO;
        [tabView addSubview:btn];
        
        if (i == 0) {
            btn.selected = YES;
            self.currBtn = btn;
        }
        
    }
    
    [self.view addSubview: tabView];
    self.tabBar.hidden = YES;
    
}

-(void)addChildViewControllers{
    NSArray *vcNameArray = @[@"ALHomeViewController",
                             @"ALNewsViewController",
                             @"ALCircleViewController",
                             @"ALToolsViewController",
                             @"ALServicesViewController",
                             @"ALOnLiveViewController",
                             @"ALUsViewController",
                             @"ALAroundViewController"
                             ];
    
    NSMutableArray *vcArray = [NSMutableArray array];
    
    [vcNameArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:obj];
        
        ALNavigationController *nav = [[ALNavigationController alloc] initWithRootViewController:vc];
        
        [vcArray addObject:nav];
        
    }];
    
    self.viewControllers = vcArray;
    
}

-(void)addMoreView{
    //UIView *moreView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth, kScreenHeight - kTabBarHeight - kMoreViewHeight, kScreenWidth, kMoreViewHeight)];
    
    UIView *moreView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth, CGRectGetMinY(self.tabBar.frame) - kMoreViewHeight, kScreenWidth, kMoreViewHeight)];
    self.show = NO;
    moreView.userInteractionEnabled = YES;
    self.moreView = moreView;
    [self.view addSubview:moreView];
    
    /*--------- add button ---------*/
    //    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    //    view.backgroundColor = [UIColor redColor];
    //    [moreView addSubview:view];
    UIButton *btnService = [self getBtnWithFrame:CGRectMake(0, 0, 136/640.0 * kScreenWidth, kMoreViewHeight) withTitle:@"社区服务"];
    btnService.tag = 5;
    [btnService addTarget:self action:@selector(changeVc:) forControlEvents:UIControlEventTouchUpInside];
    [moreView addSubview:btnService];
    
    UIButton *btnTools = [self getBtnWithFrame:CGRectMake(186/640.0 *kScreenWidth, 0, 136/640.0 * kScreenWidth, kMoreViewHeight) withTitle:@"生活工具"];
    btnTools.tag = 6;
    [btnTools addTarget:self action:@selector(changeVc:) forControlEvents:UIControlEventTouchUpInside];
    [moreView addSubview:btnTools];
    
    UIButton *btnAround = [self getBtnWithFrame:CGRectMake(368/640.0 *kScreenWidth, 0, 88/640.0 * kScreenWidth, kMoreViewHeight) withTitle:@"周边"];
    btnAround.tag = 7;
    [btnAround addTarget:self action:@selector(changeVc:) forControlEvents:UIControlEventTouchUpInside];
    [moreView addSubview:btnAround];
    
    UIButton *btnClose = [self getBtnWithFrame:CGRectMake(508/640.0 *kScreenWidth, 0, 88/640.0 * kScreenWidth, kMoreViewHeight) withTitle:@"收起"];
    btnClose.tag = 8;
    [btnClose addTarget:self action:@selector(changeVc:) forControlEvents:UIControlEventTouchUpInside];
    [moreView addSubview:btnClose];
    
    /*--------- background Color ---------*/
    UIGraphicsBeginImageContext(moreView.bounds.size);
    [[UIImage imageNamed:@"home_topbar"] drawInRect:moreView.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    moreView.backgroundColor = [UIColor colorWithPatternImage:image];
    
    UIGraphicsEndImageContext();
    NSLog(@"%ld",self.moreView.subviews.count);
}

-(void)changeVc:(UIButton *)sender{

    self.currBtn.selected = NO;
    sender.selected = YES;
    self.currBtn = sender;

    if (self.isShow == YES) {
        [UIView animateWithDuration:0.5 animations:^{
            self.moreView.transform = CGAffineTransformTranslate(self.moreView.transform, kScreenWidth, 0);
            self.show = NO;
        }];
    }
    if (sender.tag < 4) {
        self.selectedIndex = sender.tag;
    }else if (sender.tag == 4) {
        if (self.show == NO) {
            [UIView animateWithDuration:0.5 animations:^{
                self.moreView.transform = CGAffineTransformTranslate(self.moreView.transform, -kScreenWidth, 0);
                self.show = YES;
            }];
        }
        
    }else if ( sender.tag > 4 && sender.tag != 8){
        self.selectedIndex = sender.tag - 1;
    }
    
}

-(UIButton *)getBtnWithFrame:(CGRect)rect withTitle:(NSString *)title{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rect;
    //    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTintColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:1]];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [self.moreView addSubview:btn];
    return btn;
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
