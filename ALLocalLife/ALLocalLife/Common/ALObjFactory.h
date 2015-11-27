//
//  ALObjFactory.h
//  ALLocalLife
//
//  Created by 王可成 on 15/11/27.
//  Copyright © 2015年 AL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ALObjFactory : NSObject

+(instancetype)sharedInstance;

+(UITextField *)getBlueTFWithFrame:(CGRect)rect placeHolder:(NSString *)placeholder;

+(UIButton *)getBlueButtonWithFrame:(CGRect)rect withTitle:(NSString *)title;

+(UILabel *)getLabelwithTitle:(NSString *)title withFont:(UIFont *)font withColor:(UIColor *)color;

+(UIView *)getUIViewWithFrame:(CGRect)rect withColor:(UIColor *)color;
@end
