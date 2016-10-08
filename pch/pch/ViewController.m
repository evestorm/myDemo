//
//  ViewController.m
//  pch
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
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"pch文件中的宏ABC：%i",ABC);
    // [UIImage imageTest];
    
    // NSLog比较耗资源
    SWLog(@"%s",__func__);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
