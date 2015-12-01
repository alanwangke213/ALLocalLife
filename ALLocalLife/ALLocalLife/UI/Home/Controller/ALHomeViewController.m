//
//  ALHomeViewController.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/21.
//  Copyright © 2015年 AL. All rights reserved.
//

#import "ALHomeViewController.h"
#import "ALHomeModel.h"
#import "ALHTTPSessionManager.h"
#import "ALHomeTableView.h"
#import "ALProductDetailViewController.h"
#import <objc/runtime.h>
#import "ALShopDetailViewController.h"

@interface ALHomeViewController ()<HomeTableViewDelegate>
@property (nonatomic ,strong) ALHomeModel *homeModel;
@property (nonatomic ,weak) ALHomeTableView *tableView;
@end

@implementation ALHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = @"青岛生活圈";
    self.leftButton.hidden = YES;
    
    //初始化home界面
    [self initialHomeView];
    
    //当tableView加载完之后再将navBar提到最前面
    [self.view bringSubviewToFront:self.navBar];
    self.navBar.alpha = 0;
    [self loadData];
}

-(void)initialHomeView{
    
    ALHomeTableView *tableView = [[ALHomeTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabBarHeight) style:UITableViewStyleGrouped];
    tableView.cellDelegate = self;

    tableView.scrollBlock = ^(CGPoint point){
        if (point.y != 0) {
//            NSLog(@"%@",NSStringFromCGPoint(point));
            self.navBar.alpha = (point.y/(kScreenHeight * 0.35));
        }
    };
    self.tableView = tableView;

    [self.view addSubview:tableView];
    
    //当控制器添加一个scrollView的时候会自动调整内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)loadData{
    
    //MBProgerssHUD
    [self showLoadViewWithTitle:@"加载数据中"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideLoadView];
    });
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"home" ofType:@"plist"];
    
    NSError *err = nil;
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    ALHomeModel *homeModel = [[ALHomeModel alloc] initWithDictionary:dict error:&err];
    self.tableView.homeModel = homeModel;
    
}

#pragma mark - HomeTableViewDelegate
-(void)didClickCellWithIndexpath:(NSIndexPath *)indexpath subIndex:(NSInteger *)tag{
    
    if (indexpath.section == 0) {//group
        ALShopDetailViewController *shopDetailVc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ALShopDetailViewController"];
        
        [self.navigationController showViewController:shopDetailVc sender:nil];
    }else if(indexpath.section == 1){//famous
        NSLog(@"？？？");
    }else if (indexpath.section == 2) {//guess
        ALProductDetailViewController *productDetailVc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ALProductDetailViewController"];
        
        [self.navigationController showViewController:productDetailVc sender:nil];
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
