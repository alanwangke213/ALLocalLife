//
//  ALGoodsCell.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/30.
//  Copyright © 2015年 AL. All rights reserved.
//

#import "ALGoodsCell.h"

@implementation ALGoodsCell

- (void)awakeFromNib {
    // Initialization code
    _checkDetailBtn.layer.cornerRadius = 5;
    _checkDetailBtn.layer.masksToBounds = YES;
    [_checkDetailBtn addTarget:self action:@selector(checkInfoOfTheProduct) forControlEvents:UIControlEventTouchUpInside];
}

-(void)checkInfoOfTheProduct{
    NSLog(@"查看详情");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
