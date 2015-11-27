//
//  UIImageView+DownloadIMG.m
//  DownloadImages——optimize
//
//  Created by 王可成 on 15/10/27.
//  Copyright © 2015年 Alan. All rights reserved.
//

#import "UIImageView+WebCache.h"
#import <objc/runtime.h>
#import "AlanDownLoadIMGManager.h"

const void* currentAddrKey = "currentAddr"; //指针，用来存放关联的对象的地址
@implementation UIImageView (DownloadIMG)

- (void)setCurrentAddr:(NSString*)currentAddr
{
    objc_setAssociatedObject(self, currentAddrKey, currentAddr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString*)currentAddr
{
    return objc_getAssociatedObject(self, currentAddrKey);
}

- (void)downloadIMGWithAddress:(NSString*)address
{
    AlanDownLoadIMGManager* alanDLIMGManager = [AlanDownLoadIMGManager sharedInstance];

    if ([address isEqualToString:[self currentAddr]]) {
        [alanDLIMGManager cancelDLIMGWithAddress:address];
    }

    [self setCurrentAddr:address];

    [alanDLIMGManager downloadIMGWith:address
                    withFinishedBlock:^(UIImage* image) {
                        self.image = image;
                    }];
}

-(void)downloadIMGWithAddress:(NSString *)address withPlaceHolder:(NSString *)imageName{
    self.image = [UIImage imageNamed:imageName];
    [self downloadIMGWithAddress:address];
}
@end
