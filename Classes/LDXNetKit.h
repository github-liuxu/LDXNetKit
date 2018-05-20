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

@interface LDXNetKit : NSObject

@property (nonatomic,strong,readonly) NSMutableArray <NSURLSessionDownloadTask *>*taskArray;

+ (void)GETUrlString:(NSString *)urlString param:(NSDictionary *)param complate:(LDXComplateBlock)complateBlock failed:(LDXFailedBlock)failedBlock;
    
+ (void)POSTUrlString:(NSString *)urlString param:(NSDictionary *)param complate:(LDXComplateBlock)complateBlock failed:(LDXFailedBlock)failedBlock;

@end
