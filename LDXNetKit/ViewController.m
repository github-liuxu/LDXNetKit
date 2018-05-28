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
#import "LDXOperationDownloadManager.h"

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

//    LDXDownloadManager *manager = [LDXDownloadManager defaultManager];
//    [manager addDownloadTask:@"http://cdn.awsbj0.fds.api.mi-img.com/vedio/3.mp3" param:nil progress:^(float progress) {
//        NSLog(@"%f",progress);
//    } fileName:nil downloadFinish:^(NSURLResponse *response, NSString *urlString) {
//        NSLog(@"%@",urlString);
//    } downFiald:^(NSURLResponse *response, NSError *connectionError) {
//        NSLog(@"%@",connectionError);
//    }];
//    [manager addDownloadTask:@"http://cdn.awsbj0.fds.api.mi-img.com/vedio/1.mp3" param:nil progress:^(float progress) {
//        NSLog(@"%f",progress);
//    } fileName:nil downloadFinish:^(NSURLResponse *response, NSString *urlString) {
//        NSLog(@"%@",urlString);
//    } downFiald:^(NSURLResponse *response, NSError *connectionError) {
//        NSLog(@"%@",connectionError);
//    }];
//
//    [manager startTaskWithIndex:0];
//    [manager startTaskWithIndex:1];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [manager pauseTaskWithIndex:0];
//    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [manager startAllTasks];
//    });
    LDXOperationDownloadManager *manager = [LDXOperationDownloadManager defaultManager];
    [manager addDownloadTask:@"http://cdn.awsbj0.fds.api.mi-img.com/vedio/1.mp3" param:nil progress:^(float progress) {
        NSLog(@"111-->%f",progress);
    } fileName:nil downloadFinish:^(NSURLResponse *response, NSString *urlString) {
        NSLog(@"%@",urlString);
    } downFiald:^(NSURLResponse *response, NSError *connectionError) {
        NSLog(@"%@",connectionError);
    }];
    [manager addDownloadTask:@"http://cdn.awsbj0.fds.api.mi-img.com/vedio/2.mp3" param:nil progress:^(float progress) {
        NSLog(@"222->%f",progress);
    } fileName:nil downloadFinish:^(NSURLResponse *response, NSString *urlString) {
        NSLog(@"%@",urlString);
    } downFiald:^(NSURLResponse *response, NSError *connectionError) {
        NSLog(@"%@",connectionError);
    }];
    [manager addDownloadTask:@"http://cdn.awsbj0.fds.api.mi-img.com/vedio/3.mp3" param:nil progress:^(float progress) {
        NSLog(@"333->%f",progress);
    } fileName:nil downloadFinish:^(NSURLResponse *response, NSString *urlString) {
        NSLog(@"%@",urlString);
    } downFiald:^(NSURLResponse *response, NSError *connectionError) {
        NSLog(@"%@",connectionError);
    }];
    [manager addDownloadTask:@"http://cdn.awsbj0.fds.api.mi-img.com/vedio/4.mp3" param:nil progress:^(float progress) {
        NSLog(@"444->%f",progress);
    } fileName:nil downloadFinish:^(NSURLResponse *response, NSString *urlString) {
        NSLog(@"%@",urlString);
    } downFiald:^(NSURLResponse *response, NSError *connectionError) {
        NSLog(@"%@",connectionError);
    }];
    [manager addDownloadTask:@"http://cdn.awsbj0.fds.api.mi-img.com/vedio/5.mp3" param:nil progress:^(float progress) {
        NSLog(@"555->%f",progress);
    } fileName:nil downloadFinish:^(NSURLResponse *response, NSString *urlString) {
        NSLog(@"%@",urlString);
    } downFiald:^(NSURLResponse *response, NSError *connectionError) {
        NSLog(@"%@",connectionError);
    }];
    [manager addDownloadTask:@"http://cdn.awsbj0.fds.api.mi-img.com/vedio/6.mp3" param:nil progress:^(float progress) {
        NSLog(@"666->%f",progress);
    } fileName:nil downloadFinish:^(NSURLResponse *response, NSString *urlString) {
        NSLog(@"%@",urlString);
    } downFiald:^(NSURLResponse *response, NSError *connectionError) {
        NSLog(@"%@",connectionError);
    }];
    [manager addDownloadTask:@"http://cdn.awsbj0.fds.api.mi-img.com/vedio/7.mp3" param:nil progress:^(float progress) {
        NSLog(@"777->%f",progress);
    } fileName:nil downloadFinish:^(NSURLResponse *response, NSString *urlString) {
        NSLog(@"%@",urlString);
    } downFiald:^(NSURLResponse *response, NSError *connectionError) {
        NSLog(@"%@",connectionError);
    }];
