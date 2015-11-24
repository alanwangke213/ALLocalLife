//
//  ALLocationManager.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/22.
//  Copyright © 2015年 AL. All rights reserved.
//

#import "ALLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface ALLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic ,strong) CLLocationManager *manager;

@property (nonatomic ,copy) successBlock successLocate;
@property (nonatomic ,copy) failBlock failLocate;

@end

@implementation ALLocationManager

-(instancetype)init{
    if (self = [super init]) {
        _manager = [[CLLocationManager alloc] init];
        
        //ios 8之后需要授权
        if ([_manager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [_manager requestAlwaysAuthorization];
        }
        
        _manager.delegate = self;

    }
    return self;
}

+(instancetype)sharedInstance{
    
    static ALLocationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
        
    return manager;
}

#pragma mark - IPA
+(void)locateSuccess:(successBlock)successHandler
                fail:(failBlock)failHanlder{
    [[self sharedInstance] locateSuccess:successHandler fail:failHanlder];
}

-(void)locateSuccess:(successBlock)successHandler
                fail:(failBlock)failHanlder{
    [_manager startUpdatingLocation];
    self.successLocate = successHandler;
    self.failLocate = failHanlder;
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    [_manager stopUpdatingLocation];

    if (locations.count > 0) {
        CLLocation *location = locations.lastObject;
        
        self.successLocate(location.coordinate);
    }

}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    [_manager stopUpdatingLocation];
    self.failLocate(error);
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status == kCLAuthorizationStatusDenied) {
        [_manager stopUpdatingLocation];
    }
}

@end
