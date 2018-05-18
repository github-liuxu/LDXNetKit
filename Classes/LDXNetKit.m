//
//  LDXNetKit.m
//  LDXNetKit
//
//  Created by 刘东旭 on 15/8/29.
//  Copyright (c) 2015年 刘东旭. All rights reserved.
//

#import "LDXNetKit.h"

@interface LDXNetKit() <NSURLSessionDelegate>

@property (nonatomic, copy) LDXProgress progress;
@property (nonatomic, strong) NSMutableArray *tasks;

@end

@implementation LDXNetKit

- (void)dealloc {
    [self cancelAllTask];
    NSLog(@"%s",__func__);
}

- (instancetype)init {
    if (self = [super init]) {
        self.tasks = [NSMutableArray array];
    }
    return self;
}

+ (void)GETUrlString:(NSString *)urlString param:(NSDictionary *)param complate:(LDXComplateBlock)complateBlock failed:(LDXFailedBlock)failedBlock {
    NSMutableURLRequest *request;
    NSString *getStr = urlString;
    getStr = [urlString stringByAppendingString:@"?"];
    for (NSString* str in param) {
        id value = [param objectForKey:str];
        if ([value isKindOfClass:[NSString class]]) {
            getStr = [getStr stringByAppendingFormat:@"%@=%@&",str,value];
        } else {
            NSInteger tempNum = [value integerValue];
            getStr = [getStr stringByAppendingFormat:@"%@=%ld&",str,tempNum];
        }
    }
    getStr = [getStr substringToIndex:getStr.length-1];
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
    
+ (void)POSTUrlString:(NSString *)urlString param:(NSDictionary *)param complate:(LDXComplateBlock)complateBlock failed:(LDXFailedBlock)failedBlock {
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    request.HTTPMethod = @"POST";
    if (param) {
        NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingPrettyPrinted error:nil];
        request.HTTPBody = jsonData;
    }
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

+ (void)downloadUrlString:(NSString *)urlString param:(NSDictionary *)param downLoadFinish:(LDXDownloadFinishBlock)complateBlock failed:(LDXFailedBlock)failedBlock {
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

- (void)downloadUrlString:(NSString *)urlString param:(NSDictionary *)param progress:(LDXProgress)progress downLoadFinish:(LDXDownloadFinishBlock)complateBlock failed:(LDXFailedBlock)failedBlock {
    self.progress = progress;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSOperationQueue *op = [[NSOperationQueue alloc] init];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:op];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    if (param) {
        NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingPrettyPrinted error:nil];
        request.HTTPBody = jsonData;
    }
    
    __weak typeof(self)weakSelf = self;
    __block NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failedBlock(response, error);
        } else {
            complateBlock(response, location.absoluteString);
        }
        [weakSelf.tasks removeObject:task];
    }];
    [self.tasks addObject:task];
    [task resume];
}

- (void)cancelAllTask {
    for (NSURLSessionDownloadTask *task in self.tasks) {
        [task cancel];
    }
    [self.tasks removeAllObjects];
}

- (NSMutableArray<NSURLSessionDownloadTask *> *)taskArray {
    return self.tasks;
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

@end
