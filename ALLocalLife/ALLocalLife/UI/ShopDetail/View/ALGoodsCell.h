//
//  ALGoodsCell.h
//  ALLocalLife
//
//  Created by 王可成 on 15/11/30.
//  Copyright © 2015年 AL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALShopModel.h"

@interface ALGoodsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *serverLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkDetailBtn;

@property (nonatomic ,strong) ALShopModel *shopModel;
@end
