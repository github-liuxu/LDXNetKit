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

@property (atomic, strong) NSMutableArray<LDXDownload*> *allTasks;

@end

@implementation LDXDownloadManager

+ (LDXDownloadManager *)defaultManager {
    static LDXDownloadManager *defaultManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultManager = LDXDownloadManager.new;
        defaultManager.allTasks = [NSMutableArray array];
    });
    
    defaultManager.maxDownloadCount = 3;
    defaultManager.downloadDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    return defaultManager;
}

- (void)removeAllTasks {
    for (LDXDownload *ldxDownload in self.allTasks) {
        [ldxDownload.task cancel];
    }
}

- (void)pauseAllTasks {
    for (LDXDownload *ldxDownload in self.allTasks) {
        ldxDownload.isPause = YES;
        if (ldxDownload.task.state == NSURLSessionTaskStateRunning) {
            [ldxDownload.task suspend];
        }
    }
}

- (void)startAllTasks {
    [self startTasksWithContainManualPause:YES];
}

- (void)startTaskWithIndex:(NSInteger)index {
    if (index >= self.allTasks.count) {
        return ;
    }
    NSInteger downloadingCount = [self getDownloadingTaskCount];
    if (downloadingCount >= self.maxDownloadCount) {
        return ;
    }
    
    LDXDownload *ldxDownload = self.allTasks[index];
    ldxDownload.isPause = NO;
    if (ldxDownload.task.state == NSURLSessionTaskStateSuspended) {
        [ldxDownload.task resume];
    }
    
}

- (void)pauseTaskWithIndex:(NSInteger)index {
    if (index >= self.allTasks.count) {
        return ;
    }
    
    if (index >= self.maxDownloadCount) {
        return;
    } else {
        LDXDownload *ldxDownload = self.allTasks[index];
        ldxDownload.isPause = YES;
        if (ldxDownload.task.state == NSURLSessionTaskStateRunning) {
            [ldxDownload.task suspend];
        }
    }
}

- (void)removeTaskWithIndex:(NSInteger)index {
    if (index >= self.allTasks.count) {
        return ;
    }

    if (index >= self.maxDownloadCount) {
        return;
    } else {
        LDXDownload *ldxDownload = self.allTasks[index];
        [ldxDownload.task cancel];
        [self.allTasks removeObject:ldxDownload];
        ldxDownload = nil;
    }
}

- (void)setMaxDownloadCount:(NSInteger)maxDownloadCount {
    _maxDownloadCount = maxDownloadCount;
    [self startTasksWithContainManualPause:NO];
}

- (void)startTasksWithContainManualPause:(BOOL)isContainManualPause {
    NSInteger downloadingCount = [self getDownloadingTaskCount];
    if (_maxDownloadCount > downloadingCount) {
        //最大下载个数大于正在下载的个数
        //从下载队列查找未下载的任务启动下载(_maxDownloadCount - downloadingCount)
        NSInteger index = _maxDownloadCount - downloadingCount;
        for (int i = 0; i < self.allTasks.count; i++) {
            LDXDownload *ldxDownload = self.allTasks[i];
            if (isContainManualPause) {
                if (ldxDownload.task.state == NSURLSessionTaskStateSuspended) {
                    if (index <= 0) {
                        return ;
                    }
                    [ldxDownload.task resume];
                    index --;
                }
            } else {
                //如果不是被暂停的则启动
                if (!ldxDownload.isPause) {
                    if (ldxDownload.task.state == NSURLSessionTaskStateSuspended) {
                        if (index <= 0) {
                            return ;
                        }
                        [ldxDownload.task resume];
                        index --;
                    }
                }
            }
        }
        
    } else if (_maxDownloadCount == downloadingCount) {
        return ;
    } else {
        //最大下载个数小于正在下载的个数
        //从下载队列查找正在下载的任务停止下载(downloadingCount - _maxDownloadCount)
        NSInteger index = downloadingCount - _maxDownloadCount;
        for (int i = 0; i < self.allTasks.count; i++) {
            LDXDownload *ldxDownload = self.allTasks[self.allTasks.count-1-i];
            //如果不是被手动暂停的则停止
            if (!ldxDownload.isPause) {
                if (ldxDownload.task.state == NSURLSessionTaskStateSuspended) {
                    if (index <= 0) {
                        return ;
                    }
                    [ldxDownload.task suspend];
                    index --;
                }
            }
        }
        
    }
}

- (NSInteger)getDownloadingTaskCount {
    int taskIndex = 0;
    for (LDXDownload *ldxDownload in self.allTasks) {
        if (ldxDownload.task.state == NSURLSessionTaskStateRunning) {
            taskIndex ++;
        }
    }
    return taskIndex;
}

- (void)addDownloadTask:(NSString *)urlString param:(NSDictionary *)param progress:(LDXProgress)progress fileName:(NSString *)fileName downloadFinish:(LDXDownloadFinishBlock)downloadFinish downFiald:(LDXDownloadFailedBlock)downloadFiald {
    __weak typeof(self)weakSelf = self;
    __block LDXDownload *ldxDownload = [LDXDownload downloadUrlString:urlString param:param progress:progress downLoadFinish:^(NSURLResponse *response, NSString *urlString) {
        if ([weakSelf.allTasks containsObject:ldxDownload]) {
            [weakSelf.allTasks removeObject:ldxDownload];
        }
        downloadFinish(response, urlString);
        ldxDownload = nil;
        [weakSelf startTasksWithContainManualPause:NO];
    } failed:^(NSURLResponse *response, NSError *connectionError) {
        if ([weakSelf.allTasks containsObject:ldxDownload]) {
            [weakSelf.allTasks removeObject:ldxDownload];
        }
        downloadFiald(response, connectionError);
        ldxDownload = nil;
    }];
    ldxDownload.fileDir = self.downloadDir;
    ldxDownload.fileName = fileName;
    [self.allTasks addObject:ldxDownload];
}

@end
