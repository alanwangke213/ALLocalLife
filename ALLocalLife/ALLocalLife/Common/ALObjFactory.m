//
//  ALObjFactory.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/27.
//  Copyright © 2015年 AL. All rights reserved.
//

#import "ALObjFactory.h"

#define kTFHeight 80 * 0.5

@implementation ALObjFactory

+(instancetype)sharedInstance{
    static ALObjFactory *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ALObjFactory alloc] init];
    });
    return manager;
}

+(UITextField *)getBlueTFWithFrame:(CGRect)rect placeHolder:(NSString *)placeholder{
    return [[ALObjFactory sharedInstance] getBlueTFWithFrame:rect placeHolder:placeholder];
}

-(UITextField *)getBlueTFWithFrame:(CGRect)rect placeHolder:(NSString *)placeholder{
    UITextField *TF = [[UITextField alloc] initWithFrame:rect];
    TF.backgroundColor = [UIColor colorWithRed:0.404 green:0.765 blue:1.000 alpha:1.000];
    TF.textAlignment = NSTextAlignmentLeft;
    NSDictionary *attributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                 NSFontAttributeName : [UIFont systemFontOfSize:15]
                                 };
    TF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:attributes];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, kTFHeight)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kTFHeight, kTFHeight)];
    imageView.image = [UIImage imageNamed:@"login_password"];
    imageView.backgroundColor = [UIColor colorWithRed:0.235 green:0.659 blue:0.965 alpha:1.000];
    [leftView addSubview:imageView];
    
    TF.layer.cornerRadius = 5;
    TF.layer.masksToBounds = YES;
    TF.leftView = leftView;
    TF.leftViewMode = UITextFieldViewModeAlways;
    
    return TF;
}

+(UIButton *)getBlueButtonWithFrame:(CGRect)rect withTitle:(NSString *)title{
    return [[ALObjFactory sharedInstance] getBlueButtonWithFrame:rect withTitle:title];
}

-(UIButton *)getBlueButtonWithFrame:(CGRect)rect withTitle:(NSString *)title{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    
    btn.titleLabel.text = title;
    
    btn.titleLabel.font = [UIFont systemFontOfSize:19];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:title];
    NSRange strRange = {0,[str length]};
    //设置颜色
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255. green:255/255. blue:255/255. alpha:1] range:strRange];
    [btn setAttributedTitle:str forState:UIControlStateNormal];
    
    btn.backgroundColor = [UIColor colorWithRed:0.235 green:0.659 blue:0.965 alpha:1.000];
    
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    return  btn;
}

+(UILabel *)getLabelwithTitle:(NSString *)title withFont:(UIFont *)font withColor:(UIColor *)color{    
    return [[ALObjFactory sharedInstance] getLabelwithTitle:title withFont:font withColor:color];
}

-(UILabel *)getLabelwithTitle:(NSString *)title withFont:(UIFont *)font withColor:(UIColor *)color{
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.font = font;
    label.textColor = color;
    [label sizeToFit];
    return label;
}

+(UIView *)getUIViewWithFrame:(CGRect)rect withColor:(UIColor *)color{
    return [[ALObjFactory sharedInstance] getUIViewWithFrame:rect withColor:color];
}
-(UIView *)getUIViewWithFrame:(CGRect)rect withColor:(UIColor *)color{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = color;
    return view;
}
@end
