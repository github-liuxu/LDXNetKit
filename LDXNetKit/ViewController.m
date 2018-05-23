//
//  ViewController.m
//  LDXNetKit
//
//  Created by 刘东旭 on 2018/5/17.
//  Copyright © 2018年 刘东旭. All rights reserved.
//

#import "ViewController.h"
#import "LDXNetKit.h"
#import "LDXDownload.h"
#import "LDXDownloadManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    NSDictionary *dic = @{@"cmd":@"audios",
//                          @"page":@"1",
//                          @"pagesize":@30
//                          };
//    [LDXNetKit GETUrlString:@"http://viavia.madv360.com:9999/viavia.php" param:dic complate:^(NSURLResponse *response, NSDictionary *result) {
//
//    } failed:^(NSURLResponse *response, NSError *connectionError) {
//
//    }];

    LDXDownloadManager *manager = [LDXDownloadManager defaultManager];
    [manager addDownloadTask:@"http://cdn.awsbj0.fds.api.mi-img.com/vedio/3.mp3" param:nil progress:^(float progress) {
        NSLog(@"%f",progress);
    } fileName:nil downloadFinish:^(NSURLResponse *response, NSString *urlString) {
        NSLog(@"%@",urlString);
    } downFiald:^(NSURLResponse *response, NSError *connectionError) {
        NSLog(@"%@",connectionError);
    }];
    [manager addDownloadTask:@"http://cdn.awsbj0.fds.api.mi-img.com/vedio/1.mp3" param:nil progress:^(float progress) {
        NSLog(@"%f",progress);
    } fileName:nil downloadFinish:^(NSURLResponse *response, NSString *urlString) {
        NSLog(@"%@",urlString);
    } downFiald:^(NSURLResponse *response, NSError *connectionError) {
        NSLog(@"%@",connectionError);
    }];

    [manager startTaskWithIndex:0];
//    [manager startTaskWithIndex:1];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [manager pauseTaskWithIndex:0];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [manager startAllTasks];
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
