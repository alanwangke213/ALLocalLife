//
//  ALGuideViewController.h
//  ALLocalLife
//
//  Created by 王可成 on 15/11/22.
//  Copyright © 2015年 AL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALGuideViewController : UICollectionViewController

@property (nonatomic ,copy) void(^loginBlock)(BOOL login);

@end
