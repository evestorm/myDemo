//
//  AppDelegate.m
//  uiapplication_effect
//
//  Created by evestorm on 16/10/9.
//  Copyright © 2016年 evestorm. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

// delegate可处理的事件包括：
// 1. 应用程序的生命周期事件（如程序启动和关闭）
// 2. 系统事件（如来电）
// 3. 内存警告

// AppDelegate：监听应用程序的生命周期
// 以下方法就是应用程序的生命周期方法

// 应用程序启动完成的时候就会调用AppDelegate的方法
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSLog(@"%s",__func__);
    return YES;
}

// 当应用程序即将失去焦点的时候调用
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    NSLog(@"%s",__func__);
}

// 当应用程序完全进入后台的时候调用
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"%s",__func__);
    
    // 保存一些信息，比如玩游戏时来电话即将进入后台时，保存一些进度之类的信息
}

// 当应用程序即将进入前台的时候调用
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    NSLog(@"%s",__func__);
}

// 当应用程序完全获取焦点的时候调用
// 只有当应用程序完全获取焦点的时候，才能够与用户进行交互
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"%s",__func__);
}

// 当应用程序关闭的时候调用
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"%s",__func__);
}


@end
