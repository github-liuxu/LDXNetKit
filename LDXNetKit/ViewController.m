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
    
//    [LDXNetKit downloadUrlString:@"http://cdn.awsbj0.fds.api.mi-img.com/vedio/1.mp3" param:nil downLoadFinish:^(NSURLResponse *response, NSString *urlString) {
//        
//    } failed:^(NSURLResponse *response, NSError *connectionError) {
//        
//    }];
    
//    [[[LDXNetKit alloc] init] downloadUrlString:@"http://c1dn.awsbj0.fds.api.mi-img.com/vedio/1.mp3" param:nil progress:^(float progress) {
//        NSLog(@"%f",progress);
//    } downLoadFinish:^(NSURLResponse *response, NSString *urlString) {
//        NSLog(@"%@",urlString);
//    } failed:^(NSURLResponse *response, NSError *connectionError) {
//
//    }];
    
//    [LDXDownload downloadUrlString:@"http://cdn.awsbj0.fds.api.mi-img.com/vedio/1.mp3" param:nil progress:^(float progress) {
//        NSLog(@"----》%f",progress);
//    } downLoadFinish:^(NSURLResponse *response, NSString *urlString) {
//        NSLog(@"%@",urlString);
//    } failed:^(NSURLResponse *response, NSError *connectionError) {
//
//    }];
//    [LDXDownload downloadUrlString:@"http://cdn.awsbj0.fds.api.mi-img.com/vedio/2.mp3" param:nil progress:^(float progress) {
//        NSLog(@"---->>%f",progress);
//    } downLoadFinish:^(NSURLResponse *response, NSString *urlString) {
//        NSLog(@"%@",urlString);
//    } failed:^(NSURLResponse *response, NSError *connectionError) {
//
//    }];
    [LDXDownload downloadUrlString:@"http://cd1n.awsbj0.fds.api.mi-img.com/vedio/3.mp3" param:nil progress:^(float progress) {
        NSLog(@"----->>>%f",progress);
    } downLoadFinish:^(NSURLResponse *response, NSString *urlString) {
        NSLog(@"%@",urlString);
    } failed:^(NSURLResponse *response, NSError *connectionError) {
        NSLog(@"%@",connectionError);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
