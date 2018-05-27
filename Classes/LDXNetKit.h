//
//  LDXNetKit.h
//  LDXNetKit
//
//  Created by 刘东旭 on 15/8/29.
//  Copyright (c) 2015年 刘东旭. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LDXComplateBlock)(NSURLResponse *response,NSDictionary *result);
typedef void(^LDXResultBlock)(NSURLResponse *response,NSString *result);
typedef void(^LDXFailedBlock)(NSURLResponse *response,NSError *connectionError);

@interface LDXNetKit : NSObject

@property (nonatomic,strong,readonly) NSMutableArray <NSURLSessionDownloadTask *>*taskArray;
//返回字典
+ (void)GETUrlString:(NSString *)urlString param:(NSDictionary *)param complate:(LDXComplateBlock)complateBlock failed:(LDXFailedBlock)failedBlock;
//返回字符串
+ (void)GETUrlString:(NSString *)urlString param:(NSDictionary *)param result:(LDXResultBlock)resultBlock failed:(LDXFailedBlock)failedBlock;
//返回字典
+ (void)POSTUrlString:(NSString *)urlString param:(NSDictionary *)param complate:(LDXComplateBlock)complateBlock failed:(LDXFailedBlock)failedBlock;
//返回字符串
+ (void)POSTUrlString:(NSString *)urlString param:(NSDictionary *)param result:(LDXResultBlock)resultBlock failed:(LDXFailedBlock)failedBlock;

@end
