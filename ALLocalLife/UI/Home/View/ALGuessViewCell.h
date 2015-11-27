//
//  ALGuessViewCell.h
//  ALLocalLife
//
//  Created by 王可成 on 15/11/25.
//  Copyright © 2015年 AL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALGuessViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageVIew;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *starView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;

@end
