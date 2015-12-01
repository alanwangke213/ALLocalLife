//
//  ALShopDetail.h
//  ALLocalLife
//
//  Created by 王可成 on 15/11/28.
//  Copyright © 2015年 AL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ALShopModel;

@protocol ALShopDetailDelegate <NSObject>

@optional
-(void)presentVc:(UIViewController *)vc;
@end

@interface ALShopDetailHeader : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *starLabel;
@property (weak, nonatomic) IBOutlet UIImageView *starView;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;

@property (nonatomic ,strong) ALShopModel *shopModel;

@property (nonatomic ,strong)id<ALShopDetailDelegate>delegate;

@end
