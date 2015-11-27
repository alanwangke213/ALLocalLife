//
//  AlanImageDLOperation.m
//  ImageDownloadFrame
//
//  Created by 王可成 on 15/10/27.
//  Copyright © 2015年 Alan. All rights reserved.
//

#import "AlanImageDLOperation.h"
#import "NSString+Path.h"

@implementation AlanImageDLOperation

- (void)main
{
    @autoreleasepool
    {
        NSAssert(self.finishedBlock != nil, @"block can not be nil!");

        NSURL* url = [NSURL URLWithString:self.addr];
        NSData* imageData = [NSData dataWithContentsOfFile:[self.addr appendCachePath]];
        if (!imageData) {
            NSLog(@"download %@", self.addr);

            imageData = [NSData dataWithContentsOfURL:url];
        }

        //cancel
        if ([self isCancelled]) {
            NSLog(@"cancel");
            return;
        }

        if (imageData) {
            //write to sandbox cache
            [imageData writeToFile:[self.addr appendCachePath] atomically:YES];
        }

        UIImage* image = [UIImage imageWithData:imageData];

        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.finishedBlock(image);
        }];
    }
}

+ (instancetype)operationWith:(NSString*)addr finishedBlock:(void (^)(UIImage*))finishedBlock
{

    AlanImageDLOperation* imageDLOp = [[AlanImageDLOperation alloc] init];

    imageDLOp.addr = addr;
    imageDLOp.finishedBlock = finishedBlock;

    return imageDLOp;
}

@end
