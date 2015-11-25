//
//  ALHomeTableView.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/24.
//  Copyright © 2015年 AL. All rights reserved.
//

#import "ALHomeTableView.h"
#import "ALFocusView.h"
#import "ALGroupViewCell.h"
#import "ALFamousViewCell.h"
#import "ALHeaderView.h"

@interface ALHomeTableView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,weak) ALFocusView *focusView;
@property (nonatomic ,weak) ALGroupViewCell *groupCell;
@end

@implementation ALHomeTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        [self loadSubViews];
        self.dataSource = self;
        self.delegate = self;
        
        self.backgroundColor = [UIColor colorWithRed:238/255. green:238/255. blue:238/255. alpha:1];
    }
    return self;
}

-(void)setHomeModel:(ALHomeModel *)homeModel{
    _homeModel = homeModel;
    self.focusView.homeModel = _homeModel;
}

-(void)loadSubViews{
    
    //tableHeaderView
    ALFocusView *focusView = [[NSBundle mainBundle] loadNibNamed:@"ALFocusView" owner:nil options:nil].lastObject;
    
    focusView.frame = CGRectMake(0, 0, kScreenWidth, 425 * 0.5);
    
    self.focusView = focusView;
    self.tableHeaderView = focusView;
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return kHomeGroups;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return 10;
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {//focus
        
        ALGroupViewCell * cell = [[ALGroupViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.homeModel = self.homeModel;
        self.groupCell = cell;
        return cell;
    }else if (indexPath.section == 1){
        ALFamousViewCell *cell = [[ALFamousViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ALFamousViewCell"];
        cell.backgroundColor = [UIColor lightGrayColor];
        return cell;
    }
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    cell.backgroundColor = [UIColor greenColor];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 353 * 0.5;
    }else if (indexPath.section == 1){
        return 393 * 0.5;
    }else if (indexPath.section == 2){
        return 182 * 0.5;
    }
    
    else return 0;
}

#pragma mark - UITableViewDelegate

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 12 * 0.5)];
    footerView.backgroundColor = [UIColor colorWithRed:238 green:238 blue:238 alpha:1];
    return footerView;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }else{
        ALHeaderView *headView = [[ALHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 66 * 0.5)];
        headView.label.text = @"xxx";
        headView.backgroundColor = [UIColor orangeColor];
        return headView;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 66 * 0.5;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 12 * 0.5;
}

@end
