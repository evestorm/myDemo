//
//  ViewController.m
//  Share
//
//  Created by evestorm on 2017/2/5.
//  Copyright © 2017年 eve. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>

@interface ViewController ()

@end

@implementation ViewController {
    UIButton *_systemBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _systemBtn = [UIButton buttonWithType:(UIButtonTypeContactAdd)];
    _systemBtn.frame = CGRectMake(20, 20, 100, 100);
    [_systemBtn addTarget:self action:@selector(modalSystemShare) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_systemBtn];
}

- (void)modalSystemShare {
    if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
        NSLog(@"平台不可用");
        return;
    }
    
    SLComposeViewController *vc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
    
    [vc setInitialText:@"代颜街"];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"logo_daiyanjie@2x.png" ofType:nil];
    [vc addImage:[UIImage imageWithContentsOfFile:path]];
    
    [self presentViewController:vc animated:YES completion:nil];
    
    // 监听用户点击
    vc.completionHandler = ^(SLComposeViewControllerResult result) {
        if (result == SLComposeViewControllerResultCancelled) {
            NSLog(@"用户点击了取消");
        } else {
            NSLog(@"点击了发布");
        }
    };
}


@end
