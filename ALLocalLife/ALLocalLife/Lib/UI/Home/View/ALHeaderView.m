//
//  ALHeaderView.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/25.
//  Copyright © 2015年 AL. All rights reserved.
//

#import "ALHeaderView.h"
#define kImageViewX 15
#define kImageViewY 5
#define kImageViewW 100
#define kImageViewH 23
@implementation ALHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kImageViewX, kImageViewY, kImageViewW, kImageViewH)];
        self.imageView = imageView;
        [self addSubview:imageView];
    }
    return self;
}

@end
