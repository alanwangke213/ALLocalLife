//
//  ALMerchantInfoCell.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/28.
//  Copyright © 2015年 AL. All rights reserved.
//

#import "ALMerchantInfoCell.h"


@interface ALMerchantInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UIButton *telPhoneBtn;
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;
@end


@implementation ALMerchantInfoCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setProductModel:(ALProductModel *)productModel{
    _productModel = productModel;
    _productName.text = self.productModel.shop_name;
    [_telPhoneBtn setTitle:productModel.phone forState:UIControlStateNormal];
    [_locationBtn setTitle:productModel.address forState:UIControlStateNormal];
    [_locationBtn sizeToFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
