//
//  ViewController.m
//  uiapplication_effect
//
//  Created by evestorm on 16/10/9.
//  Copyright © 2016年 evestorm. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface ViewController ()<UNUserNotificationCenterDelegate>
// btn
@property (nonatomic,strong) UIButton *btn;
// app
@property (nonatomic,strong) UIApplication *app;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.btn];
    // 0. 获取应用程序的象征
    UIApplication *app = [UIApplication sharedApplication];
    _app = app;
    if (IS_IOS10_OR_LATER) {
        // 10.0之后版本
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionBadge|UNAuthorizationOptionSound|UNAuthorizationOptionAlert|UNAuthorizationOptionCarPlay completionHandler:^(BOOL granted, NSError * _Nullable error) {
            //在block中会传入布尔值granted，表示用户是否同意
            if (granted) {
                //如果用户权限申请成功，设置通知中心的代理
                [UNUserNotificationCenter currentNotificationCenter].delegate = self;
            }
        }];
        //通知内容类
        UNMutableNotificationContent * content = [UNMutableNotificationContent new];
        //设置通知请求发送时 app图标上显示的数字
        content.badge = @3;
        //设置通知的内容
        content.body = @"这是iOS10的新通知内容：普通的iOS通知";
        //默认的通知提示音
        content.sound = [UNNotificationSound defaultSound];
        //设置通知的副标题
        content.subtitle = @"这里是副标题";
        //设置通知的标题
        content.title = @"这里是通知的标题";
        //设置从通知激活app时的launchImage图片
        content.launchImageName = @"lun";
        //设置5S之后执行
        UNTimeIntervalNotificationTrigger * trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
        UNNotificationRequest * request = [UNNotificationRequest requestWithIdentifier:@"NotificationDefault" content:content trigger:trigger];
        //添加通知请求
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            
        }];
    } else {
        // 1. 设置应用程序图标的数字提示
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge) categories:nil];
        // 注册用户通知
        [app registerUserNotificationSettings:setting];
        [app setApplicationIconBadgeNumber:6];
    }
    // 2. 设置联网的提示
    app.networkActivityIndicatorVisible = YES;
    // 3. 设置状态栏
    // 在iOS7之后，状态栏默认交给控制器管理
    // 如果想让application管理，需要在info.plist中添加一个 View controller-based status bar appearance ,设置为no，再在下面设置为 YES
    //app.statusBarHidden = YES;
    [app setStatusBarHidden:YES withAnimation:(UIStatusBarAnimationSlide)];
    // 4. 打电话，发短信，打开网页

}

// 3. 隐藏状态栏
//- (BOOL)prefersStatusBarHidden {
//    return YES;
//}

// 4. 打电话，发短信，打开网页
- (void)openURL {
    // URL:资源的唯一标识
    // https://www.baidu.com
    // URL:协议头：//资源路径
    // 根据协议头判断用什么软件打开
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    if (IS_IOS10_OR_LATER) {
        [_app openURL:url options:nil completionHandler:nil];
    } else {
        [_app openURL:url];
    }
}

- (UIButton *)btn {
    if (!_btn) {
        _btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
        [_btn setTitle:@"打开网页" forState:(UIControlStateNormal)];
        [_btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        _btn.backgroundColor = [UIColor yellowColor];
        [_btn addTarget:self action:@selector(openURL) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _btn;
}


@end
