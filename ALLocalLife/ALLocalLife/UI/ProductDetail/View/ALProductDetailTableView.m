//
//  ALProductDetailTableView.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/27.
//  Copyright © 2015年 AL. All rights reserved.
//

#import "ALProductDetailTableView.h"
#import "JSONModel.h"
#import "ALProductModel.h"
#import "ALProductInfoCell.h"
#import "ALObjFactory.h"

@interface ALProductDetailTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ALProductDetailTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        
        [self getProductDetaiModel];
    }
    return self;
}

-(void)getProductDetaiModel{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"good_info" ofType:@"plist"];
    self.productModel = [JSONModel arrayOfModelsFromData:[NSData dataWithContentsOfFile:filePath] error:nil][0];
    
    NSLog(@"%@",self.productModel);
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return 1;
    }else if(section == 2){
//        return self.productModel.goods_list.count;
        return 4;
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        ALProductInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ALProductInfoCell"];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"ALProductInfoCell" owner:nil options:nil][0];
        }
        cell.userInteractionEnabled = NO;
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xxx"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xxx"];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 130;
    }else if (indexPath.section == 1){
        return 56;
    }else if (indexPath.section == 2){
        return 178 * 0.6;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 44;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        UILabel *label = [ALObjFactory getLabelwithTitle:@"商家信息" withFont:[UIFont systemFontOfSize:34 * 0.6] withColor:[UIColor colorWithRed:240/255. green:112/255. blue:171/255. alpha:1]];
        label.frame = CGRectMake(10,(44 - 34 * 0.6) * 0.5,kScreenWidth - 20, 34 * 0.6);
        [view addSubview:label];
        view.backgroundColor = [UIColor whiteColor];
        return view;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

@end
