//
//  main.m
//  uiapplication_effect
//
//  Created by evestorm on 16/10/9.
//  Copyright © 2016年 evestorm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

// main -> UIApplicationMain
int main(int argc, char * argv[]) {
    @autoreleasepool {
        // 第三个参数：UIApplication类名或者子类的名称 nil == @"UIApplication"
        // 第四个参数：UIApplication的代理的代理名称: AppDelegate
        
        // NSStringFromClass:把类名转化字符串
        // NSStringFromClass好处：1.有提示功能 2.避免输入错误
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

// UIApplicationMain底层实现：
// 1. 根据principalClassName传递的类名创建UIApplication对象
// 2. 创建UIApplication代理对象，给UIApplication对象设置代理
// 3. 开启主运行事件循环，处理事件，保持程序一直运行
// 4. 加载info.plist，判断下是否指定了main，如果指定了，就会去加载
