//
//  ALShopView.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/30.
//  Copyright © 2015年 AL. All rights reserved.
//

#import "ALShopSectionHeader.h"

@implementation ALShopSectionHeader

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20 * kScale, 70 * kScale, 40 * kScale)];
        self.imageView = imageView;
        [self addSubview:imageView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end
