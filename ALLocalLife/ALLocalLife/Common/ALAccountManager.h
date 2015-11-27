//
//  ALAccountManager.h
//  ALLocalLife
//
//  Created by 王可成 on 15/11/27.
//  Copyright © 2015年 AL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALAccountManager : NSObject

@property (nonatomic ,assign) BOOL isLogined;
+(instancetype)sharedInstance;

+(BOOL)checkLoginStatue;

@end
