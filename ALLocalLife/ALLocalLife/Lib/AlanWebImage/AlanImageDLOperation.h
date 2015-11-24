//
//  AlanImageDLOperation.h
//  ImageDownloadFrame
//
//  Created by 王可成 on 15/10/27.
//  Copyright © 2015年 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AlanImageDLOperation : NSOperation

@property (nonatomic, copy) NSString* addr;
@property (nonatomic, copy) void (^finishedBlock)(UIImage* image);

+ (instancetype)operationWith:(NSString*)addr finishedBlock:(void (^)(UIImage* image))finishedBlock;


@end
