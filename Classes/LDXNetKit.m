//
//  LDXNetKit.m
//  LDXNetKit
//
//  Created by 刘东旭 on 15/8/29.
//  Copyright (c) 2015年 刘东旭. All rights reserved.
//

#import "LDXNetKit.h"

@implementation LDXNetKit

+ (void)GETUrlString:(NSString *)urlString param:(NSDictionary *)param complate:(ComplateBlock)complateBlock failed:(FailedBlock)failedBlock {
    NSMutableURLRequest *request;
    NSString *getStr = urlString;
    getStr = [urlString stringByAppendingString:@"?"];
    NSString *tempstr = @"";
    for (NSString *str in param) {
        NSString *value = [param objectForKey:str];
        [tempstr stringByAppendingFormat:@"%@=%@&",str,value];
    }
    [tempstr substringToIndex:tempstr.length-1];
    NSCharacterSet *encodeUrlSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodeUrl = [getStr stringByAddingPercentEncodingWithAllowedCharacters:encodeUrlSet];
    NSURL *url = [NSURL URLWithString:encodeUrl];
    request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    request.HTTPMethod = @"GET";
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failedBlock(response, error);
        } else {
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            complateBlock(response,result);
        }
    }];
    [task resume];
}
    
+ (void)POSTUrlString:(NSString *)urlString param:(NSDictionary *)param complate:(ComplateBlock)complateBlock failed:(FailedBlock)failedBlock {
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    request.HTTPMethod = @"POST";
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = jsonData;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failedBlock(response, error);
        } else {
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            complateBlock(response,result);
        }
    }];
    [task resume];
}
    
@end
