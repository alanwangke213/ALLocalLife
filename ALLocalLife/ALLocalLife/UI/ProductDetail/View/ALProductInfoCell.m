//
//  ALProductInfoCell.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/27.
//  Copyright © 2015年 AL. All rights reserved.
//

#import "ALProductInfoCell.h"

@interface ALProductInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *productInfo;
@property (weak, nonatomic) IBOutlet UILabel *productPrice;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;

@end

@implementation ALProductInfoCell

- (void)awakeFromNib {
    // Initialization code
    _shareBtn.layer.cornerRadius = 3;
    _shareBtn.layer.masksToBounds = YES;
    
    _buyBtn.layer.cornerRadius = 3;
    _buyBtn.layer.masksToBounds = YES;
}

-(void)setProductModel:(ALProductModel *)ProductModel{
    _ProductModel = ProductModel;
    _productName.text = _ProductModel.title;
    _productInfo.text = _ProductModel.content;
    _productPrice.text = [NSString stringWithFormat:@"人均 $ %ld",_ProductModel.price];
    
    NSDictionary *attriDic = @{NSFontAttributeName:[UIFont systemFontOfSize:14],
                               };
    
    CGRect rect = [_ProductModel.content boundingRectWithSize:CGSizeMake(_productInfo.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attriDic context:nil];
    CGRect oriFrame = self.frame;
    self.frame = CGRectMake(oriFrame.origin.x, oriFrame.origin.y, oriFrame.size.width, rect.size.height);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)didClickBuyBtn:(UIButton *)sender{
    
    NSLog(@"买 买 买");
}
- (IBAction)didClickShareBtn:(UIButton *)sender{
    
    NSLog(@"快去炫耀吧");
}

@end
