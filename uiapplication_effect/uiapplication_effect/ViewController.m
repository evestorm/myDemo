//
//  ViewController.m
//  uiapplication_effect
//
//  Created by evestorm on 16/10/9.
//  Copyright © 2016年 evestorm. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 0. 获取应用程序的象征
    UIApplication *app = [UIApplication sharedApplication];
    // 1. 设置应用程序图标的数字提示
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge) categories:nil];
    // 注册用户通知
    [app registerUserNotificationSettings:setting];
    [app setApplicationIconBadgeNumber:9];
    // 2. 设置联网的提示
    // 3. 设置状态栏
    // 4. 打电话，发短信，打开网页
}


@end
