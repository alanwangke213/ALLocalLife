//
//  UIImageView+DownloadIMG.h
//  DownloadImages——optimize
//
//  Created by 王可成 on 15/10/27.
//  Copyright © 2015年 Alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (DownloadIMG)

- (void)downloadIMGWithAddress:(NSString *)address;
- (void)downloadIMGWithAddress:(NSString *)address
               withPlaceHolder:(NSString *)imageName;
@end
