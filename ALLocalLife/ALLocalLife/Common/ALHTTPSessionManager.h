//
//  ALHTTPSessionManager.h
//  ALLocalLife
//
//  Created by 王可成 on 15/11/23.
//  Copyright © 2015年 AL. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef void (^successBlock)(id response);
typedef void (^failBlock)(NSError *error);

@interface ALHTTPSessionManager : AFHTTPSessionManager

+(instancetype)sharedInstance;



+(void)getWith:(NSString *)URLString
                      parameters:(id)parameters
                         success:(successBlock)success
                         failure:(failBlock)failure;


+(void)postWith:(NSString *)URLString
                       parameters:(id)parameters
                          success:(successBlock)success
                          failure:(failBlock)failure;


@end
