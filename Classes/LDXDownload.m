//
//  LDXDownload.m
//  LDXNetKit
//
//  Created by 刘东旭 on 2018/5/20.
//  Copyright © 2018年 刘东旭. All rights reserved.
//

#import "LDXDownload.h"


@interface LDXDownload () <NSURLSessionDownloadDelegate,NSURLSessionTaskDelegate>

@property (nonatomic, copy) LDXProgress progress;
@property (nonatomic, copy) LDXDownloadFinishBlock complateBlock;
@property (nonatomic, copy) LDXDownloadFailedBlock failedBlock;
@property (nonatomic, strong) NSURLSessionDownloadTask *task;
@property (nonatomic, strong) NSString *downloadFilePath;

@end

@implementation LDXDownload

- (void)dealloc {
    NSLog(@"%s",__func__);
}

+ (void)downloadUrlString:(NSString *)urlString param:(NSDictionary *)param downLoadFinish:(LDXDownloadFinishBlock)complateBlock failed:(LDXDownloadFailedBlock)failedBlock {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    if (param) {
        NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingPrettyPrinted error:nil];
        request.HTTPBody = jsonData;
    }
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failedBlock(response, error);
        } else {
            complateBlock(response, location.absoluteString);
        }
    }];
    [task resume];
}

+ (instancetype)downloadUrlString:(NSString *)urlString param:(NSDictionary *)param progress:(LDXProgress)progress downLoadFinish:(LDXDownloadFinishBlock)complateBlock failed:(LDXDownloadFailedBlock)failedBlock {
    LDXDownload *ldxDownload = [[self class] new];
    NSURLSessionDownloadTask *task = [ldxDownload downloadUrlString:urlString param:param progress:progress downLoadFinish:complateBlock failed:failedBlock];
    ldxDownload.task = task;
    return ldxDownload;
}

- (NSURLSessionDownloadTask *)downloadUrlString:(NSString *)urlString param:(NSDictionary *)param progress:(LDXProgress)progress downLoadFinish:(LDXDownloadFinishBlock)complateBlock failed:(LDXDownloadFailedBlock)failedBlock {
    self.progress = progress;
    self.complateBlock = complateBlock;
    self.failedBlock = failedBlock;
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSOperationQueue *op = [[NSOperationQueue alloc] init];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:op];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    if (param) {
        NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingPrettyPrinted error:nil];
        request.HTTPBody = jsonData;
    }
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request];
    return task;
}

#pragma mark -NSURLSessionDelegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    //获取下载进度
    double currentProgress = totalBytesWritten / (double)totalBytesExpectedToWrite;
    dispatch_async(dispatch_get_main_queue(), ^{
        //进行UI操作  设置进度条
        self.progress(currentProgress);
    });
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    // location : 临时文件的路径（下载好的文件）
    
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // response.suggestedFilename ： 建议使用的文件名，一般跟服务器端的文件名一致
    
    NSString *file = [caches stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    
    // 将临时文件剪切或者复制Caches文件夹
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // AtPath : 剪切前的文件路径
    // ToPath : 剪切后的文件路径
    [mgr moveItemAtPath:location.path toPath:file error:nil];
    self.downloadFilePath = file;
}

- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error {
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error {
    [session invalidateAndCancel];
    if (error) {
        self.failedBlock(task.response, error);
    } else {
        self.complateBlock(task.response, self.downloadFilePath);
    }
}


@end
