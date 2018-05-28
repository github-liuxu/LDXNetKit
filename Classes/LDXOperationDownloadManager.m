//
//  LDXOperationDownloadManager.m
//  LDXNetKit
//
//  Created by 刘东旭 on 2018/5/28.
//  Copyright © 2018年 刘东旭. All rights reserved.
//

#import "LDXOperationDownloadManager.h"
#import "LDXDownload.h"

@interface LDXOperationDownloadManager ()

@property (atomic, strong) NSOperationQueue *queue;

@end

@implementation LDXOperationDownloadManager

+ (LDXOperationDownloadManager *)defaultManager {
    static LDXOperationDownloadManager *defaultManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultManager = LDXOperationDownloadManager.new;
        defaultManager.queue = [[NSOperationQueue alloc] init];
    });
    
    defaultManager.maxDownloadCount = 3;
    defaultManager.downloadDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    return defaultManager;
}

- (void)setMaxDownloadCount:(NSInteger)maxDownloadCount {
    _maxDownloadCount = maxDownloadCount;
    self.queue.maxConcurrentOperationCount = _maxDownloadCount;
}

- (void)removeAllTasks {
    [self.queue cancelAllOperations];
}

- (NSArray<NSOperation *> *)operations {
    return [self.queue operations];
}

- (void)addDownloadTask:(NSString *)urlString param:(NSDictionary *)param progress:(LDXProgress)progress fileName:(NSString *)fileName downloadFinish:(LDXDownloadFinishBlock)downloadFinish downFiald:(LDXDownloadFailedBlock)downloadFiald {
    __weak typeof(self)weakSelf = self;
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        LDXDownload *ldxDownload = [LDXDownload downloadUrlString:urlString param:param progress:progress downLoadFinish:^(NSURLResponse *response, NSString *urlString) {
            downloadFinish(response, urlString);
            dispatch_semaphore_signal(semaphore);
        } failed:^(NSURLResponse *response, NSError *connectionError) {
            downloadFiald(response, connectionError);
            dispatch_semaphore_signal(semaphore);
        }];
        ldxDownload.fileDir = weakSelf.downloadDir;
        ldxDownload.fileName = fileName;
        [ldxDownload.task resume];
        dispatch_wait(semaphore, DISPATCH_TIME_FOREVER);
    }];
    [self.queue addOperation:op];
}

@end
