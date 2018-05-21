//
//  LDXDownloadManager.m
//  LDXNetKit
//
//  Created by 刘东旭 on 2018/5/20.
//  Copyright © 2018年 刘东旭. All rights reserved.
//

#import "LDXDownloadManager.h"
#import "LDXDownload.h"

@interface LDXDownloadManager ()

@property (nonatomic, strong) NSMutableArray<LDXDownload*> *allTasks;

@end

@implementation LDXDownloadManager

+ (LDXDownloadManager *)manager {
    static LDXDownloadManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = LDXDownloadManager.new;
        manager.maxDownloadCount = 3;
        manager.downloadDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        manager.allTasks = [NSMutableArray array];
    });
    return manager;
}

- (void)removeAllTasks {
    for (LDXDownload *ldxDownload in self.allTasks) {
        [ldxDownload.task cancel];
    }
}

- (void)pauseAllTasks {
    for (LDXDownload *ldxDownload in self.allTasks) {
        if (ldxDownload.task.state == NSURLSessionTaskStateRunning) {
            [ldxDownload.task suspend];
        }
    }
}

- (void)startAllTasks {
    int index = 0;
    for (LDXDownload *ldxDownload in self.allTasks) {
        if (index<self.maxDownloadCount) {
            if (ldxDownload.task.state == NSURLSessionTaskStateSuspended) {
                [ldxDownload.task resume];
            }
        }
        index ++;
    }
}

- (void)setMaxDownloadCount:(NSInteger)maxDownloadCount {
    _maxDownloadCount = maxDownloadCount;
    
}

- (void)setDownloadDir:(NSString *)downloadDir {
    _downloadDir = downloadDir;
    
}

- (void)addDownloadTask:(NSString *)urlString param:(NSDictionary *)param progress:(LDXProgress)progress downloadFinish:(LDXDownloadFinishBlock)downloadFinish downFiald:(LDXDownloadFailedBlock)downloadFiald {
    __weak typeof(self)weakSelf = self;
    __block LDXDownload *ldxDownload = [LDXDownload downloadUrlString:urlString param:param progress:progress downLoadFinish:^(NSURLResponse *response, NSString *urlString) {
        if ([weakSelf.allTasks containsObject:ldxDownload]) {
            [weakSelf.allTasks removeObject:ldxDownload];
        }
        downloadFinish(response, urlString);
    } failed:^(NSURLResponse *response, NSError *connectionError) {
        if ([weakSelf.allTasks containsObject:ldxDownload]) {
            [weakSelf.allTasks removeObject:ldxDownload];
        }
        downloadFiald(response, connectionError);
    }];
    [self.allTasks addObject:ldxDownload];
}

@end
