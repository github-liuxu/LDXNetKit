//
//  LDXDownloadManager.h
//  LDXNetKit
//
//  Created by 刘东旭 on 2018/5/20.
//  Copyright © 2018年 刘东旭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LDXDownload.h"

@interface LDXDownloadManager : NSObject

typedef void(^LDXDownloadFinishBlock)(NSURLResponse *response,NSString *urlString);
typedef void(^LDXProgress)(float progress);
typedef void(^LDXDownloadFailedBlock)(NSURLResponse *response,NSError *connectionError);

/**
 单例类初始化对象
 */
@property (class, nonatomic, strong, readonly) LDXDownloadManager *defaultManager;

/**
 设置最大下载量
 */
@property (nonatomic, assign) NSInteger maxDownloadCount;

/**
 设置下载文件的路径,默认在/Library/Caches
 */
@property (nonatomic, strong) NSString *downloadDir;

/**
 获取所有的下载任务(不包含已完成的)
 */
@property (atomic, strong, readonly) NSMutableArray<LDXDownload*> *allTasks;

/**
 移除所有的任务
 */
- (void)removeAllTasks;

/**
 暂停所有的任务
 */
- (void)pauseAllTasks;

/**
 开始所有任务
 */
- (void)startAllTasks;

/**
 开始指定任务

 @param index 任务的下标
 */
- (void)startTaskWithIndex:(NSInteger)index;

/**
 暂停指定任务
 
 @param index 任务的下标
 */
- (void)pauseTaskWithIndex:(NSInteger)index;

/**
 取消并移除指定任务
 
 @param index 任务的下标
 */
- (void)removeTaskWithIndex:(NSInteger)index;

/**
 添加一个下载任务

 @param urlString 下载的资源地址
 @param param 参数
 @param progress 进度回调
 @param downloadFinish 下载完成的回调
 @param downloadFiald 下载失败的回调
 */
- (void)addDownloadTask:(NSString *)urlString param:(NSDictionary *)param progress:(LDXProgress)progress fileName:(NSString *)fileName downloadFinish:(LDXDownloadFinishBlock)downloadFinish downFiald:(LDXDownloadFailedBlock)downloadFiald;

@end
