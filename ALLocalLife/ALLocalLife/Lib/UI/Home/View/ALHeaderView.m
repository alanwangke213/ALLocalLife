//
//  ALHeaderView.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/25.
//  Copyright © 2015年 AL. All rights reserved.
//

#import "ALHeaderView.h"
#define kLabelX 15
#define kLabelH 17
@implementation ALHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kLabelX, 0, kScreenWidth - kLabelX * 2, kLabelH)];
        label.textAlignment = NSTextAlignmentLeft;
        self.label = label;
    }
    return self;
}

@end
