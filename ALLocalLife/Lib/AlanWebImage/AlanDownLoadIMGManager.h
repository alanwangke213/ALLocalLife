//
//  AlanDownLoadIMGManager.h
//  ImageDownloadFrame
//
//  Created by 王可成 on 15/10/27.
//  Copyright © 2015年 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AlanDownLoadIMGManager : NSObject

//singleton
+(instancetype)sharedInstance;


/**
 *    download png jpg etc
 *
 *    @param address url
 *    @param finishedBlock
 */
-(void)downloadIMGWith:(NSString *)address withFinishedBlock:(void(^)(UIImage *image))finishedBlock;

/**
 *    cancel downloading the pre image
 *
 *    @param address url
 */
-(void)cancelDLIMGWithAddress:(NSString *)address;

/**
 *    the manager flush the memory caches when catching the notice of NSApplicationDidReceiveMemoryWarningNotification
 */
-(void)flushMemoryCache;


@end
