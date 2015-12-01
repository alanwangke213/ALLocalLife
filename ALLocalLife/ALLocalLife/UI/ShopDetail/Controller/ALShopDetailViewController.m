//
//  ALShopDetailViewController.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/28.
//  Copyright © 2015年 AL. All rights reserved.
//

#import "ALShopDetailViewController.h"
#import "ALShopDetailHeader.h"
#import "ALShopModel.h"
#import "ALShopIntroCell.h"
#import "ALGoodsCell.h"
#import "ALShopSectionHeader.h"


#define kproductNum 2
#define kcommentNum 2
#define kAddNum 2
@interface ALShopDetailViewController ()<UITableViewDataSource,UITableViewDelegate,ALShopDetailDelegate>

@property (nonatomic ,assign) NSInteger productNum;
@property (nonatomic ,assign) NSInteger commentNum;
@property (nonatomic ,weak) UITableView *tableView;
@property (nonatomic ,weak) ALShopDetailHeader *headerView;
@property (nonatomic ,strong) ALShopModel *shopModel;
@end

@implementation ALShopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _productNum = kproductNum;
    _commentNum = kcommentNum;

    self.titleLabel.text = @"商家详情";
    
    [self addSubviews];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.tabBarController.tabBar.hidden = YES;
    [self loadData];
}

-(void)addSubviews{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight + kNavBarHeight, kScreenWidth, kScreenHeight - kStatusBarHeight - kNavBarHeight) style:UITableViewStyleGrouped];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    self.tableView = tableView;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:tableView];
    [self.view bringSubviewToFront:self.navBar];
}

-(void)loadData{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"shop_info" ofType:@"plist"];
    
    NSError *err = nil;
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    ALShopModel *shopModel = [[ALShopModel alloc] initWithDictionary:dict error:&err];
    self.shopModel = shopModel;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0)
        return 1;
    else if (section == 1)
        return self.productNum + 1;
    else if (section == 2)
        return self.commentNum + 1;
    else if (section == 2)
        return 1;
    else
        return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ALShopIntroCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ALShopIntroCell"];
        if (cell == nil) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"ALShopIntroCell" owner:nil options:nil][0];
        }
        cell.introLabel.text = self.shopModel.intro;
//        [cell.introLabel sizeToFit];
        CGRect rect = [cell.introLabel.text boundingRectWithSize:CGSizeMake(cell.introLabel.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil];
        cell.introLabel.bounds = rect;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section == 1){
        if (indexPath.row == self.productNum) {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"moreCell"];
//            UIButton *moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
            UILabel *label = [[UILabel alloc] initWithFrame:cell.bounds];
            label.text = @"加载更多";
            label.font = [UIFont systemFontOfSize:17];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor colorWithRed:57/255. green:173/255. blue:246/255. alpha:1];
            [cell addSubview:label];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        ALGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ALGoodsCell"];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"ALGoodsCell" owner:nil options:nil][0];
        }
        cell.nameLabel.text = [_shopModel.goods[indexPath.row] title];
        cell.priceLabel.text = [_shopModel.goods[indexPath.row] price];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xx"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xx"];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        
        if (indexPath.row == self.productNum) {
            [self getMoreProductCells];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:2];
//            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == self.productNum) {
            [self getMoreCommentCells];
        }
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0)
        return 250 * kScale;
    else if (section == 1)
        return 50;
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        ALShopDetailHeader *headerView = [[NSBundle mainBundle]loadNibNamed:@"ALShopDetailHeader" owner:nil options:nil][0];
        headerView.delegate = self;
        headerView.shopModel = self.shopModel;
        self.headerView = headerView;
        return headerView;
    }else if(section == 1) {
        ALShopSectionHeader *headerView = [[ALShopSectionHeader alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        headerView.imageView.image = [UIImage imageNamed:@"goodsHeader"];
        return headerView;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0)
        return 50;
    else if (indexPath.section == 1)
        return 50;
    else
        return 0;
}

#pragma mark - ALShopDetailDelegate

-(void)presentVc:(UIViewController *)vc{
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

#pragma mark - Button Actions
-(void)getMoreProductCells{
    if (self.shopModel.goods.count - self.productNum > 1) {
        
        self.productNum += 2;
        [self.tableView reloadData];
        
    }else if(self.shopModel.goods.count - self.productNum == 1){
        self.productNum += 1;
        [self.tableView reloadData];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"没有更多了"
                                  message:@"＝。＝ ! ! ~"
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles: nil];
        
        [alertView show];
    }
}

-(void)getMoreCommentCells{
    NSLog(@"more comment cells");
}
@end
