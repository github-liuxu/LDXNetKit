//
//  LDXNetKit.h
//  LDXNetKit
//
//  Created by 刘东旭 on 15/8/29.
//  Copyright (c) 2015年 刘东旭. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^ComplateBlock)(NSURLResponse *response,NSDictionary *result);
typedef void(^FailedBlock)(NSURLResponse *response,NSError *connectionError);

@interface LDXNetKit : NSObject

+ (void)GETUrlString:(NSString *)urlString param:(NSDictionary *)param complate:(ComplateBlock)complateBlock failed:(FailedBlock)failedBlock;
    
+ (void)POSTUrlString:(NSString *)urlString param:(NSDictionary *)param complate:(ComplateBlock)complateBlock failed:(FailedBlock)failedBlock;

@end
