//
//  AppDelegate.m
//  uiwindow
//
//  Created by evestorm on 16/10/9.
//  Copyright © 2016年 evestorm. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property (strong, strong) UIWindow *window1;
@end

@implementation AppDelegate

// 哪些窗口：状态栏就是一个比较特殊的窗口，键盘也是一个窗口

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 1.创建窗口的对象
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor redColor];
    // 2.创建窗口的根控制器，并且赋值
    UIViewController *rootVC = [[UIViewController alloc] init];
    rootVC.view.backgroundColor = [UIColor yellowColor];
    self.window.rootViewController = rootVC;
    
    // 设置窗口层级
    // UIWindowLevelAlert   UIWindowLevelStatusBar  UIWindowLevelNormal
    // 高                    中                       低
    // 窗口层级可以做加减
    self.window.windowLevel = UIWindowLevelStatusBar + 1;
    
    // 3.显示窗口
    // 可以显示窗口  self.window.hidden = NO;
    // 成为应用程序的主窗口   application.keyWindow = self.window;
    [self.window makeKeyAndVisible];
    
    
    // 创建第二个窗口
    // 如果只是添加一个window，程序会崩溃。错误原因在于  AppDelegate 中 didFinishLaunchingWithOptions 未定义 rootViewController，Xcode7规定必须要有rootViewController。
    self.window1 = [[UIWindow alloc] initWithFrame:CGRectMake(50, 400, 200, 200)];
    self.window1.backgroundColor = [UIColor yellowColor];
    UIViewController *rootVC1 = [[UIViewController alloc] init];
    rootVC1.view.backgroundColor = [UIColor blueColor];
    self.window1.rootViewController = rootVC1;
    self.window1.hidden = NO;
    
    self.window1.windowLevel = UIWindowLevelAlert;
    
    // 显示键盘
    UITextField *textF = [[UITextField alloc] init];
    [textF becomeFirstResponder];
    // 如果想要弹出键盘，必须要把文本框添加到某个控件
    [self.window addSubview:textF];
    
    NSLog(@"%@",self.window);
    NSLog(@"%@",application.windows);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
