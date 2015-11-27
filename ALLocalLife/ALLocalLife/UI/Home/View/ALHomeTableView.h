//
//  ALHomeTableView.h
//  ALLocalLife
//
//  Created by 王可成 on 15/11/24.
//  Copyright © 2015年 AL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALHomeModel.h"

@protocol HomeTableViewDelegate <NSObject>

@optional
-(void)didClickCellWithIndexpath:(NSIndexPath *)indexpath subIndex:(NSInteger *)index;

@end

@interface ALHomeTableView : UITableView

@property (nonatomic ,strong) ALHomeModel *homeModel;

@property (nonatomic ,weak) id <HomeTableViewDelegate> cellDelegate;

@end
