//
//  LDXNetKit.h
//  LDXNetKit
//
//  Created by 刘东旭 on 15/8/29.
//  Copyright (c) 2015年 刘东旭. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^LDXComplateBlock)(NSURLResponse *response,NSDictionary *result);
typedef void(^LDXFailedBlock)(NSURLResponse *response,NSError *connectionError);
typedef void(^LDXDownloadFinishBlock)(NSURLResponse *response,NSString *urlString);
typedef void(^LDXProgress)(float progress);

@interface LDXNetKit : NSObject

@property (nonatomic,strong,readonly) NSMutableArray <NSURLSessionDownloadTask *>*taskArray;

+ (void)GETUrlString:(NSString *)urlString param:(NSDictionary *)param complate:(LDXComplateBlock)complateBlock failed:(LDXFailedBlock)failedBlock;
    
+ (void)POSTUrlString:(NSString *)urlString param:(NSDictionary *)param complate:(LDXComplateBlock)complateBlock failed:(LDXFailedBlock)failedBlock;

+ (void)downloadUrlString:(NSString *)urlString param:(NSDictionary *)param downLoadFinish:(LDXDownloadFinishBlock)complateBlock failed:(LDXFailedBlock)failedBlock;

- (void)downloadUrlString:(NSString *)urlString param:(NSDictionary *)param progress:(LDXProgress)progress downLoadFinish:(LDXDownloadFinishBlock)complateBlock failed:(LDXFailedBlock)failedBlock;

- (void)cancelAllTask;

@end
