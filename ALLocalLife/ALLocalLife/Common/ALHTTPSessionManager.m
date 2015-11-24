//
//  ALHTTPSessionManager.m
//  ALLocalLife
//
//  Created by 王可成 on 15/11/23.
//  Copyright © 2015年 AL. All rights reserved.
//

#import "ALHTTPSessionManager.h"
#import "AFNetworking.h"



@implementation ALHTTPSessionManager

+(instancetype)sharedInstance{
    static ALHTTPSessionManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //可以使用manager，baseURL为nil
        //也可以使用initWithBaseURL
        //        manager = [ALHTTPSessionManager manager];
        
        manager = [[ALHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
        
        //序列化
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
    });
    return manager;
}

#pragma mark - Get
+(void)getWith:(NSString *)URLString
    parameters:(id)parameters
       success:(successBlock)success
       failure:(failBlock)failure{
    [[self sharedInstance] getWith:URLString parameters:parameters success:success failure:failure];
}
-(void)getWith:(NSString *)URLString
    parameters:(id)parameters
       success:(successBlock)success
       failure:(failBlock)failure{
    
    [self GET:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //此处获得服务器的返回数据，可以先进行数据转换
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
    
}


#pragma mark - Post
+(void)postWith:(NSString *)URLString
     parameters:(id)parameters
        success:(successBlock)success
        failure:(failBlock)failure{
    [[self sharedInstance] postWith:URLString parameters:parameters success:success failure:failure];
}

-(void)postWith:(NSString *)URLString
     parameters:(id)parameters
        success:(successBlock)success
        failure:(failBlock)failure{
    [self POST:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        //此处获得服务器的返回数据，可以先进行数据转换
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}
@end