//
//
//    __weak typeof (self)weakSelf = self;
//    [LDXNetKit GETUrlString:@"https://my.ishadowx.net" param:nil result:^(NSURLResponse *response, NSString *result) {
//        NSLog(@"%@", result);
//
//        NSMutableArray *ipsArr = [weakSelf ipsFromString:result];
//        NSLog(@"%@", ipsArr);
//        NSMutableArray *portsArr = [weakSelf portsFromString:result];
//        NSLog(@"%@", portsArr);
//        NSMutableArray *passwordsArr = [weakSelf passwordFromString:result];
//        NSLog(@"%@", passwordsArr);
//        NSMutableArray *methodsArr = [weakSelf methodFromString:result];
//        NSLog(@"%@", methodsArr);
//
//    } failed:^(NSURLResponse *response, NSError *connectionError) {
//
//    }];
    
    
}

- (NSMutableArray *)ipsFromString:(NSString *)string{
    NSString *pattern = @"Address.*</span> ";
    return [self excuteRegulerWithPattern:pattern FromString:string];
}

- (NSMutableArray *)portsFromString:(NSString *)string {
    NSString *pattern = @"Port:<span id=.*>\\d*";
    NSMutableArray *arr = [NSMutableArray array];
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray<NSTextCheckingResult *> *rs = [regularExpression matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    for (int i = 0; i<rs.count; i++) {
        NSTextCheckingResult *res = rs[i];
        NSString *a = [string substringWithRange:res.range];
        NSRegularExpression *portregularExpression = [NSRegularExpression regularExpressionWithPattern:@"\\d.*" options:NSRegularExpressionCaseInsensitive error:nil];
        NSArray<NSTextCheckingResult *> *ports = [portregularExpression matchesInString:a options:0 range:NSMakeRange(0, a.length)];
        for (NSTextCheckingResult *portResult in ports) {
            NSString *port = [a substringWithRange:portResult.range];
            [arr addObject:port];
        }
    }
    return arr;
}

- (NSMutableArray *)passwordFromString:(NSString *)string {
    NSString *pattern = @"Password:<span id=.*>.*\\d";
    NSMutableArray *arr = [NSMutableArray array];
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray<NSTextCheckingResult *> *rs = [regularExpression matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    for (int i = 0; i<rs.count; i++) {
        NSTextCheckingResult *res = rs[i];
        NSString *a = [string substringWithRange:res.range];
        NSRegularExpression *ipregularExpression = [NSRegularExpression regularExpressionWithPattern:@">.*" options:NSRegularExpressionCaseInsensitive error:nil];
        NSArray<NSTextCheckingResult *> *ips = [ipregularExpression matchesInString:a options:0 range:NSMakeRange(0, a.length)];
        for (NSTextCheckingResult *ipResult in ips) {
            NSString *ip = [a substringWithRange:NSMakeRange(ipResult.range.location+1, ipResult.range.length-2)];
            [arr addObject:ip];
        }
    }
    return arr;
}

- (NSMutableArray *)methodFromString:(NSString *)string {
    NSString *pattern = @"Method:.*</h4>";
    NSMutableArray *arr = [NSMutableArray array];
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray<NSTextCheckingResult *> *rs = [regularExpression matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    for (int i = 0; i<rs.count; i++) {
        NSTextCheckingResult *res = rs[i];
        NSString *a = [string substringWithRange:res.range];
        NSRegularExpression *ipregularExpression = [NSRegularExpression regularExpressionWithPattern:@".*<" options:NSRegularExpressionCaseInsensitive error:nil];
        NSArray<NSTextCheckingResult *> *ips = [ipregularExpression matchesInString:a options:0 range:NSMakeRange(0, a.length)];
        for (NSTextCheckingResult *ipResult in ips) {
            NSString *ip = [a substringWithRange:NSMakeRange(ipResult.range.location+7, ipResult.range.length-8)];
            [arr addObject:ip];
        }
    }
    return arr;
}

- (NSMutableArray *)excuteRegulerWithPattern:(NSString *)pattern FromString:(NSString *)string {
    NSMutableArray *arr = [NSMutableArray array];
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray<NSTextCheckingResult *> *rs = [regularExpression matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    for (int i = 0; i<rs.count; i++) {
        NSTextCheckingResult *res = rs[i];
        NSString *a = [string substringWithRange:res.range];
        NSRegularExpression *ipregularExpression = [NSRegularExpression regularExpressionWithPattern:@">.*<" options:NSRegularExpressionCaseInsensitive error:nil];
        NSArray<NSTextCheckingResult *> *ips = [ipregularExpression matchesInString:a options:0 range:NSMakeRange(0, a.length)];
        for (NSTextCheckingResult *ipResult in ips) {
            NSString *ip = [a substringWithRange:NSMakeRange(ipResult.range.location+1, ipResult.range.length-2)];
            [arr addObject:ip];
        }
    }
    return arr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
