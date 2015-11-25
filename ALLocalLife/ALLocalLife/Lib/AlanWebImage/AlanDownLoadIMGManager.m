//
//  AlanDownLoadIMGManager.m
//  ImageDownloadFrame
//
//  Created by 王可成 on 15/10/27.
//  Copyright © 2015年 Alan. All rights reserved.
//

#import "AlanDownLoadIMGManager.h"
#import "AlanImageDLOperation.h"
#import "NSString+Path.h"

@interface AlanDownLoadIMGManager ()

@property (nonatomic, strong) NSOperationQueue* opQueue;
@property (nonatomic, strong) NSMutableDictionary* operationCache;
@property (nonatomic, strong) NSMutableDictionary* memoryCache;

@end

@implementation AlanDownLoadIMGManager

#pragma mark - Lazy
- (NSMutableDictionary*)operationCache
{
    if (!_operationCache) {
        _operationCache = [NSMutableDictionary dictionary];
    }
    return _operationCache;
}

- (NSOperationQueue*)opQueue
{
    if (nil == _opQueue) {
        _opQueue = [[NSOperationQueue alloc] init];
    }
    return _opQueue;
}

- (NSMutableDictionary*)memoryCache
{
    if (!_memoryCache) {
        _memoryCache = [NSMutableDictionary dictionary];
    }
    return _memoryCache;
}

+ (instancetype)sharedInstance
{
    static AlanDownLoadIMGManager* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AlanDownLoadIMGManager alloc] init];
    });
    return instance;
}

#pragma mark - downloadIMG
- (void)downloadIMGWith:(NSString*)address withFinishedBlock:(void (^)(UIImage*))finishedBlock
{
    if (self.memoryCache[address]) {
        NSLog(@"memory cache");
        finishedBlock(self.memoryCache[address]);
        return;
    }
    else {
        UIImage* image = [UIImage imageWithContentsOfFile:[address appendCachePath]];
        if (image) {
            NSLog(@"sandbox");
            [self.memoryCache setObject:image forKey:address];
            finishedBlock(image);
            return;
        }
    }

    if (self.operationCache[address]) {
        NSLog(@"image is downloading...");
        return;
    }

    AlanImageDLOperation* imageDLOp = [AlanImageDLOperation
        operationWith:address
        finishedBlock:^(UIImage* image) {
            if (image) {
                [self.memoryCache setObject:image forKey:address];
                
                [self.operationCache removeObjectForKey:address];
                
                finishedBlock(image);
            }

        }];

    [self.operationCache setObject:imageDLOp forKey:address];

    [self.opQueue addOperation:imageDLOp];
}

//可以防止图片乱跳
- (void)cancelDLIMGWithAddress:(NSString*)address
{
    AlanImageDLOperation* alanDLOp = self.operationCache[address];
    if (alanDLOp) {
        NSLog(@"cancel %@", alanDLOp);
        [alanDLOp cancel];
    }
}

- (void)flushMemoryCache
{
    [self.memoryCache removeAllObjects];
}

@end
