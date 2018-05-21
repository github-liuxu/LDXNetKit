//
//  LDXDownload.h
//  LDXNetKit
//
//  Created by 刘东旭 on 2018/5/20.
//  Copyright © 2018年 刘东旭. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LDXDownloadFinishBlock)(NSURLResponse *response,NSString *urlString);
typedef void(^LDXProgress)(float progress);
typedef void(^LDXDownloadFailedBlock)(NSURLResponse *response,NSError *connectionError);

@interface LDXDownload : NSObject

@property (nonatomic, strong, readonly) NSURLSessionDownloadTask *task;

+ (void)downloadUrlString:(NSString *)urlString param:(NSDictionary *)param downLoadFinish:(LDXDownloadFinishBlock)complateBlock failed:(LDXDownloadFailedBlock)failedBlock;

+ (instancetype)downloadUrlString:(NSString *)urlString param:(NSDictionary *)param progress:(LDXProgress)progress downLoadFinish:(LDXDownloadFinishBlock)complateBlock failed:(LDXDownloadFailedBlock)failedBlock;

@end
