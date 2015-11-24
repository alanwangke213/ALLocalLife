//
//  ALLocationManager.h
//  ALLocalLife
//
//  Created by 王可成 on 15/11/22.
//  Copyright © 2015年 AL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^successBlock)(CLLocationCoordinate2D coordinate2D);
typedef void(^failBlock)(NSError *error);

@interface ALLocationManager : NSObject

+(instancetype)sharedInstance;

+(void)locateSuccess:(successBlock)successHandler fail:(failBlock)failHanlder;

@end
