//
//  ViewController.m
//  plist
//
//  Created by evestorm on 16/10/8.
//  Copyright © 2016年 evestorm. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 获取当前版本号
    // 1. 解析info.plist
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Info.plist" ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSLog(@"%@",dict);
    
    // 2. 获取当前版本号
    NSString *version = dict[@"CFBundleShortVersionString"];
    NSLog(@"当前版本号:%@",version);
    
    
    // 第二种方式获取info.plist信息
    version = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    NSLog(@"第二种方式获取当前版本号:%@",version);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
