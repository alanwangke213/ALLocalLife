//
//  ALGroupViewCell.h
//  ALLocalLife
//
//  Created by 王可成 on 15/11/24.
//  Copyright © 2015年 AL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALHomeModel.h"

typedef void(^didSelectedItemBlock)(NSInteger tag);

@interface ALGroupViewCell : UITableViewCell
@property (nonatomic ,strong) ALHomeModel *homeModel;

@property (nonatomic ,copy) didSelectedItemBlock selectItemBlock;

@end
