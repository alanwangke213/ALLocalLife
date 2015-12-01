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
#import "ALGuessViewCell.h"
#import "AlanDownLoadIMGManager.h"


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
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
//    self.contentOffset 
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
        return self.homeModel.guess.list.count;
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {//group
        
        ALGroupViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (nil == cell) {
            cell = [[ALGroupViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
            cell.backgroundColor = [UIColor colorWithRed:238/255. green:238/255. blue:238/255. alpha:1];
            cell.homeModel = self.homeModel;
            self.groupCell = cell;
            
            cell.selectItemBlock = ^(NSInteger tag){
                if ([self.cellDelegate respondsToSelector:@selector(didClickCellWithIndexpath:subIndex:)]) {
                    [self.cellDelegate didClickCellWithIndexpath:indexPath subIndex:&tag];
                }
            };
            
        }
        return cell;
        
    }else if (indexPath.section == 1){//famous
        
        ALFamousViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ALFamousViewCell"];
        if (nil == cell) {
            cell = [[ALFamousViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ALFamousViewCell"];
            cell.homeModel = _homeModel;
        }
        return cell;
        
    }else if (indexPath.section == 2){//guess
        
        ALGuessViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ALGuessViewCell"];
        if (nil == cell){
            cell = [[NSBundle mainBundle] loadNibNamed:@"ALGuessViewCell" owner:nil options:nil].lastObject;
            cell.frame = CGRectMake(0, 0, kScreenWidth, (182 + 18 + 12) * 0.5);
            
            [[AlanDownLoadIMGManager sharedInstance] downloadIMGWith:[self.homeModel.guess.list[indexPath.row]cover] withFinishedBlock:^(UIImage *image) {
                
                cell.imageVIew.image = image;
                
            }];
            
            cell.titleLabel.text = [self.homeModel.guess.list[indexPath.row] title];
            cell.introLabel.text = [self.homeModel.guess.list[indexPath.row] intro];
            cell.distanceLabel.text = [NSString stringWithFormat:@"距离200米"];
            cell.starView.image = [UIImage imageNamed:[NSString stringWithFormat:@"star_%ld",[self.homeModel.guess.list[indexPath.row] score]]];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    
    //备用
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    cell.backgroundColor = [UIColor greenColor];
    return cell;
}


#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击cell执行代理方法
    if ([self.cellDelegate respondsToSelector:@selector(didClickCellWithIndexpath:subIndex:)]) {
        [self.cellDelegate didClickCellWithIndexpath:indexPath subIndex:nil];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 353 * 0.5;
    }else if (indexPath.section == 1){
        return 393 * 0.5;
    }else if (indexPath.section == 2){
        return (182 + 18 + 12) * 0.5;
    }
    
    else return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }else{
        ALHeaderView *headView = [[ALHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 66 * 0.5)];
        
        headView.backgroundColor = [UIColor whiteColor];
        if (section == 1) {
            headView.imageView.image = [UIImage imageNamed:@"famous"];
        }else if (section == 2){
            headView.imageView.image = [UIImage imageNamed:@"guess"];
        }
        return headView;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 12 * 0.5)];
    footerView.backgroundColor = [UIColor colorWithRed:238/255. green:238/255. blue:238/255. alpha:1];
    return footerView;
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

#pragma mark - KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    CGPoint point = [change[@"new"] CGPointValue];
    if (self.scrollBlock != nil && point.y > 0 && point.y < kScreenHeight * 0.35) {
//        NSLog(@"%@",NSStringFromCGPoint(point));
        self.scrollBlock(point);
    }
}

@end
